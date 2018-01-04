import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    width: parent.width
    height: parent.height

    Rectangle {
        anchors { fill: parent }
        opacity: 0.75
        gradient: Gradient {
            GradientStop { position: 0.0; color: Theme.highlightBackgroundColor }
            GradientStop { position: 0.33; color: Theme.highlightDimmerColor }
            GradientStop { position: 0.66; color: Theme.highlightDimmerColor }
            GradientStop { position: 1.0; color: Theme.highlightBackgroundColor }
        }
    }

    Label {
        anchors { centerIn: parent }
        //% "Canceled"
        text: qsTrId("berail-canceled") + " :-("
        color: Theme.primaryColor
        font.bold: true
        font.capitalization: Font.AllUppercase
        font.pixelSize: Theme.fontSizeLarge
    }
}
