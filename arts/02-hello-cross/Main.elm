module Main exposing (..)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Color


height : Float
height =
    300


width : Float
width =
    500


background : Form
background =
    rect width height
        |> filled (Color.greyscale 0.1)


line : ( Float, Float ) -> ( Float, Float ) -> Form
line origin destination =
    segment origin destination
        |> traced { defaultLine | width = 4, cap = Round }


faintCircle : Form
faintCircle =
    circle 50
        |> filled (Color.rgba 255 255 255 0.6)


cross : Form
cross =
    let
        left =
            70 - (width * 0.5)

        right =
            (width * 0.5) - 70

        top =
            (height * 0.5) - 70

        bottom =
            70 - (height * 0.5)
    in
        [ line ( left, top ) ( right, bottom )
        , line ( left, bottom ) ( right, top )
        ]
            |> group


main : Html msg
main =
    [ background
    , cross
    , faintCircle
    ]
        |> collage (truncate width) (truncate height)
        |> Element.toHtml
