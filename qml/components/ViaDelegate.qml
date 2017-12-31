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
import "../js/util.js" as Utils

ListItem {
    property string vehicleId
    property string vehicleDirection
    property bool vehicleLeft
    property bool vehicleArrived
    property string station
    property date arrivedDate
    property date leftDate
    property string arrivedPlatform
    property string leftPlatform
    property int between

    id: via
    height: Theme.itemSizeHuge*1.1
    width: parent.width

    Rectangle {
        id: stopIndicator
        width: Theme.iconSizeExtraSmall
        height: via.height
        anchors {
            left: parent.left
            leftMargin: (Theme.itemSizeMedium-width)/2 // Center in TripStationIndicator Rectangle
        }
        color: via.vehicleLeft? Theme.secondaryHighlightColor: Theme.secondaryColor

        Rectangle {
            // Creates a black background to avoid ugly overlaps due the fact that the Theme colors are partly transparent
            width: Theme.iconSizeSmall*1.3 // Theme.iconSizeMedium is too big
            height: Theme.iconSizeSmall*1.3
            anchors.centerIn: parent
            radius: width/2
            color: black

            Rectangle {
                width: Theme.iconSizeSmall*1.25 // Theme.iconSizeMedium is too big
                height: Theme.iconSizeSmall*1.25
                anchors.centerIn: parent
                radius: width/2
                color: via.vehicleLeft? Theme.secondaryHighlightColor: Theme.secondaryColor
            }
        }
    }

    Column {
        id: timeIndicator
        width: childrenRect.width // Follow the size of the children
        anchors { left: stopIndicator.right; leftMargin: Theme.paddingLarge; verticalCenter: stopIndicator.verticalCenter }

        Label {
            font.capitalization: Font.SmallCaps
            text: via.arrivedDate.toLocaleTimeString(Qt.locale(), "HH:mm")
        }

        Label {
            font.capitalization: Font.SmallCaps
            text: via.leftDate.toLocaleTimeString(Qt.locale(), "HH:mm")
        }
    }

    Column {
        anchors {
            left: timeIndicator.right
            leftMargin: Theme.paddingMedium
            right: parent.right
            verticalCenter: stopIndicator.verticalCenter
        }

        Label {
            anchors { left: parent.left; right: parent.right }
            truncationMode: TruncationMode.Fade
            font.capitalization: Font.SmallCaps
            font.bold: true
            text: via.station
        }

        Label {
            anchors { left: parent.left; right: parent.right }
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeExtraSmall
            text: (page.isPortrait? Utils.filterId(via.vehicleId.split(".")[2]): via.vehicleId.split(".")[2]) + ": " + vehicleDirection
        }

        Label {
            anchors { left: parent.left; right: parent.right }
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeExtraSmall
            //: The platform where the train arrives or departures
            //% "Platform %0"
            text: qsTrId("berail-trip-platform").arg(via.arrivedPlatform)
                  + " → %0".arg(via.leftPlatform)
                  + " | ⏱" + Utils.formatTime(via.between)
        }
    }
}
