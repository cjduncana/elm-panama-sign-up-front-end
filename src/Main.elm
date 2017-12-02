module Main exposing (main)

import Animation
import Html exposing (Html)
import Json.Decode exposing (Decoder, Value)
import Model exposing (Model, Msg)
import Update exposing (update)
import View exposing (view)


main : Program Value Model Msg
main =
    Html.programWithFlags
        { init = initial
        , update = update
        , subscriptions =
            \model ->
                Animation.subscription Model.Animate
                    [ model.animation ]
        , view = view
        }


initial : Value -> ( Model, Cmd Msg )
initial value =
    let
        model =
            Model.initial

        url =
            Json.Decode.decodeValue urlDecoder value
                |> Result.withDefault model.url
    in
        ( { model | url = url }, Cmd.none )


urlDecoder : Decoder String
urlDecoder =
    Json.Decode.field "url" Json.Decode.string
