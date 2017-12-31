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
    property bool readyToPlan: from.valid && to.valid && from.text != to.text
    signal _changeStations()
    signal dateSelected()
    signal timeSelected()

    on_ChangeStations: {
        var temp = to.text;
        to.text = from.text;
        from.text = temp;
    }

    Row {
        width: parent.width

        Column {
            width: parent.width - Theme.itemSizeMedium

            /*GlassButton {
                // Valid when a station is set and it's not From or To
                property bool valid: text.length > 0 && text.indexOf(_fromText) == -1 && text.indexOf(_toText) == -1

                id: from
                height: Theme.itemSizeLarge + fromLabel.height + Theme.paddingSmall // Provide padding
                link: Qt.resolvedUrl("../pages/StationSelectorPage.qml")
                type: 1
                source: "qrc:///icons/icon-train.png"
                text: settings.favouriteStationsEnabled? settings.favouriteFromStation: _fromText


            }*/

            GlassStationButton {
                id: from
                link: Qt.resolvedUrl("../pages/StationSelectorPage.qml")
                source: "qrc:///icons/icon-train.png"
                text: settings.favouriteStationsEnabled? settings.favouriteFromStation: _fromText
                placeholderText: _fromText
            }

            GlassStationButton {
                id: to
                link: Qt.resolvedUrl("../pages/StationSelectorPage.qml")
                source: "qrc:///icons/icon-train.png"
                text: settings.favouriteStationsEnabled? settings.favouriteToStation: _toText
                placeholderText: _toText
            }

            /*GlassButton {
                // Valid when a station is set and it's not From or To
                property bool valid: text.length > 0 && text.indexOf(_fromText) == -1 && text.indexOf(_toText) == -1

                id: to
                height: Theme.itemSizeLarge + toLabel.height + Theme.paddingSmall // Provide padding
                link: Qt.resolvedUrl("../pages/StationSelectorPage.qml")
                type: 1
                source: "qrc:///icons/icon-train.png"
                text: settings.favouriteStationsEnabled? settings.favouriteToStation: _toText

                Label {
                    id: toLabel
                    // Center on GlassButton icon
                    anchors {
                        left: parent.left;
                        leftMargin: -width/2 + Theme.paddingLarge + Theme.iconSizeMedium/2
                        bottom: parent.bottom
                        bottomMargin: Theme.paddingSmall/2
                    }
                    font.pixelSize: Theme.fontSizeTiny
                    color: Theme.highlightColor
                    horizontalAlignment: Text.AlignHCenter
                    visible: parent.text.indexOf(_fromText) == -1 && parent.text.indexOf(_toText) == -1
                    text: _toText
                }
            }*/
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
                var dialog = pageStack.push(Qt.resolvedUrl("../pages/DateSelectorPage.qml"), {
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
            value: currentDate.toLocaleTimeString(Qt.locale(), "HH:mm") // Remove unused seconds
            onClicked: {
                var dialog = pageStack.push("../pages/TimeSelectorPage.qml", {
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
        onClicked: pageStack.push(Qt.resolvedUrl("../pages/TripPage.qml"), {
                                      from: from.text,
                                      to: to.text,
                                      date: currentDate,
                                  })
    }

    // Spacer
    Item {
        width: parent.width
        height: Theme.paddingSmall
    }
}
