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
import "../js/util.js" as Utils

ListItem {
    Label {
        id: time
        anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }
        truncationMode: TruncationMode.Fade
        font.bold: true
        color: yellow
        text: model.liveboard.scheduledDepartureTime.toLocaleTimeString(Qt.locale(), "HH:mm")
    }

    Label {
        id: delay
        anchors { right: parent.right; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }
        truncationMode: TruncationMode.Fade
        font.bold: true
        color: red
        opacity: model.liveboard.departureDelay > 0? 1.0: 0.0 // Keep only the spacing for non delayed trains
        Behavior on opacity { FadeAnimator {} }
        visible: model.hasDelay // Only visible when model hasDelay
        text: Utils.formatDelay(model.liveboard.departureDelay)
    }

    Rectangle {
        id: platform
        color: model.liveboard.isDefaultPlatform? transparent: yellow
        width: parent.height
        height: parent.height
        // Anchor to the right element depending on if the model hasDelay or not
        anchors { right: model.hasDelay? delay.left: parent.right; rightMargin: model.hasDelay? Theme.paddingLarge: Theme.horizontalPageMargin }

        Label {
            anchors { centerIn: parent }
            truncationMode: TruncationMode.Fade
            font.bold: true
            color: model.liveboard.isDefaultPlatform? yellow: black
            text: model.liveboard.platform
        }
    }

    Label {
        id: type
        anchors { right: platform.left; rightMargin: Theme.paddingLarge; verticalCenter: parent.verticalCenter }
        truncationMode: TruncationMode.Fade
        font.bold: true
        color: yellow
        text: page.isPortrait? Utils.filterId(model.id.split(".")[2]).toString(): // Short ID
                             model.id.split(".")[2] // Long ID
    }

    Label {
        // Scale the direction label depending on all the other labels
        anchors {
            left: time.right
            leftMargin: Theme.paddingLarge
            right: type.left
            rightMargin: Theme.paddingLarge
            verticalCenter: parent.verticalCenter
        }
        truncationMode: TruncationMode.Fade
        font.bold: true
        color: yellow
        text: model.liveboard.station.name
    }

    Rectangle {
        z: -1 // Make ListItem Highlight visible
        color: index%2? black: grey
        anchors { fill: parent }
    }

    CanceledOverlay { visible: model.canceled }
}
