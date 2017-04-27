import QtQuick 2.2
import Sailfish.Silica 1.0

// Train canceled overlay
Item {
    width: parent.width
    height: parent.height

    // Nice background
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

    // Canceled text
    Label {
        anchors { centerIn: parent }
        text: qsTr("canceled") + " :-("
        color: Theme.primaryColor
        font.bold: true
        font.capitalization: Font.AllUppercase
        font.pixelSize: Theme.fontSizeLarge
    }
}
