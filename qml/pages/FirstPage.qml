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
import Harbour.BeRail.API 1.0
import Harbour.BeRail.Models 1.0

Page {
    id: page

    property string departureText:  qsTr("From")
    property string arriveText: qsTr("To")
    property bool readyToPlan: departure.iconText != departureText && arrival.iconText != arriveText // Enable when the user added his stations
    property bool hasAnnoucement: true
    property bool succes: true
    //property bool _loading: alertsModel.count==0 && succes

    signal _changeStations()

    on_ChangeStations: {
        var temp = departure.iconText;
        departure.iconText = arrival.iconText;
        arrival.iconText = temp;
    }

    Component.onCompleted: Util.getHours() > 12? _changeStations(): undefined // Switch stations when in the afternoon

    API {
        id: iRail
        onDisturbancesChanged: {
            console.log("Disturbances received in QML: " + iRail.disturbances)
            //alertsView.model = iRail.disturbances.alertsListModel
            console.log(iRail.disturbances.alertsListModel)
        }
        onConnectionsChanged: {
            console.log("Connections received in QML")
            connectionTest.model = iRail.connections
        }

        /*onLiveboardChanged: {
            console.log("Liveboard data from QML:")
            console.log(iRail.liveboard.station.name);
            console.log(iRail.liveboard.station.id);
            console.log(iRail.liveboard.station.location);
        }
        onStationsChanged: {
            console.log("Stations data from QML:")
            for(var i =0; i<10; i++) {
                console.log(iRail.stations[i])
            }
        }*/
        onVehicleChanged: {
            console.log("Vehicle data from QML:")
            console.log(iRail.vehicle.id)
            console.log(iRail.vehicle.date)
            console.log(iRail.vehicle.canceled)
            console.log(iRail.vehicle.occupancy)
            console.log(iRail.disturbances.alertsListModel)
            //vehicleTest.model = iRail.vehicle.stopListModel
            if(iRail.vehicle.occupancy == IRail.Unknown) {
                console.log("Unknown occupancy")
            }

        }

        onLiveboardChanged: {
            console.log("Liveboard data from QML:")
            console.log(iRail.liveboard.station.name)
            console.log(iRail.liveboard.alertListModel)
            console.log(iRail.liveboard.vehicleListModel)
            //liveboardTest.model = iRail.liveboard.vehicleListModel;
            //insidelist.model = iRail.liveboard.vehicleListModel.get(0).stops;
        }

        onNetworkStateChanged: console.log("Network state: " + state)
        onBusyChanged: console.log("busy changed")
        Component.onCompleted: {
            iRail.getConnections("Mechelen", "Brugge", IRail.Departure, new Date(), IRail.All)
            iRail.getDisturbances()
            iRail.getVehicle("BE.NMBS.S11757", new Date())
            iRail.getStations()
            iRail.getLiveboard("Vilvoorde", new Date(), IRail.Departure)
        }

        onStationsChanged: {
            stationTest.model = iRail.stations;
        }
    }

    SilicaListView {
                id: connectionTest
                anchors.fill: parent
                delegate: ListItem {
                    width: ListView.view.width
                    height: Theme.itemSizeExtraLarge*2
                    Column {
                        Label {text: model.id}
                        Label {text: model.from.station.name}
                        Label {text: model.to.station.name}
                    }
                }
                onModelChanged: console.log(count)
            }


    /*SilicaListView {
            id: stationTest
            anchors.fill: parent
            delegate: ListItem {
                width: ListView.view.width
                height: Theme.itemSizeExtraLarge*2
                Column {
                    Label {text: model.id}
                    Label {text: model.name}
                }
            }
            onModelChanged: console.log(count)
        }*/

    /*SilicaListView {
        id: vehicleTest
        anchors.fill: parent
        delegate: ListItem {
            width: ListView.view.width
            height: Theme.itemSizeExtraLarge*2
            Column {
                Label {text: model.platform}
                Label {text: model.departureDelay/60}
                Label {text: model.scheduledDepartureTime}
                Label {text: model.left}
                Label {text: model.station.name}
            }
        }
        onModelChanged: console.log(count)
    }*/

    /*SilicaListView {
        id: liveboardTest
        anchors.fill: parent
        delegate: ListItem {
            width: ListView.view.width
            height: Theme.itemSizeExtraLarge*2
            /*Column {
                Label {text: model.id}
                SilicaListView {
                    anchors.fill: parent;
                    model: liveboardTest.model.stops
                }

                Label {text: model.timestamp}
                Label {text: model.canceled}
            }*/

            /*ListView {
                anchors.fill: parent;
                model: liveboardTest.model.stops
                delegate: ListItem {
                    width: ListView.view.width
                    height: Theme.itemSizeExtraLarge
                    Label {
                        text: model.station.name
                    }
                    Label {
                        text: model.platform
                    }

                    Component.onCompleted: console.log(model.station.name)

                }
                onModelChanged: console.log(count)
            }

            Column {

            Label {
                text: model.id
            }

            Repeater {
                id: stopsTest
                model: liveboardTest.model.stops
                onModelChanged: console.log("STOPS MODEL COUNT=" + count)
            }
            }
        }
        onModelChanged: stopsTest.model = model.stops
    }*/

    /*ListModel {
          id: fruitModel

          ListElement {
              name: "Apple"
              cost: 2.45
          }
          ListElement {
              name: "Orange"
              cost: 3.25
          }
          ListElement {
              name: "Banana"
              cost: 1.95
          }
      }


    Component {
        id: delegate2

        Item {
            width: 100
            height: col2.childrenRect.height

            Column {
                id: col2
                anchors.left: parent.left
                anchors.right: parent.right
                Text {
                    id: name1
                    text: model.name
                    color: "green"
                }
            }
        }
    }

    ListView {
        id: liveboardTest
        delegate: listdelegate
        anchors.fill: parent
    }

    Component {
        id: listdelegate

        Item {
            width: 100
            height: col.childrenRect.height

            Column {
                id: col
                anchors.left: parent.left
                anchors.right: parent.right
                Text {
                    id: t1
                    text: model.id
                    color: "red"
                }
                ListView {
                    id: insidelist
                    delegate: delegate2
                    contentHeight: contentItem.childrenRect.height
                    height: childrenRect.height
                    anchors.left: parent.left
                    anchors.right: parent.right
                    clip: true
                }
            }
        }
    }*/

    /*SilicaFlickable {
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
                //model: iRail.getDisturbances() //alertsModel
            }

            SilicaListView {
                id: vehicleTest
                width: parent.width
                delegate: Item {
                    width: ListView.view.width
                    height: Theme.itemSizeSmall
                    Column {
                        Label {text: model.platform}
                        Label {text: model.departureDelay}
                        Label {text: model.scheduledDepartureTime}
                        Label {text: model.left}
                    }
                }
                onModelChanged: console.log(count)
            }

            ListModel {
                id: alertsModel
            }
        }
    }*/
}

