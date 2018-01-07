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
import "../components"

Dialog {
    id: timePickerDialog

    property int hour
    property int minute
    property date time: new Date(0,0,0, hour, minute)

    onHourChanged: timePicker.hour = hour
    onMinuteChanged: timePicker.minute = minute

    allowedOrientations: Orientation.All

    Column {
        spacing: Theme.paddingLarge
        width: parent.width

        DialogHeader {}

        TimePicker {
            id: timePicker
            anchors.horizontalCenter: parent.horizontalCenter

            TimeSelectorClockItem { // ClockItem is Silica Private API, duplicated into TimeSelectorClockItem
                anchors.centerIn: parent
                time: timePicker.time
            }
        }
    }

    onDone: {
        if (result == DialogResult.Accepted) {
            hour = timePicker.hour
            minute = timePicker.minute
        }
    }

    DockedPanel {
        width: parent.width
        height: button.height + Theme.paddingLarge
        dock: Dock.Bottom
        open: timePickerDialog.isPortrait

        Button {
            id: button
            anchors.centerIn: parent
            //% "Now"
            text: qsTrId("berail-now")
            onClicked:
            {
                var now = new Date()
                timePicker.hour = now.getHours()
                timePicker.minute = now.getMinutes()
            }
        }
    }
}
