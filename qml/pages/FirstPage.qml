import QtQuick 2.2
import Sailfish.Silica 1.0
import "./components"
import "./js/util.js" as Util

Page {
    id: page

    property string departureText:  qsTr("From")
    property string destinationText: qsTr("To")
    property bool readyToPlan: departure.iconText != departureText && destination.iconText != destinationText // Enable when the user added his stations
    property bool hasAnnoucement: true

    /*Component.onCompleted: python.call("app.stations.get_list", [], function(result) {
            console.log(JSON.stringify(result))
        });*/

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
                onClicked: pageStack.push(Qt.resolvedUrl("StationLiveboardPage.qml"))
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
                    value: Util.getDay() + " " + Util.getMonth() + " " + Util.getYear()
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
                onClicked: pageStack.push(Qt.resolvedUrl("TripPage.qml"))
            }

            ListModel {
                id: announcementsModel
                ListElement {
                    text: "hello"
                }
            }
            SectionHeader { text: announcementsModel.count==1? qsTr("Announcement"):qsTr("Announcements"); opacity: hasAnnoucement? 1.0: 0.0 }
            TextLabel { opacity: hasAnnoucement? 1.0: 0.0; labelText: "From Saturday 29/04 to 1/05, trains will not stop at Brussels-Central station following works between Brussels-Nord and Brussels-Midi. There will be major changes to the train service. Alternative train service Bruxelles-Nord/Brussel-Noord - Bruxelles-Midi/Brussel-Zuid" }
        }
    }
}

