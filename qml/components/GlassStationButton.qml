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

import QtQuick 2.2
import Sailfish.Silica 1.0

BackgroundItem {
    id: button
    property string link
    property string source
    property string text
    property string placeholderText
    property bool valid: station.text.indexOf(button._fromText) == -1 && station.text.indexOf(button._toText) == -1

    //% "From"
    property string _fromText: qsTrId("berail-from")
    //% "To"
    property string _toText: qsTrId("berail-to")

    width: parent.width
    height: Theme.itemSizeExtraLarge
    anchors { left: parent.left; right: parent.right }
    onClicked: {
        var _page = pageStack.push(link);
        _page.selected.connect(function(newText) {
            button.text = newText;
        });
    }
    enabled: link.length

    Row {
        anchors { left: parent.left; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingLarge; verticalCenter: parent.verticalCenter }
        spacing: Theme.paddingMedium

        Column {
            spacing: Theme.paddingSmall

            Image {
                id: logo
                width: Theme.iconSizeMedium
                height: width
                source: button.source
            }

            Label {
                anchors.horizontalCenter: logo.horizontalCenter
                font.pixelSize: Theme.fontSizeTiny
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignHCenter
                visible: button.valid
                text: button.placeholderText
            }
        }

        Label {
            id: station
            width: parent.width - logo.width
            anchors { verticalCenter: parent.verticalCenter }
            font.pixelSize: Theme.fontSizeMedium
            text: button.text
            truncationMode: TruncationMode.Fade
            visible: button.text.length
        }
    }
}
