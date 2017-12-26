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

    API {
        id: api
        onDisturbancesChanged: disturbancesListView.model = api.disturbances.alertListModel
    }

    PageHeader {
        id: header
        anchors { top: parent.top; left: parent.left; right: parent.right }
        //: Network interruptions
        //% "Disturbances"
        title: qsTrId("berail-disturbances")
    }

    SilicaListView {
        id: disturbancesListView
        anchors { top: header.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }
        opacity: api.busy? fadeOutValue: fadeInValue
        Behavior on opacity { FadeAnimator {} }
        delegate: AlertListDelegate {}
    }

    BusyIndicator {
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: Qt.application.active && api.busy
    }
}
