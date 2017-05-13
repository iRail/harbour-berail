import QtQuick 2.2
import Sailfish.Silica 1.0

Item {    
    anchors { fill: parent }

    property bool show

    BusyIndicator {
        id: loadingIndicator
        anchors { centerIn: parent }
        running: Qt.application.active && show //tripModel.count==0 && succes
        size: BusyIndicatorSize.Large
    }

    Label {
        opacity: show? 1.0: 0.0
        anchors { top: loadingIndicator.bottom; topMargin: Theme.paddingLarge; horizontalCenter: parent.horizontalCenter }
        text: qsTr("Loading") + "..."
        Behavior on opacity { FadeAnimation{} }
    }
}
