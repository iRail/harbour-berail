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
import "./js/trip.js" as Trip

Page {
    property string from
    property string to
    property string time
    property string date
    property bool succes: true //Wait until changed
    Component.onCompleted: Trip.load(from, to, time, date)

    SilicaListView {
        width: parent.width; height: parent.height
        header: PageHeader { title: qsTr("Trip planner") }
        model: tripModel
        delegate: ListItem {
            width: ListView.view.width
            contentHeight: item.height
            //enabled: false //Temp disabled TripDetailPage until we figured out how to show intermediate stops //!item.canceled // Disable TripDetailPage when train is canceled
            onClicked: pageStack.push(Qt.resolvedUrl("TripDetailPage.qml"), { tripModel: tripModel, indexModel: index })
            TripItem {
                id: item
                departStation: model.depart.station
                departTime: model.depart.time.time
                departDelay: model.depart.delay
                departTrain: model.depart.train
                departTrack: model.depart.platform
                departTrackChanged: model.depart.platformChanged
                arriveStation: model.arrival.station
                arriveTime: model.arrival.time.time
                arriveDelay: model.arrival.delay
                arriveTrain: model.arrival.train
                arriveTrack: model.arrival.platform
                arriveTrackChanged: model.arrival.platformChanged
                canceled: model.depart.canceled || model.arrival.canceled? true: false // When arrive or depart is canceled then this connection is not valid
                vias: model.vias.number
                viasModel: model.vias.via
                alerts: model.alerts.alert
                showAlerts: false
                expanded: false
            }
        }

        ViewPlaceholder {
            enabled: !succes
            text: qsTr("No connections found")
            hintText: qsTr("Try another station") + "..."
        }
    }

    LoadIndicator {
        anchors { fill: parent }
        show: tripModel.count==0 && succes
    }

    ListModel {
        id: tripModel
    }
}