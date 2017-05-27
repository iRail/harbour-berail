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
                alertsModel: tripModel.get(indexModel).alerts.alerts
                showAlerts: false
                Component.onCompleted: expanded = true
            }
        }
    }
}
