import QtQuick 2.2
import Sailfish.Silica 1.0
import "./components"
import "./js/liveboard.js" as LiveBoard

Page {
    property string station: "Vilvoorde"
    property string currentTime: LiveBoard.getTimeString()

    Timer { // Update the clock
        running: Qt.application.active
        onTriggered: currentTime = LiveBoard.getTimeString()
        interval: 500
        triggeredOnStart: true
        repeat: true
    }

    SilicaListView {
        width: parent.width; height: parent.height
        header: Rectangle {
            color: "#3f51b5"
            width: parent.width
            height: Theme.itemSizeHuge
            Label {
                width: parent.width/2
                anchors { right: parent.right; rightMargin: Theme.horizontalPageMargin; bottom: parent.bottom; bottomMargin: Theme.paddingLarge }
                font.pixelSize: Theme.fontSizeHuge
                font.bold: true
                truncationMode: TruncationMode.Fade
                horizontalAlignment: Text.AlignRight
                text: station
            }

            Label {
                anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; bottom: parent.bottom; bottomMargin: Theme.paddingLarge }
                font.bold: true
                truncationMode: TruncationMode.Fade
                horizontalAlignment: Text.AlignLeft
                text: currentTime
            }
        }

        model: ListModel {
            ListElement { fruit: "jackfruit" }
            ListElement { fruit: "orange" }
            ListElement { fruit: "lemon" }
            ListElement { fruit: "lychee" }
            ListElement { fruit: "apricots" }
        }
        delegate: ListItem {
            width: ListView.view.width
            contentHeight: item.height
            LiveBoardItem {
                id: item
                departTime: "23:24"
                announcements: ["From Saturday 29/04 to 1/05, trains will not stop at Brussels-Central station following works between Brussels-Nord and Brussels-Midi. There will be major changes to the train service. Alternative train service Bruxelles-Nord/Brussel-Noord - Bruxelles-Midi/Brussel-Zuid"]
                trainName: "Antwerpen-Centraal"
                trainType: "IC"
                delay: "+0H05"
                track: 5
            }

            Rectangle {
                id: background
                z:-1 // Make Listview Highlight visible
                color: index%2? "#263238": "#37474f"
                anchors { fill: parent }
            }
            onClicked: {
                if(!item.trainCanceled) {
                    pageStack.push(Qt.resolvedUrl("TripDetailPage.qml"))
                }
            }
        }
    }
}
