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
import Harbour.BeRail.SFOS 1.0
import "../components"

Page {
    property int _numberOfDisturbances
    // For performance reasons we wait until the Page is fully loaded before doing an API request
    onStatusChanged: status===PageStatus.Active? api.getDisturbances(): undefined

    id: page

    SFOS {
        id: sfos
    }

    Connections {
        target: api
        onDisturbancesChanged: _numberOfDisturbances = api.disturbances.length
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        PullDownMenu {
            busy: api.busy

            MenuItem {
                //: About title
                //% "About"
                text: qsTrId("berail-about")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }

            MenuItem {
                //: Settings title
                //% "Settings"
                text: qsTrId("berail-settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }

            MenuItem {
                //: Liveboard title
                //% "Liveboard"
                //~ A list of all departing/arriving trains in a station.
                text: qsTrId("berail-liveboard")
                onClicked: pageStack.push(Qt.resolvedUrl("LiveboardPage.qml"))
            }
        }

        Column {
            id: column
            width: parent.width

            PageHeader {
                title: sfos.appNamePretty
                //% "The official iRail app"
                description: qsTrId("berail-official-irail-app")
            }

            ConnectionSelector {}

            MoreButton {
                //: Network interruptions
                //% "Disturbances (%L0)"
                text: qsTrId("berail-disturbances-number").arg(_numberOfDisturbances)
                enabled: _numberOfDisturbances > 0
                opacity: enabled? fadeInValue: fadeOutValue
                onClicked: pageStack.push(Qt.resolvedUrl("DisturbancesPage.qml"))
            }
        }
    }
}
