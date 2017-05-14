import QtQuick 2.2
import Sailfish.Silica 1.0
import "../js/disturbances.js" as Disturbances

SilicaListView {
    width: parent.width
    height: childrenRect.height
    delegate: ListItem {
        width: ListView.view.width
        contentHeight: item.height
        Column {
            id: item
            width: parent.width
            spacing: Theme.paddingLarge
            SectionHeader { text: model.header }
            TextLabel { labelText: model.description }
        }
    }
}
