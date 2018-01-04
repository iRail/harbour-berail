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

Page {
    property var _liveboard
    property date _date: new Date()
    property int _arrdep: IRail.Departure
    property bool _showHint: settings.savedLiveboardStation.length == 0
    on_ShowHintChanged: _showHint? hint.start(): hint.stop()

    id: page
    // For performance reasons we wait until the Page is fully loaded before doing an API request
    onStatusChanged: status===PageStatus.Active? getData() : undefined

    function getData() {
        if(settings.savedLiveboardStation.length > 0)
        {
            _date = new Date() // Refresh the current time
            api.getLiveboard(settings.savedLiveboardStation, _date, _arrdep)
        }
    }

    Connections {
        target: app
        onNetworkStatusChanged: app.networkStatus? getData(): undefined
    }

    Connections {
        target: api
        onLiveboardChanged: {
            placeholder.enabled = false
            _liveboard = api.liveboard
            liveboardListView.model = _liveboard.vehicleListModel
        }
        onErrorOccurred: placeholder.enabled = true
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            busy: api.busy

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
            visible: !placeholder.enabled
            Behavior on opacity { FadeAnimator {} }
            delegate: LiveboardDelegate {
                width: ListView.view.width
                onClicked: model.canceled? undefined: pageStack.push(Qt.resolvedUrl("TripDetailPage.qml"), {
                                                                         vehicleId: model.id,
                                                                         date: _liveboard.timestamp
                                                                     })
            }

            VerticalScrollDecorator {}
        }

        BusyIndicator {
            anchors.centerIn: parent
            size: BusyIndicatorSize.Large
            running: Qt.application.active && api.busy
        }

        InteractionHintLabel {
            anchors.bottom: parent.bottom
            opacity: _showHint? 1.0 : 0.0
            Behavior on opacity { FadeAnimation {} }
            //: When clicked, the user will see a list of station from which the user can choose one.
            //% "Select station"
            text: qsTrId("berail-select-station")
        }

        TouchInteractionHint {
            id: hint
            loops: Animation.Infinite
            direction: TouchInteraction.Down
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
}
