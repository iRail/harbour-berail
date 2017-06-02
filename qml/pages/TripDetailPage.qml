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

Page {
    property var tripModel
    property int indexModel

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: tripDetailColumn.height

        VerticalScrollDecorator {}

        Column {
            id: tripDetailColumn
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader { title: qsTr("Trip detail") }

            TripItem {
                departStation: tripModel.get(indexModel).depart.station
                departTime: tripModel.get(indexModel).depart.time.time
                departDelay: tripModel.get(indexModel).depart.delay
                departTrain: tripModel.get(indexModel).depart.train
                departTrack: tripModel.get(indexModel).depart.platform
                departTrackChanged: tripModel.get(indexModel).depart.platformChanged
                arriveStation: tripModel.get(indexModel).arrival.station
                arriveTime: tripModel.get(indexModel).arrival.time.time
                arriveDelay: tripModel.get(indexModel).arrival.delay
                arriveTrain: tripModel.get(indexModel).arrival.train
                arriveTrack: tripModel.get(indexModel).arrival.platform
                arriveTrackChanged: tripModel.get(indexModel).arrival.platformChanged
                canceled: tripModel.get(indexModel).depart.canceled || tripModel.get(indexModel).arrival.canceled? true: false // When arrive or depart is canceled then this connection is not valid
                vias: tripModel.get(indexModel).vias.number
                viasModel: tripModel.get(indexModel).vias.via
                alerts: tripModel.get(indexModel).alerts.alert
                showAlerts: false
                Component.onCompleted: expanded = true
            }
        }
    }
}
