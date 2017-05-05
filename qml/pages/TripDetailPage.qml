import QtQuick 2.2
import Sailfish.Silica 1.0
import "./components"

Page {
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
                departStation: "Vilvoorde"
                departTime: "23:24"
                arriveStation: "MECHELEN"
                arriveTime: "23:59"
                vias: [2]
                changesDelays: [5]
                alerts: ["From Saturday 29/04 to 1/05, trains will not stop at Brussels-Central station following works between Brussels-Nord and Brussels-Midi. There will be major changes to the train service. Alternative train service Bruxelles-Nord/Brussel-Noord - Bruxelles-Midi/Brussel-Zuid"]
                arriveTrain: "IC5379"
                departTrain: "P2647"
                Component.onCompleted: expanded = true // Expand when ready
            }
        }
    }
}
