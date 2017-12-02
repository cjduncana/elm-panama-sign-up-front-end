module View.Right exposing (right)

import Animation
import Element exposing (Attribute, Element)
import Element.Attributes as Attrs
import Element.Events as Events
import Element.Input as Input exposing (Option)
import Html.Attributes
import Model exposing (Model, Msg)
import Validation exposing (Validation)
import View.Styles exposing (Styles, Variations)
import View.Vectors


right : Model -> Element Styles Variations Msg
right model =
    signUp model
        |> Element.el View.Styles.NoStyle
            [ Attrs.height Attrs.fill
            , Attrs.width Attrs.fill
            , Attrs.paddingLeft 75
            , Attrs.paddingRight 40
            , Attrs.verticalCenter
            ]


signUp : Model -> Element Styles Variations Msg
signUp model =
    Element.row View.Styles.SignUp
        signUpAttrs
        [ signUpTitle, signUpForm model ]
        |> Element.el View.Styles.NoStyle []
        |> Element.within
            [ Element.column View.Styles.SignUp
                (Animation.render model.animation
                    |> List.map Attrs.toAttr
                    |> (++) signUpAttrs
                )
                [ successElement, thanks ]
            ]


successElement : Element Styles variation msg
successElement =
    Element.html View.Vectors.success
        |> Element.el View.Styles.NoStyle
            [ Attrs.height <| Attrs.px 147.524
            , Attrs.width <| Attrs.px 150.712
            ]


signUpAttrs : List (Attribute variation msg)
signUpAttrs =
    [ Attrs.height <| Attrs.px 430
    , Attrs.width <| Attrs.px 633
    , Attrs.padding 40
    , Attrs.spacing 40
    , Attrs.center
    , Attrs.verticalCenter
    ]


signUpTitle : Element Styles variation msg
signUpTitle =
    Element.text "Sign Up"
        |> Element.el View.Styles.SignUpTitle []


thanks : Element Styles variation msg
thanks =
    Element.text "Thanks!"
        |> Element.el View.Styles.SignUpTitle []


signUpForm : Model -> Element Styles Variations Msg
signUpForm model =
    Element.column View.Styles.NoStyle
        [ Attrs.width Attrs.fill
        , Attrs.spacing 30
        , Events.onSubmit Model.SubmitForm
        ]
        [ firstNameInput model.firstName
        , lastNameInput model.lastName
        , emailAddressInput model.email
        , subscribeCheckbox model.wantNotifications
        , formButtons
        ]
        |> Element.node "form"


firstNameInput : Validation String -> Element Styles Variations Msg
firstNameInput firstName =
    Input.text View.Styles.SignUpInput
        (inputAttrs firstName)
        { onChange = Model.UpdateFirstName
        , value = ""
        , label =
            Element.text "First Name"
                |> Element.el View.Styles.SignUpTextLabel []
                |> Input.labelAbove
        , options =
            [ errorMessage firstName
            , Input.autofill "off"
            , Input.focusOnLoad
            ]
        }


lastNameInput : Validation String -> Element Styles Variations Msg
lastNameInput lastName =
    Input.text View.Styles.SignUpInput
        (inputAttrs lastName)
        { onChange = Model.UpdateLastName
        , value = ""
        , label =
            Element.text "Last Name"
                |> Element.el View.Styles.SignUpTextLabel []
                |> Input.labelAbove
        , options = [ errorMessage lastName, Input.autofill "off" ]
        }


emailAddressInput : Validation String -> Element Styles Variations Msg
emailAddressInput email =
    Input.email View.Styles.SignUpInput
        (inputAttrs email)
        { onChange = Model.UpdateEmail
        , value = ""
        , label =
            Element.text "Email Address"
                |> Element.el View.Styles.SignUpTextLabel []
                |> Input.labelAbove
        , options = [ errorMessage email, Input.autofill "off" ]
        }


subscribeCheckbox : Bool -> Element Styles variation Msg
subscribeCheckbox isChecked =
    Input.checkbox View.Styles.NoStyle
        []
        { onChange = Model.UpdateNotifications
        , checked = isChecked
        , label =
            Element.text "Do you want to receive emails?"
                |> Element.el View.Styles.CheckboxLabel []
        , options = []
        }


formButtons : Element Styles variation Msg
formButtons =
    Element.row View.Styles.NoStyle
        [ Attrs.alignRight, Attrs.spacing 20 ]
        [ Element.text "Cancel"
            |> Element.button View.Styles.CancelButton
                [ Attrs.paddingXY 20 5
                , Events.onClick Model.ResetForm
                , Html.Attributes.type_ "reset"
                    |> Attrs.toAttr
                ]
        , Element.text "Accept"
            |> Element.button View.Styles.AcceptButton [ Attrs.paddingXY 20 5 ]
        ]


inputAttrs : Validation String -> List (Attribute Variations msg)
inputAttrs result =
    [ Validation.toString identity result
        -- TODO: Refactor this once this bug is solved
        -- https://github.com/elm-lang/virtual-dom/issues/107
        -- https://github.com/mdgriffith/style-elements/issues/91
        |> Html.Attributes.value
        |> Attrs.toAttr
    , Validation.isInvalid result
        |> Attrs.vary View.Styles.Error
    ]


errorMessage : Validation String -> Option Styles variation msg
errorMessage result =
    Validation.errorMessage result
        |> whenJust Element.text
        |> Element.el View.Styles.ErrorMessage []
        |> Input.errorBelow


whenJust :
    (a -> Element style variation msg)
    -> Maybe a
    -> Element style variation msg
whenJust =
    flip Element.whenJust
