/*
*   This file is part of BeRail.
*
*   BeRail is free software: you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation, either version 3 of the License, or
*   (at your option) any later version.
*
*   Foobar is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with BeRail.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2
import Sailfish.Silica 1.0
import "./components"
import "./js/liveboard.js" as LiveBoard

Page {
    id: page
    property string station: settings.lastLiveboardStation
    property string currentTime: LiveBoard.getTimeString()
    property bool succes: true
    property bool _firstLaunch: settings.lastLiveboardStation.length == 0
    property bool _loading: liveboardModel.count==0 && succes && !_firstLaunch

    on_FirstLaunchChanged: _firstLaunch? hint.start(): hint.stop()

    onStationChanged: {
        LiveBoard.load(station)
        settings.rememberLiveboardStation? settings.lastLiveboardStation = station: undefined // Only save when activated in settings
        _firstLaunch = false
    }

    Timer { // Update the clock
        running: Qt.application.active
        onTriggered: currentTime = LiveBoard.getTimeString()
        interval: 500
        triggeredOnStart: true
        repeat: true
    }

    SilicaListView {
        id: departureList
        width: parent.width; height: parent.height
        model: liveboardModel
        header: Rectangle {
            color: app.blue
            width: parent.width
            height: Theme.itemSizeHuge*1.2

            // Station name
            Label {
                id: stationLabel
                width: parent.width
                anchors { left: parent.left; right: parent.right; top: parent.top; topMargin: Theme.paddingLarge; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                font.pixelSize: Theme.fontSizeHuge
                font.bold: true
                truncationMode: TruncationMode.Fade
                horizontalAlignment: Text.AlignHCenter
                text: _firstLaunch? qsTr("Liveboard"): station
            }

            // Time
            Label {
                anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; verticalCenter: alertsButton.verticalCenter } //bottom: parent.bottom; bottomMargin: Theme.paddingMedium }
                font.bold: true
                truncationMode: TruncationMode.Fade
                horizontalAlignment: Text.AlignLeft
                text: currentTime
            }

            // Alerts indicator
            BackgroundItem {
                id: alertsButton
                width: Theme.itemSizeLarge
                anchors { bottom: parent.bottom; bottomMargin: Theme.paddingMedium; right: parent.right; rightMargin: Theme.horizontalPageMargin }
                onClicked: pageStack.push("DisturbancesPage.qml", { alertsModel: alertsModel, station: station });
                visible: alertsModel.count

                Label {
                    id: alertsLabel;
                    anchors { right: alertsIcon.left; rightMargin: Theme.paddingMedium; verticalCenter: parent.verticalCenter }
                    text: alertsModel.count
                }

                Image {
                    id: alertsIcon
                    width: Theme.iconSizeSmall
                    height: width
                    anchors { right: parent.right; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter}
                    source: "qrc:///icons/icon-announcement.png"
                    asynchronous: true
                }
            }
        }

        PullDownMenu {
            busy: _loading

            MenuItem {
                text: qsTr("Change station")
                enabled: !_loading
                onClicked: {
                    var _page = pageStack.push("StationListPage.qml");
                    _page.finished.connect(function(newStation) {
                        station = newStation;
                    });
                }
            }

            MenuItem {
                text: qsTr("Disturbances (%1)").arg(alertsModel.count )
                visible: alertsModel.count > 0
                enabled: !_loading
                onClicked: pageStack.push("DisturbancesPage.qml", { alertsModel: alertsModel, station: station });
            }
        }

        // Error occured
        ViewPlaceholder {
            enabled: !succes
            text: qsTr("Oops!")
            hintText: qsTr("No data available")
        }

        // When no data, show a hint and a placeholder
        InteractionHintLabel {
                anchors.bottom: parent.bottom
                opacity: _firstLaunch ? 1.0 : 0.0
                Behavior on opacity { FadeAnimation {} }
                text: qsTr("Select a station")
        }

        TouchInteractionHint {
            id: hint
            loops: Animation.Infinite
            direction: TouchInteraction.Down
        }

        delegate: ListItem {
            width: ListView.view.width
            contentHeight: item.height
            enabled: false // Disabled temporaly until intermediate stops are ready
            LiveBoardItem {
                id: item
                departTime: model.depart.time.time
                announcements: ["From Saturday 29/04 to 1/05, trains will not stop at Brussels-Central station following works between Brussels-Nord and Brussels-Midi. There will be major changes to the train service. Alternative train service Bruxelles-Nord/Brussel-Noord - Bruxelles-Midi/Brussel-Zuid"]
                trainName: model.depart.station
                trainType: model.depart.train
                trackChanged: model.depart.platformChanged
                trainCanceled: model.depart.canceled
                modelHasDelay: model.hasDelay
                delay: model.depart.delay
                track: model.depart.platform
            }

            Rectangle {
                id: background
                z:-1 // Make ListItem Highlight visible
                color: index%2? app.black: app.grey
                anchors { fill: parent }
            }
            onClicked: {
                if(!item.canceled) {
                    pageStack.push(Qt.resolvedUrl("TripDetailPage.qml"))
                }
            }
        }

        // Show detailed list of all alerts for this station
        DisturbancesView { // TO DO: Move to seperate page or something
            id: alertsView
            anchors { top: departureList.bottom; topMargin: Theme.paddingLarge }
            model: alertsModel
        }
    }

    LoadIndicator {
        anchors { fill: parent }
        show: _loading
    }

    ListModel {
        id: liveboardModel
    }

    ListModel {
        id: alertsModel
    }
}
