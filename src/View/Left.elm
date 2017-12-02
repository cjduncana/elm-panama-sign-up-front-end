module View.Left exposing (left)

import Element.Attributes as Attrs
import Element exposing (Element)
import View.Styles
    exposing
        ( Styles
            ( Hairline
            , NoStyle
            , SubTitle
            , Title
            , TitleAccent
            )
        )


left : Element Styles variation msg
left =
    Element.column NoStyle
        [ Attrs.height Attrs.fill
        , Attrs.width Attrs.fill
        ]
        [ title ]


title : Element Styles variation msg
title =
    Element.column NoStyle
        [ Attrs.height Attrs.fill
        , Attrs.paddingTop 175
        , Attrs.paddingBottom 160
        , Attrs.paddingLeft 85
        , Attrs.paddingRight 75
        ]
        [ Element.text "Welcome to"
            |> Element.el SubTitle []
        , Element.paragraph Title
            []
            [ Element.text "Elm"
                |> Element.el TitleAccent []
            , Element.text " Panamá"
            ]
            |> Element.h1 NoStyle []
        , Element.el NoStyle [ Attrs.height Attrs.fill ] Element.empty
        , Element.el Hairline
            [ Attrs.height <| Attrs.px 10
            , Attrs.width <| Attrs.px 145
            ]
            Element.empty
        ]
