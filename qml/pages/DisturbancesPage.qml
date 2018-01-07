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

import QtQuick 2.0
import Sailfish.Silica 1.0
import Harbour.BeRail.API 1.0
import "../components"

Page {
    // For performance reasons we wait until the Page is fully loaded before doing an API request
    onStatusChanged: status===PageStatus.Active? getData(): undefined

    function getData() {
        api.getDisturbances()
    }

    Connections {
        target: app
        onNetworkStatusChanged: app.networkStatus? getData(): undefined
    }

    Connections {
        target: api
        onDisturbancesChanged: {
            placeholder.enabled = false
            disturbancesListView.model = api.disturbances.alertListModel
        }
        onErrorOccurred: placeholder.enabled = true
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: parent.width

            PageHeader {
                //: Network interruptions
                //% "Disturbances"
                title: qsTrId("berail-disturbances")
            }

            SilicaListView {
                id: disturbancesListView
                width: parent.width
                height: contentHeight
                opacity: api.busy? fadeOutValue: fadeInValue
                visible: !placeholder.enabled
                Behavior on opacity { FadeAnimator {} }
                delegate: AlertListDelegate {
                    width: ListView.view.width
                    enabled: model.hasLink
                    onClicked: enabled? Qt.openUrlExternally(model.link): undefined
                }
            }
        }

        ViewPlaceholder {
            id: placeholder
            enabled: false
            //: To acknowledging a minor mistake 'Oops' is used
            //% "Oops!"
            text: qsTrId("berail-oops")
            //% "Something went wrong, please try again later"
            hintText: qsTrId("berail-oops-hint")
        }
    }

    BusyIndicator {
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: Qt.application.active && api.busy
    }
}
