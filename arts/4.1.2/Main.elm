module Main exposing (..)

import Html exposing (Html)
import Collage exposing (..)
import Element
import List


point : Int -> ( Float, Float )
point i =
    let
        radiusStep =
            0.5

        radius =
            10 + (toFloat i * radiusStep)

        degs =
            i * 10

        rads =
            degs |> toFloat |> degrees

        x =
            radius * (rads |> cos)

        y =
            0 - radius * (rads |> sin)
    in
        ( x, y )


spiral : Form
spiral =
    List.range 0 (1440 / 10 |> truncate)
        |> List.map point
        |> path
        |> traced { defaultLine | width = 4, cap = Round }


main : Html msg
main =
    [ spiral ]
        |> collage 500 300
        |> Element.toHtml
