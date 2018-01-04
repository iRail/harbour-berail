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
    contentHeight: Theme.itemSizeLarge

    Column {
        id: dateLabel
        anchors {
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            verticalCenter: parent.verticalCenter
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeSmall
            text: new Date(model.date).toLocaleTimeString(Qt.locale(), "HH:mm")
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeSmall
            text: new Date(model.date).toLocaleDateString(Qt.locale(), "d MMM yyyy")
        }
    }

    Column {
        width: parent.width - dateLabel.width
        anchors {
            left: dateLabel.right
            leftMargin: Theme.paddingLarge
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
            verticalCenter: parent.verticalCenter
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            truncationMode: TruncationMode.Fade
            font.capitalization: Font.SmallCaps
            font.bold: true
            text: model.from
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            truncationMode: TruncationMode.Fade
            font.capitalization: Font.SmallCaps
            font.bold: true
            text: model.to
        }
    }
}
