module View exposing (root)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Color
import Types exposing (Model)


root : Model -> Html msg
root model =
    [ greyBackground
    , rings model.diameter
    ]
        |> collage 500 300
        |> Element.toHtml


greyBackground : Form
greyBackground =
    rect 500 300
        |> filled (Color.rgb 150 150 150)


ring : Int -> Form
ring radius =
    group
        [ circle (toFloat radius)
            |> outlined { defaultLine | color = Color.charcoal }
        , circle (toFloat radius)
            |> filled (Color.rgba 255 255 255 0.05)
        ]


rings : Float -> Form
rings diameter =
    (diameter / 5 / 2)
        |> truncate
        |> List.range 1
        |> List.map (\x -> x * 5)
        |> List.map ring
        |> group
