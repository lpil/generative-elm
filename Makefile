SHELL:=/bin/bash

ELM_PACKAGE=$(abspath node_modules/.bin/elm-package)
ELM_LIVE=$(abspath node_modules/.bin/elm-live)
ELM_MAKE=$(abspath node_modules/.bin/elm-make)

PROJECT_DIRS=$(wildcard arts/*/)
ELM_STUFF_DIRS=$(patsubst %/, %/elm-stuff, $(PROJECT_DIRS))
MAINS=$(patsubst %/, %/main.js, $(PROJECT_DIRS))

#
# Phony goals
#

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: node_modules $(ELM_STUFF_DIRS) ## Install deps

clean: ## Remove compiled output
	rm -rf dist arts/*/main.js

clean-deps: ## Remove downloaded deps
	rm -rf node_modules arts/*/{elm-stuff,node_modules}

start: ## Start the art specified by the `art` env var
	@[ "${art}" ] || (echo -e "ERROR: art env var not set\n" && exit 1)
	cd arts/$(art) && $(ELM_LIVE) Main.elm --open --path-to-elm-make=$(ELM_MAKE)

deploy: dist README.md ## Push the compiled site to gh-pages
	rm -rf /tmp/generative-elm-deploy
	mv dist /tmp/generative-elm-deploy
	cd /tmp/generative-elm-deploy && \
		git init && \
		git remote add origin git@github.com:lpil/generative-elm.git && \
		git checkout -b gh-pages && \
		git add --all && \
		git commit -m 'deploy' && \
		git push origin HEAD --force
	rm -rf /tmp/generative-elm-deploy


#
# Files
#

README.md: FORCE
	cd arts && \
		for art in *; \
		do \
			line="- [$$art: $$(cat $$art/title.txt)](https://github.com/lpil/generative-elm/tree/master/arts/$$art)"; \
			contents="$$contents\n$$line"; \
		done; \
		cat ../templates/README.md \
			| sed "s|{contents}|$$(echo $$contents)|" \
			> ../README.md

dist/index.html:
	mkdir -p dist
	cd arts && \
		for art in *; \
		do \
			line="<li><a href=\"$$art\">$$art: $$(cat $$art/title.txt)</a> - <a href=\"https://github.com/lpil/generative-elm/tree/master/arts/$$art\">[source]</a></li>"; \
			contents="$$contents\n$$line"; \
		done; \
		cat ../templates/index.html \
			| sed "s|{contents}|$$(echo $$contents)|" \
			> ../dist/index.html

dist: dist/index.html $(MAINS)
	rsync --recursive --quiet --include '*/' --include 'main.js' --exclude '*' --prune-empty-dirs arts/ dist/
	find dist/* -type d -exec cp -v templates/page.html {}/index.html \;
	tree dist

arts/%/main.js:
	cd $(dir $@) && $(ELM_MAKE) Main.elm --warn --output main.js

dist/%:
	mkdir -p $@

node_modules:
	yarn

%/elm-stuff:
	cd $(abspath $@/..) && $(ELM_PACKAGE) install --yes

FORCE:

.PHONY: help install clean clean-deps start deploy
