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
import "./components"
import "./js/util.js" as Util

Page {

    Component.onDestruction: { // Save the values when user is done
        settings.rememberLiveboardStation = rememberLiveboardStation.checked
        if(!rememberLiveboardStation.checked) { // reset to default
            settings.lastLiveboardStation = ""
        }
        settings.favouriteStations = favouriteStations.checked
        settings.favouriteDepartStation = favouriteStations.checked? favouriteDepartStation.iconText: "" // reset to default
        settings.favouriteArriveStation = favouriteStations.checked? favouriteArriveStation.iconText: "" // reset to default
        settings.arriveFromGivenTime = arriveFromGivenTime.currentIndex
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: settingsColumn.height

        VerticalScrollDecorator {}

        Column {
            id: settingsColumn
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader { title: qsTr("Settings") }

            SectionHeader { text: qsTr("Routeplanner") }

            ComboBox {
                id: arriveFromGivenTime
                width: parent.width
                label: qsTr("Time is")
                menu: ContextMenu {
                    MenuItem { text: qsTr("departure") }
                    MenuItem { text: qsTr("arrival") }
                }
                currentIndex: settings.arriveFromGivenTime
                description: qsTr("Select here if you want to use the given time as either the time of arrival or departure.")
            }

            TextSwitch {
                id: favouriteStations
                text: qsTr("Enable favourite stations")
                description: qsTr("Travelling from/to work or school? Then is this option for you! Select your favourite stations below.")
                checked: settings.favouriteStations
            }

            GlassButton {
                id: favouriteDepartStation
                link: Qt.resolvedUrl("StationListPage.qml")
                type: 1
                iconSource: "qrc:///icons/icon-train.png"
                iconText: settings.favouriteDepartStation.length > 0? settings.favouriteDepartStation: qsTr("From")
                itemScale: 0.75
                enabled: favouriteStations.checked
                opacity: enabled? 1.0: 0.2

                Behavior on opacity { FadeAnimation {} }
            }
            GlassButton {
                id: favouriteArriveStation
                link: Qt.resolvedUrl("StationListPage.qml")
                type: 1
                iconSource: "qrc:///icons/icon-train.png"
                iconText: settings.favouriteArriveStation.length > 0? settings.favouriteArriveStation: qsTr("To")
                itemScale: 0.75
                enabled: favouriteStations.checked
                opacity: enabled? 1.0: 0.2

                Behavior on opacity { FadeAnimation {} }
            }

            SectionHeader { text: qsTr("Liveboard") }

            TextSwitch {
                id: rememberLiveboardStation
                text: qsTr("Remember liveboard station")
                description: qsTr("Save time by automatically saving your last used station!")
                checked: settings.rememberLiveboardStation
            }
        }
    }
}
