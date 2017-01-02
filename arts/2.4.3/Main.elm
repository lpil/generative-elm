module Main exposing (..)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Color exposing (Color)
import List


lineStyle : Color -> LineStyle
lineStyle color =
    { defaultLine
        | width = 5
        , color = color
    }


background : Form
background =
    rect 500 300
        |> filled (Color.rgb 180 180 180)


fadingBlack : Int -> Color
fadingBlack x =
    Color.rgba 0 0 0 ((toFloat (255 - (x * 10))) / 255)


growingWhite : Int -> Color
growingWhite x =
    Color.rgba 255 255 255 ((toFloat (x * 10)) / 255)


lines : Int -> (Int -> Color) -> Form
lines numLines makeColor =
    List.range 0 numLines
        |> List.map
            (\x ->
                segment ( 240, 0 ) ( -240, 0 )
                    |> traced (makeColor x |> lineStyle)
                    |> moveY (toFloat (140 - x * 10))
            )
        |> group


main : Html msg
main =
    [ background
    , lines 28 fadingBlack |> moveY 0
    , lines 27 growingWhite |> moveY -5
    ]
        |> collage 500 300
        |> Element.toHtml
