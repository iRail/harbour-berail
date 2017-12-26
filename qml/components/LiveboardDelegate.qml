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

ListItem {
    Row {
        id: liveboardRow
        width: parent.width
        height: Theme.itemSizeSmall
        anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }
        spacing: Theme.paddingLarge

        Label {
            id: departLabel
            anchors { verticalCenter: parent.verticalCenter }
            truncationMode: TruncationMode.Fade
            font.bold: true
            color: yellow
            text: model.liveboard.scheduledDepartureTime.toLocaleTimeString(Qt.locale(), Locale.ShortFormat).substring(0,5)
        }

        Label { // This can be done better using anchors instead of a row! TO DO
            width: parent.width-departLabel.width-typeLabel.width-trackLabel.width-liveboardRow.spacing*3-(model.hasDelay? delayLabel.width: 0)
            anchors { verticalCenter: parent.verticalCenter }
            truncationMode: TruncationMode.Fade
            font.bold: true
            color: yellow
            text: model.liveboard.station.name
        }

        Label {
            id: typeLabel
            anchors { verticalCenter: parent.verticalCenter }
            truncationMode: TruncationMode.Fade
            font.bold: true
            color: yellow
            text: page.isPortrait? model.id.split(".")[2].substring(model.id.length-6, model.id.length-4): // Short ID
                                   model.id.split(".")[2] // Long ID
        }

        Rectangle {
            id: trackLabel
            color: model.liveboard.isDefaultPlatform? transparent: yellow
            width: parent.height
            height: parent.height

            Label {
                anchors { centerIn: parent }
                truncationMode: TruncationMode.Fade
                font.bold: true
                color: model.liveboard.isDefaultPlatform? yellow: black
                text: model.liveboard.platform
            }
        }

        Label {
            id: delayLabel
            anchors { verticalCenter: parent.verticalCenter }
            truncationMode: TruncationMode.Fade
            font.bold: true
            color: red
            visible: model.liveboard.departureDelay > 0
            text: "+" + model.liveboard.departureDelay/60 // Convert from seconds to minutes
        }
    }

    Rectangle {
        z: -1 // Make ListItem Highlight visible
        color: index%2? black: grey
        anchors { fill: parent }
    }

    CanceledOverlay { visible: model.canceled }
}
