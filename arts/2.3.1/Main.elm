module Main exposing (..)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Color
import Time exposing (Time, every, millisecond)


type alias Model =
    { diameter : Float }


type Msg
    = Tick Time


main : Program Never Model Msg
main =
    Html.program
        { init = ( { diameter = 10 }, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    every (1000 / 60 * millisecond) Tick


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( { model | diameter = min (model.diameter + 10) 400 }
    , Cmd.none
    )


view : Model -> Html msg
view model =
    [ greyBackground
    , sizedCircle model.diameter
    ]
        |> collage 500 300
        |> Element.toHtml
