module View exposing (view)

import Element.Attributes as Attrs
import Element exposing (Attribute, Element)
import Html exposing (Html)
import Model exposing (Model, Msg)
import View.Left exposing (left)
import View.Right exposing (right)
import View.Styles exposing (Styles(BodyShadow, NoStyle), Variations)
import View.Vectors


view : Model -> Html Msg
view model =
    Element.viewport View.Styles.styleSheet <| body model


body : Model -> Element Styles Variations Msg
body model =
    Element.el BodyShadow [ Attrs.center, Attrs.verticalCenter ] background
        |> Element.within [ content model, logoElement ]


content : Model -> Element Styles Variations Msg
content model =
    Element.row NoStyle bodySize [ left, right model ]


background : Element Styles variation msg
background =
    Element.html View.Vectors.background
        |> Element.el NoStyle bodySize


logoElement : Element Styles variation msg
logoElement =
    Element.html View.Vectors.logo
        |> Element.el NoStyle
            (List.map (\f -> f <| Attrs.px 35)
                [ Attrs.height
                , Attrs.width
                ]
            )
        |> Element.el NoStyle [ Attrs.padding 50 ]


bodySize : List (Attribute variation msg)
bodySize =
    [ fullHeight
    , Attrs.width <| Attrs.px 1366
    ]


fullHeight : Attribute variation msg
fullHeight =
    Attrs.height <| Attrs.px 768
