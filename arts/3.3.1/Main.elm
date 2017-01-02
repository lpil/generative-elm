module Main exposing (..)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Random
import List
import Noise


type alias Model =
    List ( Float, Float )


type Msg
    = Seed Int


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = (\_ -> Sub.none)
        , update = update
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    ( []
    , Random.generate Seed (Random.int 0 20)
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update (Seed x) _ =
    let
        ( table, _ ) =
            Noise.permutationTable (Random.initialSeed x)

        positions =
            List.range 0 500
                |> List.map (\x -> toFloat x * 0.05)
                |> List.map (Noise.noise2d table 0)
                |> accumulate
                |> toPositions
    in
        ( positions, Cmd.none )



-- VIEW


view : Model -> Html msg
view model =
    model
        |> path
        |> traced { defaultLine | width = 4 }
        |> moveX -250
        |> (\x -> [ x ])
        |> collage 500 300
        |> Element.toHtml


toPositions : List Float -> List ( Float, Float )
toPositions =
    List.indexedMap (\i x -> ( toFloat i, x ))


accumulate : List Float -> List Float
accumulate =
    List.scanl (+) 0
