module Main exposing (..)

import Html exposing (Html)
import Time exposing (Time, every, millisecond)
import Types exposing (..)
import View


main : Program Never Model Msg
main =
    Html.program
        { init = ( { diameter = 10 }, Cmd.none )
        , view = View.root
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    every (1000 / 60 * millisecond) Tick


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( { model | diameter = min (model.diameter + 10) 400 }
    , Cmd.none
    )
