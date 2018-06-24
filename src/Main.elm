<<<<<<< HEAD
module Main exposing (..)
=======
port module Signup exposing (..)
>>>>>>> develop

import Html exposing (..)
import Html.Attributes exposing (href, class, style, type_, id)
import Material
import Material.Textfield as Textfield exposing(..)
import Material.Scheme
import Material.Button as Button
<<<<<<< HEAD
import Material.Options as Options exposing (css)
=======
import Material.Options as Options exposing (css, onInput)
>>>>>>> develop
import Material.Layout as Layout
import Material.Typography as Typo
import Material.Color as Color
import WebSocket

-- MODEL
type alias Mdl =
    Material.Model

type alias Model =
    { count : Int
<<<<<<< HEAD
=======
    , email : String
>>>>>>> develop
    , mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    }


<<<<<<< HEAD
model : Model
model =
    { count = 0
    , mdl =
        Material.model
        -- Boilerplate: Always use this initial Mdl model store.
    }
=======
>>>>>>> develop

model : Model
model =
    { count = 0
    , email = ""
    , mdl =
        Material.model
        -- Boilerplate: Always use this initial Mdl model store.
    }


<<<<<<< HEAD
-- ACTION, UPDATE

=======
>>>>>>> develop

-- ACTION, UPDATE
type Msg
    = Register
    | Reset
    | NewMessage String
<<<<<<< HEAD
    | NoOp
=======
    | ChangeEmail String
>>>>>>> develop
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
<<<<<<< HEAD
        Mdl msg_ ->
            Material.update Mdl msg_ model
        NoOp ->
            ( model, Cmd.none )




view : Model -> Html Msg
view model = Layout.render Mdl model.mdl
  [ Layout.fixedHeader
  ]
  { header = [  ]
  , drawer = [  ]
  , tabs = ([ text "Milk", text "Oranges" ], [])
  , main = [ mainContent model ]
  }
=======
        ChangeEmail mail ->
            ( { model | email = mail } , Cmd.none )
        Mdl msg_ ->
            Material.update Mdl msg_ model
        

view : Model -> Html Msg
view model = mainContent model
>>>>>>> develop

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
<<<<<<< HEAD
=======
                , Options.onInput (ChangeEmail)
>>>>>>> develop
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
<<<<<<< HEAD
            , text (toString model.count)
=======
            , dump model
>>>>>>> develop
            ]
        ]            
        |> Material.Scheme.topWithScheme Color.Teal Color.LightBlue

<<<<<<< HEAD
=======
dump : Model -> Html msg
dump model = div []
            [ text (String.concat ["Count: ", (toString model.count)] )
            , text (String.concat ["Email: ", model.email] )
            ]
>>>>>>> develop

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