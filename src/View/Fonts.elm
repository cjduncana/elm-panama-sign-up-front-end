module View.Fonts exposing (primary)

import Style exposing (Font, Property)
import Style.Font


primary : Property style variation
primary =
    Style.Font.typeface [ roboto, Style.Font.sansSerif ]


roboto : Font
roboto =
    Style.Font.importUrl
        { url = "https://fonts.googleapis.com/css?family=Roboto:400,500,700"
        , name = "Roboto"
        }
