port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, style, type_, id)
import Material
import Material.Textfield as Textfield exposing(..)
import Material.Scheme
import Material.Button as Button
import Material.Options as Options exposing (css, onInput)
import Material.Layout as Layout
import Material.Typography as Typo
import Material.Color as Color
import WebSocket

-- MODEL
type alias Mdl =
    Material.Model

type alias Model =
    { count : Int
    , email : String
    , mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    }



model : Model
model =
    { count = 0
    , email = ""
    , mdl =
        Material.model
        -- Boilerplate: Always use this initial Mdl model store.
    }



-- ACTION, UPDATE
type Msg
    = Register
    | Reset
    | NewMessage String
    | ChangeEmail String
    | Mdl (Material.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Register ->
            ( model
            , WebSocket.send "ws://echo.websocket.org" (toString  model.count)
            )

        Reset ->
            ( { model | count = 0 }
            , Cmd.none
            )
        NewMessage str ->
            let _ = Debug.log "New message: " str
            in
            (
              { model | count = model.count - 1}
            , Cmd.none
            )
        ChangeEmail mail ->
            ( { model | email = mail } , Cmd.none )
        Mdl msg_ ->
            Material.update Mdl msg_ model
        

view : Model -> Html Msg
view model = mainContent model

mainContent : Model -> Html Msg
mainContent model =
      div []
        [ Options.styled p
          [ Typo.display1 ]
          [ text "Registration" ]
        , div []
            [ div []
              [ Textfield.render Mdl [1] model.mdl
                [ Textfield.label "Name"
                , Textfield.floatingLabel
                , Textfield.text_
                ]
                []
              ]
            , div []
              [ Textfield.render Mdl [2] model.mdl
                [ Textfield.label "Email"
                , Textfield.floatingLabel
                , Textfield.text_
                , Options.onInput (ChangeEmail)
                ]
                []
              ]
            , div []
              [ Textfield.render Mdl [3] model.mdl
                [ Textfield.label "Password"
                , Textfield.floatingLabel
                , Textfield.password
                ]
                []
              ]
            , div []
              [ Button.render Mdl [4] model.mdl
                [ Button.raised
                , Button.ripple
                , Options.onClick Register
                ]
                [ text "Registration"]
              ]
            , dump model
            ]
        ]            
        |> Material.Scheme.topWithScheme Color.Teal Color.LightBlue

dump : Model -> Html msg
dump model = div []
            [ text (String.concat ["Count: ", (toString model.count)] )
            , text (String.concat ["Email: ", model.email] )
            ]

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "ws://echo.websocket.org" NewMessage

main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = subscriptions
        , update = update
    }