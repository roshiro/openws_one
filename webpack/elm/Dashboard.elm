import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)

main =
  App.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model = Bool

model : Model
model =
  True

-- UPDATE

type Msg = Login | Logout

update : Msg -> Model -> Model
update msg model =
  case msg of
    Login ->
      True

    Logout ->
      False

--  VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Logout ] [ text "Logout" ] ]
