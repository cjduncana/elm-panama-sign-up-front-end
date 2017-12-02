module View.Vectors exposing (background, logo, success)

import Html exposing (Html)
import TypedSvg as Svg
import TypedSvg.Attributes as Attrs
import TypedSvg.Core exposing (Attribute)
import TypedSvg.Types
    exposing
        ( Fill(Fill, FillNone)
        , Length(Num, Px)
        , Transform(Matrix)
        )
import View.Colors as Color


background : Html msg
background =
    Svg.svg
        [ Attrs.viewBox 0 0 1366 768
        , Attrs.height <| Px 768
        , Attrs.width <| Px 1366
        ]
        [ Svg.g []
            [ Svg.g []
                [ Svg.path
                    [ Attrs.d "M811.06 0L1366 0L1366 768L811.06 768L811.06 0Z"
                    , mainBackgroundColor
                    ]
                    []
                ]
            , Svg.g []
                [ Svg.path
                    [ Attrs.d "M0 0L813 0L813 768L0 768L0 0Z"
                    , complimentaryBackgroundColor
                    ]
                    []
                ]
            , Svg.g []
                [ Svg.path
                    [ Attrs.d "M813 768L913 0L813 0L813 768Z"
                    , complimentaryBackgroundColor
                    ]
                    []
                ]
            ]
        ]


mainBackgroundColor : Attribute msg
mainBackgroundColor =
    Attrs.fill <| Fill Color.mainBackground


complimentaryBackgroundColor : Attribute msg
complimentaryBackgroundColor =
    Attrs.fill <| Fill Color.complimentaryBackground


logo : Html msg
logo =
    Svg.svg
        [ Attrs.x <| Px 0
        , Attrs.y <| Px 0
        , Attrs.viewBox 0 0 323.141 322.95
        ]
        [ Svg.g []
            [ Svg.polygon
                [ logoColor
                , Attrs.points
                    [ ( 161.649, 152.782 )
                    , ( 231.514, 82.916 )
                    , ( 91.783, 82.916 )
                    ]
                ]
                []
            , Svg.polygon
                [ logoColor
                , Attrs.points
                    [ ( 8.867, 0 )
                    , ( 79.241, 70.375 )
                    , ( 232.213, 70.375 )
                    , ( 161.838, 0 )
                    ]
                ]
                []
            , Svg.rect
                [ logoColor
                , Num 192.99
                    |> Attrs.x
                , Num 107.392
                    |> Attrs.y
                , Matrix 0.7071 0.7071 -0.7071 0.7071 186.4727 -127.2386
                    |> List.singleton
                    |> Attrs.transform
                , Num 107.676
                    |> Attrs.width
                , Num 108.167
                    |> Attrs.height
                ]
                []
            , Svg.polygon
                [ logoColor
                , Attrs.points
                    [ ( 323.298, 143.724 )
                    , ( 323.298, 0 )
                    , ( 179.573, 0 )
                    ]
                ]
                []
            , Svg.polygon
                [ logoColor
                , Attrs.points
                    [ ( 152.781, 161.649 )
                    , ( 0, 8.868 )
                    , ( 0, 314.432 )
                    ]
                ]
                []
            , Svg.polygon
                [ logoColor
                , Attrs.points
                    [ ( 255.522, 246.655 )
                    , ( 323.298, 314.432 )
                    , ( 323.298, 178.879 )
                    ]
                ]
                []
            , Svg.polygon
                [ logoColor
                , Attrs.points
                    [ ( 161.649, 170.517 )
                    , ( 8.869, 323.298 )
                    , ( 314.43, 323.298 )
                    ]
                ]
                []
            ]
        ]


logoColor : Attribute msg
logoColor =
    Attrs.fill <| Fill Color.logo


success : Html msg
success =
    Svg.svg
        [ Attrs.x <| Px 0
        , Attrs.y <| Px 0
        , Attrs.viewBox 0 0 156.7 154.5
        ]
        [ Svg.g []
            [ Svg.path
                (Attrs.d "M148,56.4c1.9,6.6,3,13.6,3,20.9c0,40.7-33,73.8-73.8,73.8S3.5,118,3.5,77.3s33-73.8,73.8-73.8c20.4,0,38.8,8.3,52.2,21.6"
                    :: successAttrs
                )
                []
            , Svg.polyline
                (Attrs.points
                    [ ( 48.6, 72.3 )
                    , ( 77.3, 100.9 )
                    , ( 154.2, 24 )
                    ]
                    :: successAttrs
                )
                []
            ]
        ]


successAttrs : List (Attribute msg)
successAttrs =
    [ Attrs.fill FillNone
    , Attrs.stroke Color.success
    , Attrs.strokeWidth <| Px 7
    , Attrs.strokeMiterlimit "10"
    ]
