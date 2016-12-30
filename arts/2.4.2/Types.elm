module Types exposing (..)

import Time exposing (Time)


type alias Model =
    { diameter : Float }


type Msg
    = Tick Time
