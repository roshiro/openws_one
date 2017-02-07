import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode

main : Program Never Model Msg
main =
  Html.program
    { init = init
    -- , model = model
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { email: String
  , loggedIn: Bool
  }


-- INIT

init : (Model, Cmd Msg)
init =
  ( Model "" True
  , Cmd.none
  )


-- UPDATE

type Msg = Logout | LogoutUser (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Logout ->
      (Model "" False, logout)

    LogoutUser (Ok str) ->
      (Model "" False, Cmd.none)

    LogoutUser (Err e) ->
      (model, Cmd.none)

--  VIEW

view : Model -> Html Msg
view model =
  div []
    [ a
      [ onClick(Logout)
      , href "#"
      ]
      [ text "Logout"
      ]
    ]


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- HTTP
logout : Cmd Msg
logout =
  let
    url =
      "/users/sign_out"
  in
    Http.send LogoutUser (Http.get url decodeJsonResponse)

decodeJsonResponse : Decode.Decoder String
decodeJsonResponse =
  Decode.at ["name"] Decode.string
