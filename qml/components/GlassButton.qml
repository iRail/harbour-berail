/*
*   This file is part of BeRail.
*
*   BeRail is free software: you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation, either version 3 of the License, or
*   (at your option) any later version.
*
*   Foobar is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with BeRail.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2
import Sailfish.Silica 1.0

BackgroundItem {
    property string link
    property string iconSource
    property string iconText
    property bool show: true
    property int type

    width: parent.width
    height: Theme.itemSizeLarge
    anchors { left: parent.left; right: parent.right }
    onClicked: {
        switch(type) {
        case 0:
            Qt.openUrlExternally(link);
            break;
        case 1:
            var _page = pageStack.push(link);
            _page.finished.connect(function(newText) {
                iconText = newText;
            });
            break;
        case 2:
            pageStack.replace(link);
            break;
        }
    }
    enabled: link.length
    visible: iconText.length && show

    Row {
        anchors { left: parent.left; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingLarge; verticalCenter: parent.verticalCenter }
        spacing: Theme.paddingMedium

        Image {
            id: logo
            width: Theme.iconSizeMedium
            height: width
            source: iconSource
        }

        Label {
            width: parent.width - logo.width
            anchors { verticalCenter: parent.verticalCenter }
            font.pixelSize: Theme.fontSizeMedium
            text: iconText
            truncationMode: TruncationMode.Fade
            visible: iconText.length
        }
    }
}
