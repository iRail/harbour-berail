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
import "./js/util.js" as Util

Dialog {
    property string dateText: datePicker.day + " " + Util.covertMonth(datePicker.month-1) + " " + datePicker.year

    Column {
        width: parent.width

        DialogHeader { title: dateText; anchors {horizontalCenter: parent.horizontalCenter} }

        DatePicker {
            id: datePicker
            date: new Date()
            delegate: MouseArea {
                width: datePicker.cellWidth
                height: datePicker.cellHeight

                onClicked: datePicker.date = new Date(year, month-1, day, 12, 0, 0)

                Label {
                    anchors.centerIn: parent
                    text: day
                    color: "white"
                    font.pixelSize: month === primaryMonth ? Theme.fontSizeMedium : Theme.fontSizeExtraSmall
                }
            }
        }
    }
}
