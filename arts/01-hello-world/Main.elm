module Main exposing (..)

import Html exposing (Html)
import Color exposing (Color, blue)
import Collage exposing (..)
import Element


main : Html msg
main =
    Element.toHtml <|
        collage 300
            300
            [ circle 50 |> filled blue |> move ( 25, 25 ) ]
