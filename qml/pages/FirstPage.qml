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
import "./components"
import "./js/util.js" as Util
import "./js/disturbances.js" as Disturbances

Page {
    id: page

    property string departureText:  qsTr("From")
    property string arriveText: qsTr("To")
    property bool readyToPlan: departure.iconText != departureText && arrival.iconText != arriveText // Enable when the user added his stations
    property bool hasAnnoucement: true
    property bool succes: true
    property bool _loading: alertsModel.count==0 && succes

    signal _changeStations()

    on_ChangeStations: {
        var temp = departure.iconText;
        departure.iconText = arrival.iconText;
        arrival.iconText = temp;
    }

    Component.onCompleted: Util.getHours() > 12? _changeStations(): undefined // Switch stations when in the afternoon

    Connections {
        target: app
        onPythonReadyChanged: {
            var _result
            pythonReady? _result = Disturbances.load(): undefined
            _result? loader_DisturbancesView =component_DisturbancesView: undefined
        }
    }

    SilicaFlickable {
        anchors { fill: parent }
        contentHeight: column.height

        PullDownMenu {
            busy: _loading

            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                enabled: !_loading
            }

            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
                enabled: !_loading
            }

            MenuItem {
                text: qsTr("Liveboard")
                onClicked: pageStack.push(Qt.resolvedUrl("LiveboardPage.qml"))
                enabled: !_loading
            }
        }

        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("BeRail")
                description: qsTr("The official iRail app")

                BusyIndicator {
                    anchors { verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: Theme.horizontalPageMargin }
                    size: BusyIndicatorSize.Small
                    running: _loading
                }
            }

            Row {
                width: parent.width
                Column {
                    width: parent.width-Theme.itemSizeMedium
                    GlassButton {
                        id: departure
                        link: Qt.resolvedUrl("StationListPage.qml")
                        type: 1
                        iconSource: "qrc:///icons/icon-train.png"
                        iconText: settings.favouriteStations? settings.favouriteDepartStation: departureText
                        itemScale: 0.75
                    }
                    GlassButton {
                        id: arrival
                        link: Qt.resolvedUrl("StationListPage.qml")
                        type: 1
                        iconSource: "qrc:///icons/icon-train.png"
                        iconText: settings.favouriteStations? settings.favouriteArriveStation: arriveText
                        itemScale: 0.75
                    }
                }
                BackgroundItem {
                    width: Theme.itemSizeMedium
                    height: parent.height
                    enabled: readyToPlan
                    opacity: enabled? 1.0: 0.25
                    onClicked: _changeStations()

                    Image {
                        width: Theme.itemSizeSmall/1.75
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
                    label: qsTr("Date")
                    value: Util.getDay(true) + " " + Util.getMonth() + " " + Util.getYear().toString().substr(2,2) //Get last 2 digits of the year
                    onClicked: {
                        var dialog = pageStack.push(Qt.resolvedUrl("DatePickerPage.qml"), {})

                        dialog.accepted.connect(function() {
                            var temp; // format for iRail API
                            temp = dialog.dateText.split(" ");
                            value = Util.addLeadingZero(temp[0]) + " " + Util.addLeadingZero(temp[1])  + " " + temp[2].toString().substr(2,2);
                        })
                    }
                }

                ValueButton {
                    id: time
                    width: parent.width/2.25
                    label: qsTr("Time")
                    value: Util.getHours(true) + ":" + Util.getMinutes(true)
                    onClicked: {
                        var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog", {
                                                        hour: Util.getHours(),
                                                        minute: Util.getMinutes()
                                                    })

                        dialog.accepted.connect(function() {
                            value = dialog.timeText
                        })
                    }
                }
            }

            Button {
                anchors { horizontalCenter: parent.horizontalCenter }
                text: qsTr("Plan my trip")
                enabled: readyToPlan
                onClicked: pageStack.push(Qt.resolvedUrl("TripPage.qml"), {
                                              from: departure.iconText,
                                              to: arrival.iconText,
                                              time: time.value,
                                              date: date.value
                                          })
            }


            DisturbancesView {
                id: alertsView
                model: alertsModel
            }

            ListModel {
                id: alertsModel
            }
        }
    }
}

