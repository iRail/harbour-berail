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
import "../js/liveboard.js" as LiveBoard

Item {
    width: parent.width
    height: liveboardRow.height

    property string trainName
    property string trainType
    property string delay
    property string departTime
    property string track
    property bool trackChanged
    property bool trainCanceled
    property bool modelHasDelay
    property var announcements

    Row {
        id: liveboardRow
        width: parent.width
        height: Theme.itemSizeSmall
        anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }
        spacing: Theme.paddingLarge

        Label {
            id: departLabel
            anchors { verticalCenter: parent.verticalCenter }
            truncationMode: TruncationMode.Fade
            font.bold: true
            color: app.yellow
            text: departTime
        }

        Label {
            id: trainLabel
            width: parent.width-departLabel.width-typeLabel.width-trackLabel.width-liveboardRow.spacing*4 - (modelHasDelay? delayLabel.width: 0)
            anchors { verticalCenter: parent.verticalCenter }
            truncationMode: TruncationMode.Fade
            font.bold: true
            color: app.yellow
            text: trainName
        }

        Label {
            id: typeLabel
            anchors { verticalCenter: parent.verticalCenter }
            truncationMode: TruncationMode.Fade
            font.bold: true
            color: app.yellow
            text: page.isPortrait? trainType.substring(0,2): trainType
        }

        Rectangle {
            id: trackLabel
            color: trackChanged? app.yellow: app.transparent
            width: parent.height
            height: parent.height

            Label {
                anchors { centerIn: parent }
                truncationMode: TruncationMode.Fade
                font.bold: true
                color: trackChanged? app.black: app.yellow
                text: track
            }
        }

        Label {
            id: delayLabel
            anchors { verticalCenter: parent.verticalCenter }
            truncationMode: TruncationMode.Fade
            font.bold: true
            color: app.red
            visible: delay > 0
            text: LiveBoard.formatDelay(delay)
        }
    }

    CancelOverlay { visible: trainCanceled }
}