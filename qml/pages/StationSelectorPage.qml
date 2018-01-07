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
import "../components"

Page {
    property string _searchString
    signal selected(string station)

    id: searchPage
    // For performance reasons we wait until the Page is fully loaded before doing an API request
    onStatusChanged: status===PageStatus.Active? getData(): undefined

    function getData() {
        api.getStations()
    }

    Connections {
        target: app
        onNetworkStatusChanged: app.networkStatus? getData(): undefined
    }

    Connections {
        target: api
        onStationsChanged: {
            placeholder.enabled = false
            stationListView.model = api.stations
        }
        // When list is loaded, set focus on search field
        onBusyChanged: busy? undefined: header.forceActiveFocusSearch()
        onErrorOccurred: placeholder.enabled = true
    }

    // Hide busyIndicator when keyboard is open to avoid an ugly animation
    Connections {
        target: Qt.inputMethod
        onVisibleChanged: Qt.inputMethod.visible? busyIndicator.visible = false: busyIndicator.visible = true;
    }

    SilicaFlickable {
        anchors.fill: parent

        // When set as header of the SilicaListView focus is lost almost on every keystroke
        StationSelectorHeader {
            id: header
            anchors { top: parent.top; left: parent.left; right: parent.right }
            onSearchStringChanged: {
                _searchString = header.searchString
                api.stations.searchName = header.searchString
                console.debug("Searching for: " + api.stations.searchName)
            }
        }

        SilicaListView {
            id: stationListView
            anchors { top: header.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }
            clip: true // Only paint within it's borders
            opacity: api.busy? fadeOutValue: fadeInValue
            visible: !placeholder.enabled
            Behavior on opacity { FadeAnimator {} }
            delegate: StationSelectorDelegate {
                id: delegate
                width: ListView.view.width
                searchString: _searchString
                onClicked: {
                    searchPage.selected(model.name)
                    console.debug("Station selected:" + model.name)
                    pageStack.pop()
                }
            }

            VerticalScrollDecorator {}
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

        BusyIndicator {
            id: busyIndicator
            anchors.centerIn: parent
            size: BusyIndicatorSize.Large
            running: Qt.application.active && api.busy
        }
    }
}
