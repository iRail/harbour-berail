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
    property bool isFirstItem
    property bool isLastItem

    id: detailTrip
    contentHeight: Theme.itemSizeExtraLarge
    width: parent.width

    Column {
        id: stopIndicator
        anchors {
            left: parent.left
            leftMargin: (Theme.itemSizeMedium-width)/2 // Center in TripStationIndicator Rectangle
        }

        Rectangle {
            width: Theme.iconSizeExtraSmall
            height: detailTrip.height/2
            // We don't use at the moment the property vehicleArrived since it's buggy on the API side
            // new Date() is required to compare it with the current Date
            color: isFirstItem? transparent: new Date(model.realArrivalTime) < new Date()? Theme.secondaryHighlightColor: Theme.secondaryColor
        }

        Rectangle {
            width: Theme.iconSizeExtraSmall
            height: detailTrip.height/2
            // We don't use at the moment the property vehicleLeft since it's buggy on the API side
            // new Date() is required to compare it with the current Date
            // Hide this Rectangle when it's the last stop by making it transparant
            color: isLastItem? transparent: new Date(model.realDepartureTime) < new Date()? Theme.secondaryHighlightColor: Theme.secondaryColor
        }
    }

    Rectangle {
        // Creates a darker background to avoid ugly overlaps due the fact that the Theme colors are partly transparent
        width: Theme.iconSizeSmall*1.25 // Theme.iconSizeMedium is too big
        height: Theme.iconSizeSmall*1.25
        anchors.centerIn: stopIndicator
        radius: width/2
        color: black

        Rectangle {
            width: Theme.iconSizeSmall*1.25 // Theme.iconSizeMedium is too big
            height: Theme.iconSizeSmall*1.25
            anchors.centerIn: parent
            radius: width/2
            color: Theme.secondaryColor
        }
    }

    Column {
        id: timeIndicator
        width: Theme.itemSizeSmall // Follow the size of the children
        anchors {
            left: stopIndicator.right
            leftMargin: Theme.paddingLarge
            verticalCenter: stopIndicator.verticalCenter
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.capitalization: Font.SmallCaps
            text: model.scheduledDepartureTime.toLocaleTimeString(Qt.locale(), "HH:mm")
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.capitalization: Font.SmallCaps
            font.pixelSize: Theme.fontSizeSmall
            font.bold: true
            visible: model.departureDelay > 0
            color: red
            text: Utils.formatDelay(model.departureDelay)
        }
    }

    Column {
        anchors {
            left: timeIndicator.right
            leftMargin: Theme.paddingMedium
            right: icon.left
            rightMargin: Theme.paddingMedium
            verticalCenter: stopIndicator.verticalCenter
        }

        Label {
            id: station
            truncationMode: TruncationMode.Fade
            font.capitalization: Font.SmallCaps
            font.bold: true
            text: model.station.name
        }

        Label {
            anchors { left: parent.left }
            width: contentWidth
            font.pixelSize: Theme.fontSizeExtraSmall
            truncationMode: TruncationMode.Fade
            //: The platform where the train arrives or departures
            //% "Platform %0"
            text: qsTrId("berail-trip-platform").arg(model.platform)

            Rectangle {
                // Make the Rectangle a little bit bigger then the time indicator
                anchors.centerIn: parent
                width: parent.width*1.1
                height: parent.height*0.9
                radius: parent.width/4
                opacity: Theme.highlightBackgroundOpacity
                color: model.isDefaultPlatform? transparent: yellow
            }
        }

        Label {
            anchors { left: parent.left; right: parent.right }
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeExtraSmall
            font.italic: true
            visible: model.isExtraStop
            //: Sometimes Traffic Control adds extra stops in case of disturbances on the network
            //% "Extra stop added by Traffic Control"
            text: qsTrId("berail-trip-extra-stop")
        }
    }

    Image {
        id: icon
        anchors {
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
            verticalCenter: parent.verticalCenter
        }
        width: Theme.iconSizeSmall
        height: Theme.iconSizeSmall
        source: Utils.convertOccupancyType(model.occupancy)
    }
}
