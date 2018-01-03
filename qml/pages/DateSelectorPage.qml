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

Dialog {
    id: datePickerDialog
    property date _selectedDate: new Date()
    property date date: new Date()

    Column {
        width: parent.width
        spacing: datePickerDialog.isPortrait? Theme.paddingLarge: 0

        DialogHeader {}

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: _selectedDate.toLocaleDateString(Qt.locale(), "d MMM yyyy")
            font.pixelSize: Theme.fontSizeLarge
        }

        DatePicker {
            id: datePicker
            anchors.horizontalCenter: parent.horizontalCenter
            date: datePickerDialog.date
            onDateChanged: _selectedDate = date
        }
    }

    DockedPanel {
        width: parent.width
        height: button.height + Theme.paddingLarge
        dock: Dock.Bottom
        open: datePickerDialog.isPortrait

        Button {
            id: button
            anchors.centerIn: parent
            //% "Today"
            text: qsTrId("berail-today")
            onClicked:
            {
                datePicker.date = new Date()
            }
        }
    }

    onAccepted: {
        date = _selectedDate
    }
}
