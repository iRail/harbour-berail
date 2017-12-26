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
import Harbour.BeRail.Models 1.0
import "../components"

Page {
    id: page
    // For performance reasons we wait until the Page is fully loaded before doing an API request
    onStatusChanged: status===PageStatus.Active && settings.savedLiveboardStation.length > 0? api.getLiveboard(settings.savedLiveboardStation, new Date(), IRail.Arrival): undefined

    API {
        id: api
        onLiveboardChanged: {
            liveboardListView.model = api.liveboard.vehicleListModel
            console.debug("Liveboard")
        }
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                //: When clicked, the user will see a list of station from which the user can choose one.
                //% "Select station"
                text: qsTrId("berail-select-station")
                onClicked: {
                    var _page = pageStack.push(Qt.resolvedUrl("../pages/StationSelectorPage.qml"));
                    _page.selected.connect(function(newStation) {
                        settings.savedLiveboardStation = newStation
                    });
                }
            }
        }

        LiveboardHeader {
            id: header
            anchors { top: parent.top; left: parent.left; right: parent.right }
            opacity: fadeSeeThroughValue
        }

        SilicaListView {
            id: liveboardListView
            anchors { top: header.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }
            clip: true // Only paint within it's borders
            opacity: api.busy? fadeOutValue: fadeSeeThroughValue
            Behavior on opacity { FadeAnimator {} }
            delegate: LiveboardDelegate {
                width: ListView.view.width
                enabled: false // Disabled until intermediate stops are ready
                onClicked: model.canceled? undefined: pageStack.push(Qt.resolvedUrl("TripDetailPage.qml"))
            }
        }

        BusyIndicator {
            anchors.centerIn: parent
            size: BusyIndicatorSize.Large
            running: Qt.application.active && api.busy
        }
    }
}
