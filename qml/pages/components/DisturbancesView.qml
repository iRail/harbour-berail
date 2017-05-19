import QtQuick 2.2
import Sailfish.Silica 1.0
import "../js/disturbances.js" as Disturbances

SilicaListView {
    width: parent.width
    height: childrenRect.height

    property bool showStation: true

    delegate: ListItem {
        width: ListView.view.width
        contentHeight: item.height*1.1
        enabled: model.hasOwnProperty("link")
        onClicked: Qt.openUrlExternally(model.link) // If model has link then open it when user clicks on the item
        Column {
            id: item
            width: parent.width
            anchors { centerIn: parent }
            spacing: Theme.paddingSmall
            SectionHeader { text: showStation? model.header.replace(".", ""): model.header.split(":")[1].replace(".", "") } // Remove "." at the end
            TextLabel { labelText: model.description }
        }
    }
}
