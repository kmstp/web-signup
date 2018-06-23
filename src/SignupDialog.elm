module SignupDialog exposing (..)

import Html exposing (Html)
import Model exposing (Model)


dialog : Model -> Html Msg
dialog model =
    Dialog.view
        []
        [ Dialog.title [] [ text "Greetings" ]
        , Dialog.content []
            [ p [] [ text "A strange game—the only winning move is not to play." ]
            , p [] [ text "How about a nice game of chess?" ]
            ]
        , Dialog.actions []
            [ Button.render Mdl
                [ 0 ]
                model.mdl
                [ Dialog.closeOn "click" ]
                [ text "Chess" ]
            , Button.render Mdl
                [ 1 ]
                model.mdl
                [ Button.disabled ]
                [ text "GTNW" ]
            ]
        ]
