module View exposing (root)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Color
import Types exposing (Model)


root : Model -> Html msg
root model =
    [ greyBackground
    , sizedCircle model.diameter
    , rings model.diameter
    ]
        |> collage 500 300
        |> Element.toHtml


greyBackground : Form
greyBackground =
    rect 500 300
        |> filled (Color.rgb 150 150 150)


sizedCircle : Float -> Form
sizedCircle diameter =
    group
        [ circle (diameter * 0.5) |> filled (Color.rgba 255 255 255 0.6)
        , circle (diameter * 0.5) |> outlined { defaultLine | width = 5 }
        ]


ring : Int -> Form
ring radius =
    circle (toFloat radius)
        |> outlined { defaultLine | color = Color.charcoal }


rings : Float -> Form
rings diameter =
    ((diameter - 1) / 5 / 2)
        |> truncate
        |> List.range 1
        |> List.map (\x -> x * 5)
        |> List.map ring
        |> group
