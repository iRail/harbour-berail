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

ListItem {
    id: via
    property bool vehicleLeft

    Rectangle {
        width: Theme.iconSizeExtraSmall
        height: via.contentHeight
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
}
