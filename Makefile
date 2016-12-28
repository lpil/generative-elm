SHELL:=/bin/bash

ELM_PACKAGE=$(abspath node_modules/.bin/elm-package)
ELM_LIVE=$(abspath node_modules/.bin/elm-live)
ELM_MAKE=$(abspath node_modules/.bin/elm-make)

PROJECT_DIRS=$(wildcard arts/*/)
NODE_MODULES_DIRS=$(patsubst %/, %/node_modules, $(PROJECT_DIRS))
ELM_STUFF_DIRS=$(patsubst %/, %/elm-stuff, $(PROJECT_DIRS))


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


install: node_modules $(NODE_MODULES_DIRS) $(ELM_STUFF_DIRS) ## Install deps

clean-deps: ## Remove downloaded deps
	rm -rf node_modules arts/*/{elm-stuff,node_modules}

start: ## Start the art specified by the `art` env var
	@[ "${art}" ] || (echo -e "ERROR: art env var not set\n" && exit 1)
	cd $(art) && $(ELM_LIVE) Main.elm --open --path-to-elm-make=$(ELM_MAKE)


node_modules:
	yarn

%/node_modules:
	cd $(abspath $@/..) && yarn

%/elm-stuff:
	cd $(abspath $@/..) && $(ELM_PACKAGE) install --yes

.PHONY: install clean-all
