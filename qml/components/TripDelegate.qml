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
import "../components"
import "../js/util.js" as Utils

ListItem {
    property var vias
    property bool _showVias: false

    id: trip
    contentHeight: row.height + Theme.paddingLarge*2
    enabled: false

    // ViaListView blocks the ListItem to capture the touch interactions
    BackgroundItem {
        id: touchArea
        anchors.fill: parent
        z: 1
        onClicked: _showVias == true? _showVias = false: _showVias = true
        enabled: vias.count() > 0
    }

    Row {
        id: row
        width: parent.width
        anchors {
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
            verticalCenter: parent.verticalCenter
        }

        Column {
            width: parent.width-meta.width
            spacing: _showVias? 0: Theme.paddingSmall

            TripStationIndicator {
                time: model.from.scheduledDepartureTime
                delay: model.from.departureDelay
                color: green
                station: model.from.station.name
                platform: model.from.platform
                isDefaultPlatform: model.from.isDefaultPlatform
            }

            SilicaListView {
                id: viaListView
                width: parent.width
                height: contentHeight // Follow delegate size
                z: -1 // Prevent stealing
                visible: _showVias
                opacity: api.busy? fadeOutValue: 1.0
                Behavior on opacity { FadeAnimator {} }
                model: vias
                delegate: ViaDelegate {
                    width: ListView.view.width
                    enabled: false // Nothing to click on
                }
            }

            TripStationIndicator {
                time: model.to.scheduledDepartureTime
                delay: model.to.departureDelay
                color: red
                station: model.to.station.name
                platform: model.to.platform
                isDefaultPlatform: model.to.isDefaultPlatform
            }
        }

        Column {
            id: meta
            width: Theme.itemSizeSmall
            spacing: Theme.paddingSmall

            ImageLabel {
                anchors.right: parent.right
                text: page.isPortrait? Utils.filterId(model.fromVehicleId.split(".")[2]).toString(): // Short ID
                                       model.fromVehicleId.split(".")[2] // Long ID
                source: Utils.convertOccupancyType(model.occupancy)
            }

            ImageLabel {
                anchors.right: parent.right
                visible: vias.count() > 0
                text: vias.count()
                source: "qrc:///icons/icon-change.png"
            }

            ImageLabel {
                anchors.right: parent.right
                visible: model.alerts.alertListModel.count() > 0
                text: model.alerts.alertListModel.count()
                source: "qrc:///icons/icon-alert.png"
            } 
        }
    }
}
