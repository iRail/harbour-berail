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
import "../js/disturbances.js" as Disturbances

SilicaListView {
    width: parent.width
    height: childrenRect.height

    property bool showStation: true

    delegate: ListItem {
        width: ListView.view.width
        contentHeight: item.height*1.1
        enabled: model.hasOwnProperty("link")
        onClicked: Qt.openUrlExternally(model.link) // If model has link then open it when user clicks on the item
        Column {
            id: item
            width: parent.width
            anchors { centerIn: parent }
            spacing: Theme.paddingSmall
            SectionHeader { text: showStation? model.header.replace(".", ""): model.header.split(":")[1].replace(".", "") } // Remove "." at the end
            TextLabel { labelText: model.description }
        }
    }
}
