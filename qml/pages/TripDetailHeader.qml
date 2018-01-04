import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import "../js/util.js" as Utils

Rectangle {
    property string vehicle
    property int alertsCount

    width: parent.width
    height: Theme.itemSizeExtraLarge
    color: Theme.secondaryHighlightColor

    Label {
        width: parent.width
        anchors.centerIn: parent
        font.pixelSize: Theme.fontSizeExtraLarge
        font.bold: true
        truncationMode: TruncationMode.Fade
        horizontalAlignment: Text.AlignHCenter
        text: vehicle
    }

    ImageLabel {
        anchors {
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
            bottom: parent.bottom
            bottomMargin: Theme.paddingMedium
        }
        visible: alertsCount > 0
        text: alertsCount
        source: "qrc:///icons/icon-alert.png"
    }
}
