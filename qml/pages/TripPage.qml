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
*   along with BeRail. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Harbour.BeRail.Models 1.0
import "../components"
import "../js/util.js" as Utils

Page {
    property string from
    property string to
    property date date

    id: page

    // For performance reasons we wait until the Page is fully loaded before doing an API request
    onStatusChanged: status===PageStatus.Active? api.getConnections(from, to, IRail.Arrival, date, Utils.convertTransportType(settings.transportFilter)): undefined

    Connections {
        target: api
        onConnectionsChanged: connectionsListView.model = api.connections
    }

    SilicaListView {
        id: connectionsListView
        anchors.fill: parent
        opacity: api.busy? fadeOutValue: fadeInValue
        Behavior on opacity { FadeAnimator {} }
        header: PageHeader {
            //: The planner for the user it's trips between two stations
            //% "Trip planner"
            title: qsTrId("berail-trip-planner")
        }
        delegate: TripDelegate {
            width: ListView.view.width
            vias: model.vias
        }
    }
}
