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
import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    width: ListView.view.width
    contentHeight: column.height*1.1
    enabled: model.hasLink
    onClicked: enabled? Qt.openUrlExternally(model.link): undefined

    Column {
        id: column
        width: parent.width
        anchors.centerIn: parent
        spacing: Theme.paddingSmall

        SectionHeader {
            text: model.title
        }

        TextLabel {
            text: model.text
        }
    }
}
