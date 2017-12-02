module View.Colors
    exposing
        ( cancelButton
        , checkbox
        , complimentaryBackground
        , error
        , logo
        , mainBackground
        , signUpBackground
        , signUpInput
        , success
        , titleAccent
        , titlePrimary
        )

import Color exposing (Color, rgb, white)


titlePrimary : Color
titlePrimary =
    white


titleAccent : Color
titleAccent =
    rgb 52 73 94


complimentaryBackground : Color
complimentaryBackground =
    rgb 96 181 204


logo : Color
logo =
    rgb 52 73 94


mainBackground : Color
mainBackground =
    rgb 242 242 242


signUpBackground : Color
signUpBackground =
    white


success : Color
success =
    rgb 127 209 59


signUpInput : Color
signUpInput =
    rgb 52 73 94


checkbox : Color
checkbox =
    rgb 240 173 0


cancelButton : Color
cancelButton =
    rgb 133 146 158


error : Color
error =
    rgb 204 0 0
