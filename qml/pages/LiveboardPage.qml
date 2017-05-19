import QtQuick 2.2
import Sailfish.Silica 1.0
import "./components"
import "./js/liveboard.js" as LiveBoard

Page {
    id: page
    property string station: "Brussels-Central"
    property string currentTime: LiveBoard.getTimeString()
    property bool succes: true
    property bool _loading: liveboardModel.count==0 && succes

    onStationChanged: LiveBoard.load(station)
    Component.onCompleted: LiveBoard.load(station)

    Timer { // Update the clock
        running: Qt.application.active
        onTriggered: currentTime = LiveBoard.getTimeString()
        interval: 500
        triggeredOnStart: true
        repeat: true
    }

    SilicaListView {
        id: departureList
        width: parent.width; height: parent.height
        model: liveboardModel
        header: Rectangle {
            color: "#3f51b5"
            width: parent.width
            height: Theme.itemSizeHuge*1.2

            // Station name
            Label {
                id: stationLabel
                width: parent.width
                anchors { left: parent.left; right: parent.right; top: parent.top; topMargin: Theme.paddingLarge; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                font.pixelSize: Theme.fontSizeHuge
                font.bold: true
                truncationMode: TruncationMode.Fade
                horizontalAlignment: Text.AlignHCenter
                text: station
            }

            // Time
            Label {
                anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; verticalCenter: alertsButton.verticalCenter } //bottom: parent.bottom; bottomMargin: Theme.paddingMedium }
                font.bold: true
                truncationMode: TruncationMode.Fade
                horizontalAlignment: Text.AlignLeft
                text: currentTime
            }

            // Alerts indicator
            BackgroundItem {
                id: alertsButton
                width: Theme.itemSizeLarge
                anchors { bottom: parent.bottom; bottomMargin: Theme.paddingMedium; right: parent.right; rightMargin: Theme.horizontalPageMargin }
                onClicked: pageStack.push("DisturbancesPage.qml", { alertsModel: alertsModel, station: station });
                visible: alertsModel.count

                Label {
                    id: alertsLabel;
                    anchors { right: alertsIcon.left; rightMargin: Theme.paddingMedium; verticalCenter: parent.verticalCenter }
                    text: alertsModel.count
                }

                Image {
                    id: alertsIcon
                    width: Theme.iconSizeSmall
                    height: width
                    anchors { right: parent.right; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter}
                    source: "qrc:///icons/icon-announcement.png"
                    asynchronous: true
                }
            }
        }

        PullDownMenu {
            busy: _loading

            MenuItem {
                text: qsTr("Change station")
                enabled: !_loading
                onClicked: {
                    var _page = pageStack.push("StationListPage.qml");
                    _page.finished.connect(function(newStation) {
                        station = newStation;
                    });
                }
            }

            MenuItem {
                text: qsTr("Disturbances (%1)").arg(alertsModel.count )
                visible: alertsModel.count > 0
                enabled: !_loading
                onClicked: pageStack.push("DisturbancesPage.qml", { alertsModel: alertsModel, station: station });
            }
        }

        // Error occured
        ViewPlaceholder {
            enabled: !succes
            text: qsTr("Oops!")
            hintText: qsTr("No data available")
        }

        delegate: ListItem {
            width: ListView.view.width
            contentHeight: item.height
            enabled: false // Disabled temporaly until intermediate stops are ready
            LiveBoardItem {
                id: item
                departTime: model.depart.time.time
                announcements: ["From Saturday 29/04 to 1/05, trains will not stop at Brussels-Central station following works between Brussels-Nord and Brussels-Midi. There will be major changes to the train service. Alternative train service Bruxelles-Nord/Brussel-Noord - Bruxelles-Midi/Brussel-Zuid"]
                trainName: model.depart.station
                trainType: model.depart.train
                trackChanged: model.depart.platformChanged
                trainCanceled: model.depart.canceled
                modelHasDelay: model.hasDelay
                delay: model.depart.delay
                track: model.depart.platform
            }

            Rectangle {
                id: background
                z:-1 // Make ListItem Highlight visible
                color: index%2? "#263238": "#37474f"
                anchors { fill: parent }
            }
            onClicked: {
                if(!item.canceled) {
                    pageStack.push(Qt.resolvedUrl("TripDetailPage.qml"))
                }
            }
        }

        // Show detailed list of all alerts for this station
        DisturbancesView { // TO DO: Move to seperate page or something
            id: alertsView
            anchors { top: departureList.bottom; topMargin: Theme.paddingLarge }
            model: alertsModel
        }
    }

    LoadIndicator {
        anchors { fill: parent }
        show: _loading
    }

    ListModel {
        id: liveboardModel
    }

    ListModel {
        id: alertsModel
    }
}
