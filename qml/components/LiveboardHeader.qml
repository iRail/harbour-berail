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

Rectangle {
    property date _currentTime: new Date()

    color: blue
    width: parent.width
    height: Theme.itemSizeHuge
    opacity: 0.8

    Timer {
        running: Qt.application.active
        interval: 503 // Prime number will improve update
        repeat: true
        onTriggered: _currentTime = new Date()
    }

    Label {
        width: parent.width
        anchors { left: parent.left; right: parent.right; top: parent.top; topMargin: Theme.paddingLarge; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
        font.pixelSize: Theme.fontSizeExtraLarge
        font.bold: true
        truncationMode: TruncationMode.Fade
        horizontalAlignment: Text.AlignHCenter
        text: settings.savedLiveboardStation.length > 0?
                  settings.savedLiveboardStation:
                  //: Liveboard title
                  //% "Liveboard"
                  //~ A list of all departing/arriving trains in a station.
                  qsTrId("berail-liveboard")
    }

    Label {
        anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; bottom: parent.bottom; bottomMargin: Theme.paddingLarge }
        font.bold: true
        truncationMode: TruncationMode.Fade
        horizontalAlignment: Text.AlignLeft
        text: _currentTime.toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
    }
}
