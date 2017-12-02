module Validation
    exposing
        ( Validation(Dirty, Invalid, Pristine, Valid)
        , andMap
        , errorMessage
        , invalidate
        , isInvalid
        , isValid
        , map
        , map4
        , toString
        , validate
        , withDefault
        )


type Validation value
    = Pristine String
    | Dirty String
    | Invalid String String
    | Valid value


validate : (String -> Result String value) -> String -> Validation value
validate validator input =
    case validator input of
        Ok value ->
            Valid value

        Err error ->
            Invalid error input


toString : (value -> String) -> Validation value -> String
toString function validation =
    case validation of
        Pristine input ->
            input

        Dirty input ->
            input

        Invalid _ input ->
            input

        Valid value ->
            function value


isValid : Validation value -> Bool
isValid validation =
    case validation of
        Pristine _ ->
            False

        Dirty _ ->
            False

        Invalid _ _ ->
            False

        Valid _ ->
            True


isInvalid : Validation value -> Bool
isInvalid validation =
    case validation of
        Pristine _ ->
            False

        Dirty _ ->
            False

        Invalid _ _ ->
            True

        Valid _ ->
            False


errorMessage : Validation value -> Maybe String
errorMessage validation =
    case validation of
        Pristine _ ->
            Nothing

        Dirty _ ->
            Nothing

        Invalid error _ ->
            Just error

        Valid _ ->
            Nothing


map : (a -> value) -> Validation a -> Validation value
map function va =
    case va of
        Pristine input ->
            Pristine input

        Dirty input ->
            Dirty input

        Invalid error input ->
            Invalid error input

        Valid value ->
            Valid (function value)


map2 : (a -> b -> value) -> Validation a -> Validation b -> Validation value
map2 function va vb =
    case va of
        Pristine input ->
            Pristine input

        Dirty input ->
            Dirty input

        Invalid error input ->
            Invalid error input

        Valid a ->
            case vb of
                Pristine input ->
                    Pristine input

                Dirty input ->
                    Dirty input

                Invalid error input ->
                    Invalid error input

                Valid b ->
                    Valid (function a b)


andMap : Validation a -> Validation (a -> b) -> Validation b
andMap =
    map2 (|>)


map3 : (a -> b -> c -> value) -> Validation a -> Validation b -> Validation c -> Validation value
map3 function va vb vc =
    Valid function
        |> andMap va
        |> andMap vb
        |> andMap vc


map4 : (a -> b -> c -> d -> value) -> Validation a -> Validation b -> Validation c -> Validation d -> Validation value
map4 function va vb vc vd =
    Valid function
        |> andMap va
        |> andMap vb
        |> andMap vc
        |> andMap vd


invalidate : (value -> String) -> String -> Validation value -> Validation value
invalidate toString error validation =
    case validation of
        Pristine input ->
            Invalid error input

        Dirty input ->
            Invalid error input

        Invalid _ input ->
            Invalid error input

        Valid value ->
            Invalid error <| toString value


withDefault : value -> Validation value -> value
withDefault default validated =
    case validated of
        Pristine input ->
            default

        Dirty input ->
            default

        Invalid error input ->
            default

        Valid value ->
            value
