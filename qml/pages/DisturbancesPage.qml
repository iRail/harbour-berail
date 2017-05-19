import QtQuick 2.2
import Sailfish.Silica 1.0
import "./components"
import "./js/liveboard.js" as LiveBoard

Page {
    id: page

    property string station
    property var alertsModel

    // Show detailed list of all alerts for this station
    DisturbancesView {
        height: parent.height
        header: PageHeader {
            title: qsTr("Disturbances")
            description: station
        }
        model: alertsModel
        showStation: false // Already visible in the header
    }
}
