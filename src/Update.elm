module Update exposing (update)

import Animation
import Animation.Messenger
import Control
import Control.Debounce
import Http
import Json.Decode as Decode exposing (Decoder)
import Model exposing (Model, Msg)
import Regex exposing (Regex)
import Task
import Time
import Validation exposing (Validation(Dirty, Invalid, Pristine, Valid))
import VerbalExpressions


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Model.UpdateFirstName firstName ->
            ( { model | firstName = Dirty firstName }
            , validateInput Model.FirstNameDebouncer <| Model.ValidateFirstName firstName
            )

        Model.ValidateFirstName firstName ->
            ( { model | firstName = Validation.validate isNotEmpty firstName }
            , Cmd.none
            )

        Model.UpdateLastName lastName ->
            ( { model | lastName = Dirty lastName }
            , validateInput Model.LastNameDebouncer <| Model.ValidateLastName lastName
            )

        Model.ValidateLastName lastName ->
            ( { model | lastName = Validation.validate isNotEmpty lastName }
            , Cmd.none
            )

        Model.UpdateEmail email ->
            ( { model | email = Dirty email }
            , validateInput Model.EmailDebouncer <| Model.ValidateEmail email
            )

        Model.ValidateEmail email ->
            ( { model | email = Validation.validate emailValidator email }
            , Cmd.none
            )

        Model.UpdateNotifications isChecked ->
            ( { model | wantNotifications = isChecked }, Cmd.none )

        Model.ResetForm ->
            let
                newForm =
                    Model.initial
            in
                ( { newForm | animation = model.animation }, Cmd.none )

        Model.SubmitForm ->
            ( model
            , Valid Model.Person
                |> Validation.andMap model.firstName
                |> Validation.andMap model.lastName
                |> Validation.andMap model.email
                |> Validation.andMap (Valid model.wantNotifications)
                |> Validation.map (formCmd model.url)
                |> Validation.withDefault Cmd.none
            )

        Model.ResponseReceived result ->
            case result of
                Ok _ ->
                    ( { model
                        | animation =
                            Animation.interrupt
                                [ Animation.set
                                    [ Animation.display Animation.flex ]
                                , Animation.to [ Animation.opacity 1 ]
                                , Animation.Messenger.send Model.ResetForm
                                , Animation.wait (Time.second * 5)
                                , Animation.to [ Animation.opacity 0 ]
                                , Animation.set
                                    [ Animation.display Animation.none ]
                                ]
                                model.animation
                      }
                    , Cmd.none
                    )

                Err error ->
                    case Debug.log "Error" error of
                        Http.BadUrl _ ->
                            ( model, Cmd.none )

                        Http.Timeout ->
                            ( model, Cmd.none )

                        Http.NetworkError ->
                            ( model, Cmd.none )

                        Http.BadStatus { body } ->
                            -- TODO: Add Not Found error
                            case Decode.decodeString messageDecoder body of
                                Ok conflictError ->
                                    ( { model
                                        | email =
                                            Validation.invalidate identity
                                                conflictError
                                                model.email
                                      }
                                    , Cmd.none
                                    )

                                Err _ ->
                                    ( model, Cmd.none )

                        Http.BadPayload _ _ ->
                            ( model, Cmd.none )

        Model.FirstNameDebouncer control ->
            Control.update
                (\newState -> { model | firstNameDebouncer = newState })
                model.firstNameDebouncer
                control

        Model.LastNameDebouncer control ->
            Control.update
                (\newState -> { model | lastNameDebouncer = newState })
                model.lastNameDebouncer
                control

        Model.EmailDebouncer control ->
            Control.update
                (\newState -> { model | emailDebouncer = newState })
                model.emailDebouncer
                control

        Model.Animate message ->
            Animation.Messenger.update message model.animation
                |> Tuple.mapFirst
                    (\animation ->
                        { model | animation = animation }
                    )


isNotEmpty : String -> Result String String
isNotEmpty string =
    if String.isEmpty string then
        Err "This is a required field"
    else
        Ok string


emailValidator : String -> Result String String
emailValidator =
    isNotEmpty >> Result.andThen isValidEmail


isValidEmail : String -> Result String String
isValidEmail string =
    if Regex.contains emailRegex string then
        Ok string
    else
        Err "Need a valid email address"


emailRegex : Regex
emailRegex =
    VerbalExpressions.verex
        |> VerbalExpressions.startOfLine
        |> VerbalExpressions.somethingBut " "
        |> VerbalExpressions.followedBy "@"
        |> VerbalExpressions.somethingBut " "
        |> VerbalExpressions.followedBy "."
        |> VerbalExpressions.somethingBut " "
        |> VerbalExpressions.endOfLine
        |> VerbalExpressions.toRegex
        |> Regex.caseInsensitive


isModelValid : Model -> Bool
isModelValid { firstName, lastName, email } =
    Validation.isValid firstName
        && Validation.isValid lastName
        && Validation.isValid email


inputDebounce : Control.Wrapper Msg -> Msg -> Msg
inputDebounce msg =
    Control.Debounce.trailing msg Time.second


validateInput : Control.Wrapper Msg -> Msg -> Cmd Msg
validateInput msg =
    Task.succeed
        >> Task.perform (inputDebounce msg)


formCmd : String -> Model.Person -> Cmd Msg
formCmd url person =
    Model.personDecoder
        |> Http.post (personUrl url) (Http.jsonBody <| Model.perosnValue person)
        |> Http.send Model.ResponseReceived


personUrl : String -> String
personUrl url =
    url ++ "persons"


messageDecoder : Decoder String
messageDecoder =
    Decode.field "statusCode" Decode.int
        |> Decode.andThen
            (\statusCode ->
                if statusCode == 409 then
                    Decode.field "message" Decode.string
                else
                    Decode.fail "Not a Conflict Code"
            )
