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
