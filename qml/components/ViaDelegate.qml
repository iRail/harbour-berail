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
    id: via
    height: Theme.itemSizeHuge*1.1
    width: parent.width

    Column {
        id: stopIndicator
        anchors {
            left: parent.left
            leftMargin: (Theme.itemSizeMedium-width)/2 // Center in TripStationIndicator Rectangle
        }

        Rectangle {
            width: Theme.iconSizeExtraSmall
            height: via.height/2
            // We don't use at the moment the property vehicleArrived since it's buggy on the API side
            // new Date() is required to compare it with the current Date
            color: new Date(model.arrivalTime) < new Date()? Theme.secondaryHighlightColor: Theme.secondaryColor
        }

        Rectangle {
            width: Theme.iconSizeExtraSmall
            height: via.height/2
            // We don't use at the moment the property vehicleLeft since it's buggy on the API side
            // new Date() is required to compare it with the current Date
            color: new Date(model.leftTime) < new Date()? Theme.secondaryHighlightColor: Theme.secondaryColor
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
        width: childrenRect.width // Follow the size of the children
        anchors { left: stopIndicator.right; leftMargin: Theme.paddingLarge; verticalCenter: stopIndicator.verticalCenter }

        Label {
            font.capitalization: Font.SmallCaps
            text: model.arrivalTime.toLocaleTimeString(Qt.locale(), "HH:mm")

            Rectangle {
                // Make the Rectangle a little bit bigger then the time indicator
                anchors.centerIn: parent
                width: parent.width*1.2
                height: parent.height*0.9
                radius: parent.width/4
                opacity: Theme.highlightBackgroundOpacity
                color: model.stop.arrivalDelay > 0? yellow: transparent
            }
        }

        Label {
            font.capitalization: Font.SmallCaps
            text: model.leftTime.toLocaleTimeString(Qt.locale(), "HH:mm")

            Rectangle {
                // Make the Rectangle a little bit bigger then the time indicator
                anchors.centerIn: parent
                width: parent.width*1.2
                height: parent.height*0.9
                radius: parent.width/4
                opacity: Theme.highlightBackgroundOpacity
                color: model.stop.departureDelay > 0? yellow: transparent
            }
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
            text: model.station.name
        }

        Label {
            anchors { left: parent.left; right: parent.right }
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeExtraSmall
            visible: !model.stop.walking
            color: model.willMissVia? Theme.highlightColor: Theme.primaryColor
            text: (page.isPortrait? Utils.filterId(model.vehicleId.split(".")[2]): model.vehicleId.split(".")[2]) + ": " + model.stop.departureDirection
        }

        Label {
            //: The user missed the via
            //% "MISSED"
            property string _viaDurationMissedText: model.willMissVia? " | " + qsTrId("berail-trip-missed-via"):" | ⏱" + Utils.formatTime(model.timeBetween)
            anchors { left: parent.left; right: parent.right }
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeExtraSmall
            font.italic: model.stop.walking
            color: model.willMissVia? Theme.highlightColor: Theme.primaryColor
            //: Sometimes walking is needed between 2 stations
            //% "Walk to the next station"
            text: model.stop.walking? qsTrId("berail-trip-walking"):
                                      //: The platform where the train arrives or departures
                                      //% "Platform %0"
                                      qsTrId("berail-trip-platform").arg(model.stop.arrivalPlatform)
                                      + " → %0".arg(model.stop.departurePlatform)
                                      + _viaDurationMissedText
        }
    }
}
