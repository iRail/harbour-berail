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
                delegate: TripItem {
                    width: ListView.view.width
                    departStation: "Vilvoorde"
                    departTime: "23:24"
                    arriveStation: "MECHELEN"
                    arriveTime: "23:59"
                    changes: [2]
                    changesDelays: [5]
                    train: "IC5379"
                }
            }
        }
    }
}
