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

BackgroundItem {
    property alias text: label.text
    property alias textAlignment: label.horizontalAlignment
    property int depth: 0

    height: Theme.itemSizeSmall

    Label {
        id: label
        anchors {
            left: parent.left
            right: image.left
            verticalCenter: parent.verticalCenter
            leftMargin: Theme.horizontalPageMargin + depth * Theme.paddingLarge
            rightMargin: Theme.paddingMedium
        }
        horizontalAlignment: Text.AlignRight
        truncationMode: TruncationMode.Fade
        color: parent.highlighted ? Theme.highlightColor : Theme.primaryColor
    }

    Image {
        id: image
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: Theme.horizontalPageMargin
        }
        source: "image://theme/icon-m-right?" + (parent.highlighted ? Theme.highlightColor : Theme.primaryColor)
    }
}
