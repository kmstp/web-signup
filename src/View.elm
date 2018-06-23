module View exposing (..)

import Models exposing (Model)
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Msgs exposing (Msg)

view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working 2!" ]
        ]