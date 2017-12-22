import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Column {
    width: parent.width
    property var currentDate: new Date()
    property string _fromText: qsTrId("berail-from")
    property string _toText: qsTrId("berail-to")
    signal _changeStations()

    on_ChangeStations: {
        var temp = to.iconText;
        to.iconText = from.iconText;
        from.iconText = temp;
    }

    PageHeader {
        // USE SFOS module to automatically retrieve app name TODO
        title: "BeRail"
        //: Description about BeRail being the official iRail app
        //% "The official iRail app"
        description: qsTrId("berail-official-irail-app")
    }

    Row {
        width: parent.width

        Column {
            width: parent.width

            GlassButton {
                id: from
                link: Qt.resolvedUrl("StationListPage.qml")
                type: 1
                iconSource: "qrc:///icons/icon-train.png"
                iconText: settings.favouriteStations? settings.favouriteDepartStation: _fromText
            }

            GlassButton {
                id: to
                link: Qt.resolvedUrl("StationListPage.qml")
                type: 1
                iconSource: "qrc:///icons/icon-train.png"
                iconText: settings.favouriteStations? settings.favouriteDepartStation: _toText
            }
        }

        BackgroundItem {
            width: Theme.itemSizeMedium
            height: parent.height
            enabled: from.iconText.length > 0 && to.iconText.length > 0
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
            value: currentDate.getDate() + "/" + currentDate.getMonth() + "/" + currentDate.getFullYear().toString().substring(2,2)
            onClicked: {
                var dialog = pageStack.push(Qt.resolvedUrl("Sailfish.Silica.DatePickerDialog"), {
                                                date: currentDate
                                            })

                dialog.accepted.connect(function() {
                    console.debug("Selected date: " + dialog.dateText)
                    var newDate = new Date(dialog.dateText)
                    currentDate.setDate(newDate.getDate())
                    currentDate.setMonth(newDate.setMonth())
                    currentDate.setFullYear(newDate.setFullYear())
                })
            }
        }

        ValueButton {
            id: time
            width: parent.width - date.width
            //% "Time"
            label: qsTrId("berail-time")
            value: currentDate.getHours() + ":" + currentDate.getMinutes()

            onClicked: {
                var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog", {
                                                hour: currentDate.getHours(),
                                                minute: currentDate.getMinutes()
                                            })

                dialog.accepted.connect(function() {
                    console.debug("Selected time: " + dialog.timeText)
                    var newTime = new Date(dialog.timeText)
                    currentDate.setHours(newTime.getHours())
                    currentDate.setMinutes(newTime.getMinutes())
                    currentDate.setSeconds(newTime.getSeconds())
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
}
