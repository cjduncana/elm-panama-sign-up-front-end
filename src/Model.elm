module Model
    exposing
        ( Model
        , Msg
            ( Animate
            , EmailDebouncer
            , FirstNameDebouncer
            , LastNameDebouncer
            , ResetForm
            , ResponseReceived
            , SubmitForm
            , UpdateEmail
            , UpdateFirstName
            , UpdateLastName
            , UpdateNotifications
            , ValidateEmail
            , ValidateFirstName
            , ValidateLastName
            )
        , Person
        , initial
        , personDecoder
        , perosnValue
        )

import Animation
import Animation.Messenger
import Control exposing (Control)
import Http exposing (Error)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Validation exposing (Validation(Dirty, Invalid, Pristine, Valid))


type alias Model =
    { firstName : Validation String
    , lastName : Validation String
    , email : Validation String
    , wantNotifications : Bool
    , firstNameDebouncer : Control.State Msg
    , lastNameDebouncer : Control.State Msg
    , emailDebouncer : Control.State Msg
    , url : String
    , animation : Animation.Messenger.State Msg
    }


initial : Model
initial =
    { firstName = Pristine ""
    , lastName = Pristine ""
    , email = Pristine ""
    , wantNotifications = False
    , firstNameDebouncer = Control.initialState
    , lastNameDebouncer = Control.initialState
    , emailDebouncer = Control.initialState
    , url = "/"
    , animation =
        Animation.style
            [ Animation.opacity 0
            , Animation.display Animation.none
            ]
    }


type Msg
    = UpdateFirstName String
    | ValidateFirstName String
    | UpdateLastName String
    | ValidateLastName String
    | UpdateEmail String
    | ValidateEmail String
    | UpdateNotifications Bool
    | ResetForm
    | SubmitForm
    | ResponseReceived (Result Error Person)
    | FirstNameDebouncer (Control Msg)
    | LastNameDebouncer (Control Msg)
    | EmailDebouncer (Control Msg)
    | Animate Animation.Msg


type alias Person =
    { firstName : String
    , lastName : String
    , email : String
    , wantNotifications : Bool
    }


perosnValue : Person -> Value
perosnValue { firstName, lastName, email, wantNotifications } =
    Encode.object
        [ ( "firstName", Encode.string firstName )
        , ( "lastName", Encode.string lastName )
        , ( "email", Encode.string email )
        , ( "wantNotifications", Encode.bool wantNotifications )
        ]


personDecoder : Decoder Person
personDecoder =
    Decode.map4 Person
        (Decode.field "firstName" Decode.string)
        (Decode.field "lastName" Decode.string)
        (Decode.field "email" Decode.string)
        (Decode.field "wantNotifications" Decode.bool)
