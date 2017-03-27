import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode
import Task exposing (..)


type alias Model =
  { counter: Int }


type Msg
  =  GetData (Result Http.Error Int)
  | Get
  | Set

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case Debug.log "Err: " msg of
    GetData (Ok value)->
      (Model value , Cmd.none)

    GetData (Err _) ->
      (Model 999999, Cmd.none)

    Get ->
      (model, getCounter)

    Set ->
      (model, setCounter)


view : Model -> Html Msg
view model =
  div []
    [
    button [ onClick Get ] [ text "Count up" ]
    , div [] [ text (toString model.counter) ]
    , button [ onClick Set ] [ text "Reset" ]
    ]


decode : Decode.Decoder Int
decode = Decode.at ["data"] Decode.int

getCounter : Cmd Msg
getCounter =
  let
    url = "http://localhost:8080/counterapi/api/counter/"
  in
    Http.send GetData (Http.get url decode)

setCounter : Cmd Msg
setCounter =
  let
    url = "http://localhost:8080/counterapi/api/counter/1"
  in
    Http.send GetData (Http.request
      { method = "PUT"
      , headers = []
      , url = url
      , body = Http.emptyBody
      , expect = Http.expectJson decode
      , timeout = Nothing
      , withCredentials = False
      })


main =
  Html.program
    { init = (Model 0, Cmd.none)
    , view = view
    , update = update
    , subscriptions = \x -> Sub.none }
