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

Item {    
    property bool show

    BusyIndicator {
        id: loadingIndicator
        anchors { centerIn: parent }
        running: Qt.application.active && show //tripModel.count==0 && succes
        size: BusyIndicatorSize.Large
    }

    Label {
        opacity: show? 1.0: 0.0
        anchors { top: loadingIndicator.bottom; topMargin: Theme.paddingLarge; horizontalCenter: parent.horizontalCenter }
        text: qsTr("Loading") + "..."
        Behavior on opacity { FadeAnimation{} }
    }
}
