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
import QtQml 2.2
import Sailfish.Silica 1.0
import "../components"

Column {
    width: parent.width
    spacing: Theme.paddingLarge

    property date currentDate: new Date()
    //% "From"
    property string _fromText: qsTrId("berail-from")
    //% "To"
    property string _toText: qsTrId("berail-to")
    property bool readyToPlan: settings.favouriteStations? from.iconText.length > 0 && to.iconText.length > 0: false
    signal _changeStations()
    signal dateSelected()
    signal timeSelected()

    on_ChangeStations: {
        var temp = to.iconText;
        to.iconText = from.iconText;
        from.iconText = temp;
    }

    Row {
        width: parent.width

        Column {
            width: parent.width - Theme.itemSizeMedium

            GlassButton {
                id: from
                link: Qt.resolvedUrl("../pages/StationSelectorPage.qml")
                type: 1
                iconSource: "qrc:///icons/icon-train.png"
                iconText: settings.favouriteStations? settings.favouriteDepartStation: _fromText
            }

            GlassButton {
                id: to
                link: Qt.resolvedUrl("../pages/StationSelectorPage.qml")
                type: 1
                iconSource: "qrc:///icons/icon-train.png"
                iconText: settings.favouriteStations? settings.favouriteDepartStation: _toText
            }
        }

        BackgroundItem {
            width: Theme.itemSizeMedium
            height: parent.height
            enabled: readyToPlan
            opacity: enabled? fadeInValue: fadeOutValue
            Behavior on opacity { FadeAnimator{} }
            onClicked: _changeStations()

            Image {
                width: Theme.iconSizeMedium
                height: width
                anchors { centerIn: parent }
                rotation: 180
                source: "qrc:///icons/icon-switch.png"
                asynchronous: true
            }
        }
    }

    Row {
        width: parent.width

        ValueButton {
            id: date
            width: parent.width/1.75
            //% "Date"
            label: qsTrId("berail-date")
            value: currentDate.toLocaleDateString(Qt.locale(), Locale.ShortFormat)
            onClicked: {
                var dialog = pageStack.push(Qt.resolvedUrl("DateSelectorDialog.qml"), {
                                                date: currentDate
                                            })

                dialog.accepted.connect(function() {
                    console.debug("Selected date: " + dialog.date)
                    var newDate = dialog.date // Date dialog doesn't report JS Date object
                    newDate.setHours(currentDate.getHours())
                    newDate.setMinutes(currentDate.getMinutes())
                    newDate.setSeconds(currentDate.getSeconds())
                    currentDate = newDate;
                    dateSelected()
                })
            }
        }

        ValueButton {
            id: time
            width: parent.width - date.width
            //% "Time"
            label: qsTrId("berail-time")
            value: currentDate.toLocaleTimeString(Qt.locale(), Locale.ShortFormat).substring(0,5) // Remove unused seconds

            onClicked: {
                var dialog = pageStack.push("TimeSelectorDialog.qml", {
                                                hour: currentDate.getHours(),
                                                minute: currentDate.getMinutes()
                                            })

                dialog.accepted.connect(function() {
                    console.debug("Selected time: " + dialog.time)
                    var newDate = dialog.time
                    newDate.setDate(currentDate.getDate())
                    newDate.setMonth(currentDate.getMonth())
                    newDate.setFullYear(currentDate.getFullYear())
                    currentDate = newDate;
                    timeSelected()
                })
            }
        }
    }

    Button {
        anchors { horizontalCenter: parent.horizontalCenter }
        //: Clicking on this button will start the trip planner
        //% "Plan my trip"
        text: qsTrId("berail-plan-trip")
        enabled: readyToPlan
        onClicked: pageStack.push(Qt.resolvedUrl("TripPage.qml"), {
                                      from: from.iconText,
                                      to: to.iconText,
                                      time: time.value,
                                      date: date.value
                                  })
    }

    // Spacer
    Item {
        width: parent.width
        height: Theme.paddingSmall
    }
}
