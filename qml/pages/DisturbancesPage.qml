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
    property bool _loading: true
    // For performance reasons we wait until the Page is fully loaded before doing an API request
    onStatusChanged: status===PageStatus.Active? api.getDisturbances(): undefined

    Connections {
        target: api
        onDisturbancesChanged: disturbancesListView.model = api.disturbances.alertListModel
    }

    SilicaListView {
        id: disturbancesListView
        anchors.fill: parent
        opacity: api.busy? fadeOutValue: fadeInValue
        Behavior on opacity { FadeAnimator {} }
        header: PageHeader {
            //: Network interruptions
            //% "Disturbances"
            title: qsTrId("berail-disturbances")
        }
        delegate: AlertListDelegate {
            width: ListView.view.width
            enabled: model.hasLink
            onClicked: enabled? Qt.openUrlExternally(model.link): undefined
        }
    }

    BusyIndicator {
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: Qt.application.active && api.busy
    }
}
