import QtQuick 2.2
import Sailfish.Silica 1.0
import "./components"
import "./js/util.js" as Util
import "./js/disturbances.js" as Disturbances

Page {
    id: page

    property string departureText:  qsTr("From")
    property string destinationText: qsTr("To")
    property bool readyToPlan: departure.iconText != departureText && destination.iconText != destinationText // Enable when the user added his stations
    property bool hasAnnoucement: true
    property bool succes: true

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
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }

            MenuItem {
                text: qsTr("Liveboard")
                onClicked: pageStack.push(Qt.resolvedUrl("LiveboardPage.qml"))
            }
        }

        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("BeRail")
            }

            Row {
                width: parent.width
                Column {
                    width: parent.width-Theme.itemSizeMedium
                    GlassButton { id: departure; link: Qt.resolvedUrl("StationListPage.qml"); type: 1; iconSource: "qrc:///icons/icon-train.png"; iconText: departureText; itemScale: 0.75 }
                    GlassButton { id: destination; link: Qt.resolvedUrl("StationListPage.qml"); type: 1; iconSource: "qrc:///icons/icon-train.png"; iconText: destinationText; itemScale: 0.75 }
                }
                BackgroundItem {
                    width: Theme.itemSizeMedium
                    height: parent.height
                    enabled: readyToPlan
                    opacity: enabled? 1.0: 0.25
                    onClicked: { // Switch
                        var temp = departure.iconText;
                        departure.iconText = destination.iconText;
                        destination.iconText = temp;
                    }

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
                            value = dialog.dateText
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
                                              to: destination.iconText,
                                              time: time.value,
                                              date: date.value
                                          })
            }

            // TODO: Move position bindings from the component to the Loader.
            //       Check all uses of 'parent' inside the root element of the component.
            /*Component {
                id: component_DisturbancesView
                DisturbancesView {
                    model: alertsModel
                }
            }
            Loader {
                id: loader_DisturbancesView
                sourceComponent: component_DisturbancesView
                asynchronous: true
            }*/

            DisturbancesView {
                model: alertsModel
            }


            ListModel {
                id: alertsModel
            }
        }
    }
}

