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
    property bool _loading: true

    Connections {
        target: api
        onDisturbancesChanged: {
            disturbancesListView.model = api.disturbances.alertListModel
            _loading = false;
        }
    }

    SilicaListView {
        id: disturbancesListView
        anchors.fill: parent
        header: ConnectionSelectorDelegate {}
        delegate: AlertListDelegate {}

        PullDownMenu {
            busy: _loading
            enabled: !busy

            MenuItem {
                //: About PullDownMenu item
                //% "About"
                text: qsTr("About")
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
    }
}
