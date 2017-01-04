module Main exposing (..)

import Html exposing (Html)
import Collage exposing (..)
import Element
import List
import Color


dot : Int -> Form
dot i =
    let
        radius =
            100

        degs =
            i * 10

        rads =
            degs |> toFloat |> degrees

        x =
            radius * (rads |> cos)

        y =
            radius * (rads |> sin)
    in
        circle 5
            |> filled Color.charcoal
            |> move ( x, y )


main : Html msg
main =
    List.range 0 72
        |> List.map dot
        |> collage 500 300
        |> Element.toHtml
