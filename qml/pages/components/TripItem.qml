import QtQuick 2.2
import Sailfish.Silica 1.0
import "../js/trip.js" as Trip

Item { // Reuse it for TripDetailPage and TripDetail
    width: parent.width
    height: tripColumn.height + Theme.paddingLarge //Extra margins

    //Properties
    property string departTime
    property string departStation
    property string departTrain
    property string departTrack
    property bool departTrackChanged
    property int departDelay
    property string arriveTime
    property string arriveStation
    property string arriveTrain
    property string arriveTrack
    property bool arriveTrackChanged
    property int arriveDelay
    property int currentStop
    property bool canceled
    property bool expanded
    property bool showAlerts: true
    property var vias
    property var viasModel
    property var alerts
    property var stopsModel: viasModel // BeRail V1.X build stopsModel with intermediate stops

    // Internal variables
    property var _hasDelay: [departDelay > 0, arriveDelay > 0]
    property int _changeIndex
    property bool _hasAlert: alerts.length > 0

    onAlertsChanged: Trip.convertAlertsToListmodel(alerts)

    Column {
        id: tripColumn
        width: parent.width
        anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }

        // Depart item
        Item {
            width: parent.width
            height: Theme.itemSizeSmall

            // Depart time
            Rectangle {
                id: departTimeItem
                width: Theme.itemSizeMedium
                height: Theme.itemSizeSmall
                scale: expanded? 1.0: 0.9
                radius: width/7
                color: app.green
                Behavior on height { NumberAnimation { duration: 750 } }
                Behavior on width { NumberAnimation { duration: 750 } }

                Label {
                    id: departTimeLabel
                    anchors { centerIn: _hasDelay[0]? undefined: parent; top: _hasDelay[0]? parent.top: undefined; topMargin: Theme.paddingSmall; horizontalCenter: _hasDelay[0]? parent.horizontalCenter: undefined }
                    font.bold: true
                    text: departTime
                }

                Label {
                    id: departDelayLabel
                    anchors { top: departTimeLabel.bottom; horizontalCenter: parent.horizontalCenter }
                    text: Trip.formatDelay(departDelay)
                    visible: _hasDelay[0]
                    font.pixelSize: Theme.fontSizeTiny
                    font.bold: true
                }
            }

            // Depart station name
            Label {
                id: departStationLabel
                width: parent.width - departTimeItem.width - journeyInformation.width - 3*Theme.paddingLarge
                anchors { left: departTimeItem.right; leftMargin: Theme.paddingLarge }
                truncationMode: TruncationMode.Fade
                font.capitalization: Font.AllUppercase
                text: departStation
            }

            // Track number
            Label {
                id: departTrackLabel
                z: 1
                anchors { top: departStationLabel.bottom; left: departTimeItem.right; leftMargin: Theme.paddingLarge }
                text: departTrack.length > 0? qsTr("Track %1").arg(departTrack): qsTr("Track ???") // Placeholder when unknown
                visible: true //settings.showUnknownTrackLabel
                font.pixelSize: Theme.fontSizeTiny*1.2
            }

            Rectangle {
                width: departTrackLabel.width*1.25
                height: departTrackLabel.height*1.05
                radius: width/4
                opacity: Theme.highlightBackgroundOpacity
                anchors { centerIn: departTrackLabel }
                color: app.yellow
                visible: departTrackChanged
            }

            // Train & journey information
            Item {
                id: journeyInformation
                width: Theme.itemSizeMedium
                height: childrenRect.height
                anchors { right: parent.right; rightMargin: Theme.horizontalPageMargin }

                // Train name
                Label {
                    id: trainName
                    width: parent.width
                    wrapMode: Text.WordWrap
                    truncationMode: TruncationMode.Fade
                    text: departTrain //train
                }

                // #Vias
                Label {
                    id: viasLabel
                    anchors { top: trainName.bottom; topMargin: Theme.paddingMedium }
                    text: vias
                    visible: vias
                }

                Image {
                    id: changeIcon
                    width: Theme.iconSizeSmall
                    height: width
                    anchors { verticalCenter: viasLabel.verticalCenter; left: viasLabel.right; leftMargin: Theme.paddingMedium }
                    source: "qrc:///icons/icon-change.png"
                    visible: vias
                    asynchronous: true
                }

                // Alerts
                Label {
                    id: alertsLabel;
                    anchors { top: changeIcon.bottom; topMargin: Theme.paddingMedium }
                    text: alerts.length
                    visible: _hasAlert
                }

                Image {
                    width: Theme.iconSizeSmall
                    height: width
                    anchors { verticalCenter: alertsLabel.verticalCenter; left: alertsLabel.right; leftMargin: Theme.paddingMedium }
                    source: "qrc:///icons/icon-announcement.png"
                    visible: _hasAlert
                    asynchronous: true
                }
            }

        }

        // Traject
        Item {
            id: trajectItem
            width: parent.width
            height: expanded? Trip.calculateTraject(viasModel.length): 0
            opacity: expanded? 1.0: 0.0
            Behavior on opacity { FadeAnimation { duration: expanded? 200: 750} } // Overlap with animation when closing
            Behavior on height { NumberAnimation { duration: 500 } }

            // Traject indicator + progress
            Rectangle {
                id: traject
                width: Theme.itemSizeSmall/4
                height: parent.height
                anchors { left: parent.left; leftMargin: departTimeLabel.x + departTimeLabel.width/2 - width/2 } // Center on labels
                color: Theme.highlightDimmerColor

                // Progress indicator
                Rectangle {
                    id: progress
                    width: Theme.itemSizeSmall/4
                    height: 0 //expanded? Trip.calculateProgress(currentStop): 0 BeRail V1.X
                    color: Theme.highlightColor
                    Behavior on height { NumberAnimation { duration: 500 } }
                }

                // Progress indicator stops
                Column {
                    anchors { horizontalCenter: traject.horizontalCenter; top: parent.top; topMargin: Theme.itemSizeSmall }
                    spacing: Theme.paddingLarge*3
                    Repeater {
                        id: stopsProgress
                        model: viasModel
                        Item {
                            width: Theme.itemSizeSmall
                            height: Theme.itemSizeSmall/2

                            // Normal stop
                            Rectangle {
                                id: stopBullet
                                width: Theme.itemSizeSmall/2
                                height: width
                                anchors { horizontalCenter: parent.horizontalCenter }
                                radius: width/2
                                visible: !viaStopBullet.visible
                                color: index > currentStop? Theme.highlightDimmerColor: Theme.highlightColor
                            }

                            // Change required stop
                            Rectangle {
                                id: viaStopBullet
                                y: viaStopDelayLabel.visible? -height/4: 0 //Use the space in both directions if bigger then other items
                                width: Theme.itemSizeSmall
                                height: viaStopDelayLabel.visible? Theme.itemSizeSmall/2 + viaStopDelayLabel.height: Theme.itemSizeSmall/2
                                scale: expanded? 1.0: 0.0 // Animate size: 0 <-> full size
                                radius: width/7
                                color: app.orange
                                visible: true //changes == index TO DO
                                Behavior on height { NumberAnimation { duration: 750 } }
                                Behavior on width { NumberAnimation { duration: 750 } }

                                // Change time
                                Label {
                                    id: viaStopTimeLabel
                                    anchors { horizontalCenter: parent.horizontalCenter }
                                    text: modelData.depart.time.time
                                    font.pixelSize: Theme.fontSizeSmall
                                    font.bold: true
                                }

                                // Delay
                                Label {
                                    id: viaStopDelayLabel
                                    anchors { top: viaStopTimeLabel.bottom; horizontalCenter: parent.horizontalCenter }
                                    text: Trip.formatDelay(modelData.depart.delay)
                                    visible: modelData.depart.delay > 0
                                    font.pixelSize: Theme.fontSizeTiny
                                    font.bold: true
                                }
                            }

                            // Stop name
                            Label {
                                id: viaStopStationLabel
                                anchors { left: viaStopBullet.visible? viaStopBullet.right: stopBullet.right; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingMedium; verticalCenter: parent.verticalCenter }
                                font.capitalization: Font.SmallCaps
                                text: modelData.station
                            }

                            Label {
                                anchors { left: viaStopBullet.visible? viaStopBullet.right: stopBullet.right; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingMedium; top: viaStopStationLabel.bottom; topMargin: Theme.paddingSmall }
                                font.pixelSize: Theme.fontSizeTiny
                                text: qsTr("Track %1 → Track %2").arg(modelData.arrival.platform).arg(modelData.depart.platform) + "   |   ⏱" + modelData.timebetween
                            }
                        }
                    }
                }
            }
        }

        // Arrive item
        Item {
            width: parent.width
            height: Theme.itemSizeSmall


            // Arrive time
            Rectangle {
                id: arriveTimeItem
                width: Theme.itemSizeMedium
                height: Theme.itemSizeSmall
                scale: expanded? 1.0: 0.9
                radius: width/7
                color: app.red
                Behavior on height { NumberAnimation { duration: 750 } }
                Behavior on width { NumberAnimation { duration: 750 } }

                Label {
                    id: arriveTimeLabel
                    anchors { centerIn: _hasDelay[1]? undefined: parent; top: _hasDelay[1]? parent.top: undefined; topMargin: Theme.paddingSmall; horizontalCenter: _hasDelay[1]? parent.horizontalCenter: undefined }
                    font.bold: true
                    text: arriveTime
                }

                Label {
                    id: arriveDelayLabel
                    anchors { top: arriveTimeLabel.bottom; horizontalCenter: parent.horizontalCenter }
                    text: Trip.formatDelay(arriveDelay)
                    visible: _hasDelay[1]
                    font.pixelSize: Theme.fontSizeTiny
                    font.bold: true
                }
            }

            // Arrive station name
            Label {
                id: arriveStationLabel
                width: parent.width - arriveTimeItem.width - journeyInformation.width - 3*Theme.paddingLarge
                anchors { left: arriveTimeItem.right; leftMargin: Theme.paddingLarge }
                truncationMode: TruncationMode.Fade
                font.capitalization: Font.AllUppercase
                text: arriveStation
            }

            // Track number
            Label {
                id: arriveTrackLabel
                z: 1
                anchors { top: arriveStationLabel.bottom; left: arriveTimeItem.right; leftMargin: Theme.paddingLarge }
                text: arriveTrack.length > 0? qsTr("Track %1").arg(arriveTrack): qsTr("Track ???")
                visible: true //settings.showUnknownTrackLabel
                font.pixelSize: Theme.fontSizeTiny*1.2
            }

            Rectangle {
                width: arriveTrackLabel.width*1.25
                height: arriveTrackLabel.height*1.05
                anchors { centerIn: arriveTrackLabel }
                radius: width/4
                opacity: Theme.highlightBackgroundOpacity
                color: app.yellow
                visible: arriveTrackChanged
            }

            Item {
                width: Theme.itemSizeMedium
                height: childrenRect.height
                anchors { right: parent.right; rightMargin: Theme.horizontalPageMargin }
                visible: expanded // Only show when enough space is allocated

                // Train name
                Label {
                    id: trainNameArrive
                    width: parent.width
                    wrapMode: Text.WordWrap
                    truncationMode: TruncationMode.Fade
                    text: arriveTrain //train
                }
            }
        }

        ListModel {
            id: alertsModel
        }

        DisturbancesView {
            id: alertsView
            model: alertsModel
            showStation: false
            visible: expanded // Only visible when expanded
        }
    }

    CancelOverlay { visible: canceled }
}
