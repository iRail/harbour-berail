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
