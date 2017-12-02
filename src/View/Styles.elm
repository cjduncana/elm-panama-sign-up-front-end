module View.Styles
    exposing
        ( Styles
            ( AcceptButton
            , BodyShadow
            , CancelButton
            , CheckboxLabel
            , ErrorMessage
            , Hairline
            , NoStyle
            , SignUp
            , SignUpInput
            , SignUpTextLabel
            , SignUpTitle
            , SubTitle
            , Title
            , TitleAccent
            )
        , Variations(Error)
        , styleSheet
        )

import Style exposing (StyleSheet)
import Style.Border
import Style.Color
import Style.Font
import Style.Shadow
import View.Colors
import View.Fonts


type Styles
    = AcceptButton
    | BodyShadow
    | CancelButton
    | CheckboxLabel
    | ErrorMessage
    | Hairline
    | SignUp
    | SignUpInput
    | SignUpTextLabel
    | SignUpTitle
    | SubTitle
    | Title
    | TitleAccent
    | NoStyle


type Variations
    = Error


styleSheet : StyleSheet Styles Variations
styleSheet =
    Style.styleSheet
        [ Style.style AcceptButton
            [ View.Fonts.primary
            , Style.Font.weight 400
            , Style.Border.all 1
            , Style.Color.border View.Colors.success
            , Style.Color.text View.Colors.success
            , Style.Font.size 13.5
            ]
        , Style.style BodyShadow [ Style.Shadow.simple ]
        , Style.style CancelButton
            [ View.Fonts.primary
            , Style.Font.weight 400
            , Style.Border.all 1
            , Style.Color.border View.Colors.cancelButton
            , Style.Color.text View.Colors.cancelButton
            , Style.Font.size 13.5
            ]
        , Style.style CheckboxLabel
            [ View.Fonts.primary
            , Style.Font.weight 500
            , Style.Color.text View.Colors.checkbox
            , Style.Font.size 12
            ]
        , Style.style ErrorMessage
            [ View.Fonts.primary
            , Style.Font.weight 400
            , Style.Color.text View.Colors.error
            , Style.Font.size 14
            ]
        , Style.style Hairline
            [ Style.Color.background View.Colors.titleAccent ]
        , Style.style SignUp
            [ Style.Color.background View.Colors.signUpBackground
            , Style.Shadow.simple
            ]
        , Style.style SignUpInput
            [ View.Fonts.primary
            , Style.Font.weight 400
            , Style.Color.text View.Colors.signUpInput
            , Style.Font.size 14
            , Style.Border.bottom 1
            , Style.Color.border View.Colors.signUpInput
            , Style.variation Error [ Style.Color.border View.Colors.error ]
            ]
        , Style.style SignUpTextLabel
            [ View.Fonts.primary
            , Style.Font.weight 400
            , Style.Color.text View.Colors.signUpInput
            , Style.Font.size 14
            ]
        , Style.style SignUpTitle
            [ View.Fonts.primary
            , Style.Font.weight 700
            , Style.Font.uppercase
            , Style.Color.text View.Colors.success
            , Style.Font.size 52
            ]
        , Style.style SubTitle
            [ View.Fonts.primary
            , Style.Font.weight 400
            , Style.Color.text View.Colors.titlePrimary
            , Style.Font.size 24
            ]
        , Style.style Title
            [ View.Fonts.primary
            , Style.Font.weight 400
            , Style.Color.text View.Colors.titlePrimary
            , Style.Font.size 80
            ]
        , Style.style TitleAccent
            [ Style.Font.weight 700
            , Style.Color.text View.Colors.titleAccent
            ]
        , Style.style NoStyle []
        ]
