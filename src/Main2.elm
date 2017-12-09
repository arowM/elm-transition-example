module Main exposing (..)

import Html exposing (Attribute, Html, div)
import Html.Attributes as Html exposing (attribute, class)
import Html.Events as Html
import Html.Keyed as Keyed


-- APP


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( { tab = TabA
      , showDatePicker = False
      }
    , Cmd.none
    )



-- MODEL


type alias Model =
    { tab : Tab
    , showDatePicker : Bool
    }


type Tab
    = TabA
    | TabB


toggleTab : Tab -> Tab
toggleTab tab =
    case tab of
        TabA ->
            TabB

        TabB ->
            TabA



-- UPDATE


type Msg
    = ToggleTab
    | ShowDatePicker
    | HideDatePicker


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleTab ->
            ( { model
                | tab = toggleTab model.tab
              }
            , Cmd.none
            )

        ShowDatePicker ->
            ( { model
                | showDatePicker = True
              }
            , Cmd.none
            )

        HideDatePicker ->
            ( { model
                | showDatePicker = False
              }
            , Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ class "tab"
        ]
        [ div
            [ class "tab_header"
            , attribute "role" "tablist"
            ]
            [ div
                [ class "tab_selector"
                , attribute "role" "tab"
                , ariaSelected <| model.tab == TabA
                , Html.onClick ToggleTab
                ]
                [ Html.text "Tab A"
                ]
            , div
                [ class "tab_selector"
                , attribute "role" "tab"
                , ariaSelected <| model.tab == TabB
                , Html.onClick ToggleTab
                ]
                [ Html.text "Tab B"
                ]
            ]
        , div
            [ class "tab_body"
            , attribute "role" "tabpanel"
            ]
            [ case model.tab of
                TabA ->
                    renderTabBodyA model

                TabB ->
                    renderTabBodyB model
            ]
        ]


renderTabBodyA : Model -> Html Msg
renderTabBodyA _ =
    unique "TabA" <|
        div
            []
            [ div
                [ class "field"
                ]
                [ div
                    [ class "field_title"
                    ]
                    [ Html.text "name"
                    ]
                , div
                    [ class "field_body"
                    ]
                    [ div
                        [ class "field_text"
                        ]
                        [ Html.text "Foo"
                        ]
                    ]
                ]
            , div
                [ class "field"
                ]
                [ div
                    [ class "field_title"
                    ]
                    [ Html.text "age"
                    ]
                , div
                    [ class "field_body"
                    ]
                    [ div
                        [ class "field_text"
                        ]
                        [ Html.text "20"
                        ]
                    ]
                ]
            ]


renderTabBodyB : Model -> Html Msg
renderTabBodyB model =
    unique "TabB" <|
        div
            []
            [ div
                [ class "field"
                ]
                [ div
                    [ class "field_title"
                    ]
                    [ Html.text "Some date"
                    ]
                , div
                    [ class "field_body"
                    ]
                    [ div
                        [ class "field_text"
                        ]
                        [ Html.text "2017-11-28"
                        ]
                    , div
                        [ class "field_edit"
                        , Html.onClick ShowDatePicker
                        ]
                        [ Html.text "Edit"
                        ]
                    ]
                ]
            , div
                [ class "popup"
                , ariaHidden <| not model.showDatePicker
                ]
                [ div
                    [ class "popup_body"
                    ]
                    [ div
                        [ class "popup_body_main"
                        ]
                        [ Html.text "This is a dummy date picker"
                        ]
                    , div
                        [ class "popup_body_footer"
                        ]
                        [ div
                            [ attribute "role" "button"
                            , class "button"
                            , Html.onClick HideDatePicker
                            ]
                            [ Html.text "Hide"
                            ]
                        ]
                    ]
                ]
            ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Helper functions


ariaSelected : Bool -> Attribute Msg
ariaSelected b =
    attribute "aria-selected" <|
        if b then
            "true"
        else
            "false"


ariaHidden : Bool -> Attribute Msg
ariaHidden b =
    attribute "aria-hidden" <|
        if b then
            "true"
        else
            "false"


{-| When `identifier` is changed, `child` is newly created instead of reusing exisiting HTML tags.
-}
unique : String -> Html msg -> Html msg
unique identifier child =
    Keyed.node "div"
        []
        [ ( identifier, child )
        ]
