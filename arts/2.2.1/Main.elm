module Main exposing (..)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Color


lineStyle : LineStyle
lineStyle =
    { defaultLine
        | width = 4
        , cap = Round
        , color = (Color.rgb 130 0 0)
    }


background : Form
background =
    rect 500 300
        |> filled (Color.greyscale 0.1)


line : ( Float, Float ) -> ( Float, Float ) -> Form
line origin destination =
    segment origin destination |> traced lineStyle


faintCircle : Form
faintCircle =
    group
        [ circle 25 |> filled (Color.rgba 255 255 255 0.6)
        , circle 25 |> outlined lineStyle
        ]


cross : Form
cross =
    group
        [ line ( -70, -70 ) ( 70, 70 )
        , line ( -70, 70 ) ( 70, -70 )
        ]


main : Html msg
main =
    [ background
    , cross
    , faintCircle
    ]
        |> collage 500 300
        |> Element.toHtml
