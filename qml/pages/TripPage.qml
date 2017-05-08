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
            enabled: !item.canceled // Disable TripDetailPage when train is canceled
            onClicked: pageStack.push(Qt.resolvedUrl("TripDetailPage.qml"))
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
                changesDelays: [5]
                alerts: [] //["From Saturday 29/04 to 1/05, trains will not stop at Brussels-Central station following works between Brussels-Nord and Brussels-Midi. There will be major changes to the train service. Alternative train service Bruxelles-Nord/Brussel-Noord - Bruxelles-Midi/Brussel-Zuid"]
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

    BusyIndicator {
        id: loadingIndicator
        anchors { centerIn: parent }
        running: Qt.application.active && tripModel.count==0 && succes
        size: BusyIndicatorSize.Large
    }

    Label {
        opacity: tripModel.count==0 && succes? 1.0: 0.0
        anchors { top: loadingIndicator.bottom; topMargin: Theme.paddingLarge; horizontalCenter: parent.horizontalCenter }
        text: qsTr("Loading") + "..."
        Behavior on opacity { FadeAnimation{} }
    }

    ListModel {
        id: tripModel
    }
}
