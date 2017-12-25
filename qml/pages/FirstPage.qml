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
import Harbour.BeRail.API 1.0
import "../components"

Page {
    property int _numberOfDisturbances

    SFOS {
        id: sfos
    }

    API {
        id: api
        onDisturbancesChanged: _numberOfDisturbances = api.disturbances.length
        Component.onCompleted: api.getDisturbances()
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        PullDownMenu {
            MenuItem {
                //: About PullDownMenu item
                //% "About"
                text: qsTrId("berail-about")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }

            MenuItem {
                //: Liveboard PullDownMenu item
                //% "Liveboard"
                //~ A list of all departing/arriving trains in a station.
                text: qsTrId("berail-liveboard")
                onClicked: pageStack.push(Qt.resolvedUrl("LiveboardPage.qml"))
            }

            MenuItem {
                //: Settings PullDownMenu item
                //% "Settings"
                text: qsTrId("berail-settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
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
                onClicked: pageStack.push(Qt.resolvedUrl("DisturbancesPage.qml"))
            }
        }
    }
}
