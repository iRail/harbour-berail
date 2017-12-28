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
    contentHeight: column.height*1.1

    Column {
        id: column
        width: parent.width
        anchors.centerIn: parent
        spacing: Theme.paddingSmall

        SectionHeader {
            text: model.title.split(":")[1].split(".")[0] // Remove "." from the end
        }

        TextLabel {
            text: model.text
        }

        Item {
           width: parent.width
           height: Theme.itemSizeSmall

           Label {
               anchors { right: iconLocation.left; rightMargin: Theme.paddingSmall; verticalCenter: parent.verticalCenter }
               font.pixelSize: Theme.fontSizeSmall
               color: Theme.secondaryColor
               text: model.title.split(":")[0]
           }

           Image {
               id: iconLocation
               anchors { right: parent.right; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }
               source: "image://theme/icon-m-location"
           }
        }

        Item {
           width: parent.width
           height: Theme.itemSizeSmall

           Label {
               anchors { right: iconDate.left; rightMargin: Theme.paddingSmall; verticalCenter: parent.verticalCenter }
               font.pixelSize: Theme.fontSizeSmall
               color: Theme.secondaryColor
               text: model.timestamp.toLocaleString(Qt.locale(), "dd MMM yyyy hh:mm");
           }

           Image {
               id: iconDate
               anchors { right: parent.right; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }
               source: "image://theme/icon-m-time-date"
           }
        }
    }
}
