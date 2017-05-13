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
    property var changesDelays
    property var alerts
    property var stopsModel

    // Internal variables
    property var _hasDelay: [departDelay > 0, arriveDelay > 0]
    property int _changeIndex
    property bool _hasAnnouncement: Math.random() > 0.9

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
                width: parent.width - departTimeItem.width - journeyInformation.width - 2*Theme.paddingLarge
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
                    id: announcementLabel;
                    anchors { top: changeIcon.bottom; topMargin: Theme.paddingMedium }
                    text: alerts.length
                    visible: alerts.length
                }

                Image {
                    width: Theme.iconSizeSmall
                    height: width
                    anchors { verticalCenter: announcementLabel.verticalCenter; left: announcementLabel.right; leftMargin: Theme.paddingMedium }
                    source: "qrc:///icons/icon-announcement.png"
                    visible: announcementLabel.visible
                    asynchronous: true
                }
            }

        }

        // Traject
        Item {
            id: trajectItem
            width: parent.width
            height: expanded? Trip.calculateTraject(5): 0
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
                    height: expanded? Trip.calculateProgress(currentStop): 0
                    color: Theme.highlightColor
                    Behavior on height { NumberAnimation { duration: 500 } }
                }

                // Progress indicator stops
                Column {
                    anchors { horizontalCenter: traject.horizontalCenter; top: parent.top; topMargin: Theme.itemSizeSmall/4 }
                    spacing: Theme.paddingLarge*2
                    Repeater {
                        id: stopsProgress
                        model: stopsModel
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
                                    text: model.time
                                    font.pixelSize: Theme.fontSizeSmall
                                    font.bold: true
                                }

                                // Delay
                                Label {
                                    id: viaStopDelayLabel
                                    anchors { top: viaStopTimeLabel.bottom; horizontalCenter: parent.horizontalCenter }
                                    text: Trip.formatDelay(changesDelays[0])
                                    visible: model.delay
                                    font.pixelSize: Theme.fontSizeTiny
                                    font.bold: true
                                }
                            }

                            // Stop name
                            Label {
                                anchors { left: viaStopBullet.visible? viaStopBullet.right: stopBullet.right; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingMedium; verticalCenter: parent.verticalCenter }
                                font.capitalization: Font.SmallCaps
                                text: model.station
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
                width: parent.width - arriveTimeItem.width - journeyInformation.width - 2*Theme.paddingLarge
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
        SectionHeader { text: qsTr("Announcement"); opacity: _hasAnnouncement && showAlerts? 1.0: 0.0; visible: !opacity==0.0 }
        TextLabel { opacity: _hasAnnouncement && showAlerts? 1.0: 0.0; visible: !opacity==0.0; labelText: alerts[0] }
    }

    CancelOverlay { visible: canceled }
}
