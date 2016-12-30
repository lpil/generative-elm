module Main exposing (..)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Color


main : Html msg
main =
    Element.toHtml <|
        collage 300
            300
            [ circle 50 |> filled Color.blue |> move ( 25, 25 ) ]
