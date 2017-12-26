/*
*   This file is part of BeRail.
*
*   BeRail is free software: you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation, either version 3 of the License, or
*   (at your option) any later version.
*
*   BeRail is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with BeRail.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2
import Sailfish.Silica 1.0
import "../components"

Page {

    // Save the values when user is done
    Component.onDestruction: {
        settings.rememberLiveboardStation = rememberLiveboardStation.checked
        rememberLiveboardStation.checked? undefined: settings.savedLiveboardStation = "" // reset to default
        settings.favouriteStationsEnabled = favouriteStations.checked
        settings.favouriteFromStation = favouriteStations.checked? favouriteFromStation.iconText: "" // reset to default
        settings.favouriteToStation = favouriteStations.checked? favouriteToStation.iconText: "" // reset to default
        settings.timeIs = timeIs.currentIndex
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge

            //% "Settings"
            PageHeader { title: qsTrId("berail-settings") }

            //% "Trip planner"
            SectionHeader { text: qsTrId("berail-trip-planner") }

            ComboBox {
                id: timeIs
                width: parent.width
                //% "Time is"
                label: qsTrId("berail-time-is")
                menu: ContextMenu {
                    MenuItem {
                        //% "departure"
                        text: qsTrId("berail-departure")
                    }
                    MenuItem {
                        //% "arrival"
                        text: qsTrId("berail-arrival")
                    }
                }
                currentIndex: settings.timeIs
                //% "Select here if you want to use the given time as either the time of arrival or departure."
                description: qsTrId("berail-time-is-hint")
            }

            TextSwitch {
                id: favouriteStations
                //% "Enable favourite stations"
                text: qsTrId("berail-favourite-stations")
                //% "Travelling from/to work or school? Then is this option for you! Select your favourite stations below."
                description: qsTrId("berail-favourite-stations-hint")
                checked: settings.favouriteStationsEnabled
            }

            GlassButton {
                id: favouriteFromStation
                link: Qt.resolvedUrl("StationSelectorPage.qml")
                type: 1
                iconSource: "qrc:///icons/icon-train.png"
                iconText: settings.favouriteFromStation.length > 0?
                              settings.favouriteFromStation:
                              //% "From"
                              qsTrId("berail-from")
                enabled: favouriteStations.checked
                opacity: enabled? app.fadeInValue: app.fadeOutValue

                Behavior on opacity { FadeAnimator {} }
            }

            GlassButton {
                id: favouriteToStation
                link: Qt.resolvedUrl("StationSelectorPage.qml")
                type: 1
                iconSource: "qrc:///icons/icon-train.png"
                iconText: settings.favouriteToStation.length > 0?
                              settings.favouriteToStation:
                              //% "To"
                              qsTrId("To")
                enabled: favouriteStations.checked
                opacity: enabled? app.fadeInValue: app.fadeOutValue

                Behavior on opacity { FadeAnimator {} }
            }
        }
    }
}
