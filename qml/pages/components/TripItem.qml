import QtQuick 2.2
import Sailfish.Silica 1.0
import "../js/trip.js" as Trip

Item { // Reuse it for TripDetailPage and TripDetail
    width: parent.width
    height: tripColumn.height + Theme.paddingLarge //Extra margins

    //Properties
    property string departTime
    property string departStation
    property int departTrack: 1
    property int departDelay: 20
    property string arriveTime
    property string arriveStation
    property string train
    property int arriveTrack: 5
    property int arriveDelay: 2
    property int currentStop: 2
    property bool trainCanceled: Math.random() > 0.9
    property bool expanded: false
    property bool showAnnouncement: true
    property var changes
    property var changesDelays
    property var announcements

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
                color: "#43a047"
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
                anchors { left: departTimeItem.right; leftMargin: Theme.paddingLarge }
                font.capitalization: Font.AllUppercase
                text: departStation
            }

            // Track number
            Label {
                anchors { top: departStationLabel.bottom; left: departTimeItem.right; leftMargin: Theme.paddingLarge }
                text: qsTr("Track %1").arg(departTrack)
                font.pixelSize: Theme.fontSizeTiny*1.2
            }

            // Train & journey information
            Item {
                width: Theme.itemSizeMedium
                height: childrenRect.height
                anchors { right: parent.right; rightMargin: Theme.horizontalPageMargin }
                visible: changes.length > 0

                // Train name
                Label {
                    id: trainName
                    width: parent.width
                    wrapMode: Text.WordWrap
                    truncationMode: TruncationMode.Fade
                    text: train
                }

                // #Changes
                Label {
                    id: changeLabel
                    anchors { top: trainName.bottom; topMargin: Theme.paddingMedium }
                    text: changes.length
                    visible: changes.length > 0
                }

                Image {
                    id: changeIcon
                    width: Theme.iconSizeSmall
                    height: width
                    anchors { verticalCenter: changeLabel.verticalCenter; left: changeLabel.right; leftMargin: Theme.paddingMedium }
                    source: "qrc:///icons/icon-change.png"
                    visible: changeLabel.visible
                    asynchronous: true
                }

                // Announcements
                Label {
                    id: announcementLabel;
                    anchors { top: changeIcon.bottom; topMargin: Theme.paddingMedium }
                    text: announcements.length
                    visible: announcements.length
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
                        model: 5
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
                                visible: !changeStopBullet.visible
                                color: index > currentStop? Theme.highlightDimmerColor: Theme.highlightColor
                            }

                            // Change required stop
                            Rectangle {
                                id: changeStopBullet
                                y: changeStopDelayLabel.visible? -height/4: 0 //Use the space in both directions if bigger then other items
                                width: Theme.itemSizeSmall
                                height: changeStopDelayLabel.visible? Theme.itemSizeSmall/2 + changeStopDelayLabel.height: Theme.itemSizeSmall/2
                                scale: expanded? 1.0: 0.0 // Animate size: 0 <-> full size
                                radius: width/7
                                color: "#f9a825"
                                visible: changes[0] == index
                                Behavior on height { NumberAnimation { duration: 750 } }
                                Behavior on width { NumberAnimation { duration: 750 } }

                                // Change time
                                Label {
                                    id: changeStopTimeLabel
                                    anchors { horizontalCenter: parent.horizontalCenter }
                                    text: "23:48"//changes.time[_changeIndex]
                                    font.pixelSize: Theme.fontSizeSmall
                                    font.bold: true
                                }

                                // Delay
                                Label {
                                    id: changeStopDelayLabel
                                    anchors { top: changeStopTimeLabel.bottom; horizontalCenter: parent.horizontalCenter }
                                    text: Trip.formatDelay(changesDelays[0])
                                    visible: changesDelays[0] > 0
                                    font.pixelSize: Theme.fontSizeTiny
                                    font.bold: true
                                }
                            }

                            // Stop name
                            Label {
                                anchors { left: changeStopBullet.visible? changeStopBullet.right: stopBullet.right; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingMedium; verticalCenter: parent.verticalCenter }
                                font.capitalization: Font.SmallCaps
                                text: "Eppegem " + index
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
                color: "#f44336"
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
                anchors { left: arriveTimeItem.right; leftMargin: Theme.paddingLarge }
                font.capitalization: Font.AllUppercase
                text: arriveStation
            }

            // Track number
            Label {
                anchors { top: arriveStationLabel.bottom; left: arriveTimeItem.right; leftMargin: Theme.paddingLarge }
                text: qsTr("Track %1").arg(arriveTrack)
                font.pixelSize: Theme.fontSizeTiny*1.2
            }
        }
        SectionHeader { text: qsTr("Announcement"); opacity: _hasAnnouncement && showAnnouncement? 1.0: 0.0; visible: !opacity==0.0 }
        TextLabel { opacity: _hasAnnouncement && showAnnouncement? 1.0: 0.0; visible: !opacity==0.0; labelText: announcements[0] }
    }

    // Train canceled overlay
    Item {
        width: parent.width
        height: parent.height
        visible: trainCanceled

        // Nice background
        Rectangle {
            anchors { fill: parent }
            opacity: 0.70
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
            color: Theme.highlightColor
            font.bold: true
            font.capitalization: Font.AllUppercase
            font.pixelSize: Theme.fontSizeLarge
        }
    }
}
