import Html exposing (..)

-- MODEL

type alias LoggedIn = Bool

model : LoggedIn
model =
  True

-- UPDATE

type Msg = Login | Logout

update : Msg -> LoggedIn -> LoggedIn
update msg model =
  case msg of
    Login ->
      model True

    Logout ->
      model False

--  VIEW

view : LoggedIn -> Html Msg
view model = Html Msg
  div []
    [ a [ onClick Logout ] [ href "#" ] [ text "Logout" ] ]
