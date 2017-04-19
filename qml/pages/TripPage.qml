import QtQuick 2.2
import Sailfish.Silica 1.0
import "./components"

Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: aboutColumn.height

        VerticalScrollDecorator {}

        Column {
            id: aboutColumn
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader { id: header; title: qsTr("Trip planner") }

            SilicaListView {
                width: parent.width; height: Screen.height - header.height - Theme.paddingLarge
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
                    TripItem {
                        id: item
                        departStation: "Vilvoorde"
                        departTime: "23:24"
                        arriveStation: "MECHELEN"
                        arriveTime: "23:59"
                        changes: [2]
                        changesDelays: [5]
                        announcements: ["From Saturday 29/04 to 1/05, trains will not stop at Brussels-Central station following works between Brussels-Nord and Brussels-Midi. There will be major changes to the train service. Alternative train service Bruxelles-Nord/Brussel-Noord - Bruxelles-Midi/Brussel-Zuid"]
                        showAnnouncement: false
                        train: "IC5379"
                        expanded: false
                    }
                    onClicked: {
                        if(!item.trainCanceled) {
                            //expanded? expanded=false: expanded=true
                            pageStack.push(Qt.resolvedUrl("TripDetailPage.qml"))
                        }
                    }
                }
            }
        }
    }
}
