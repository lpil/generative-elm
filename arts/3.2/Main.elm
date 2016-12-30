module Main exposing (..)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Random as Random
import List as List


type alias Model =
    List Int


type Msg
    = RandomInts (List Int)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = (\_ -> Sub.none)
        , update = (\(RandomInts result) _ -> ( result, Cmd.none ))
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    ( []
    , Random.generate RandomInts (Random.list 50 (Random.int -10 10))
    )


toPositions : List Int -> List ( Float, Float )
toPositions =
    List.indexedMap (\i x -> ( toFloat i * 10, toFloat x ))


accumulate : List Int -> List Int
accumulate =
    List.scanl (+) 0


view : Model -> Html msg
view model =
    model
        |> accumulate
        |> toPositions
        |> path
        |> traced { defaultLine | width = 4 }
        |> moveX -250
        |> (\x -> [ x ])
        |> collage 500 300
        |> Element.toHtml
