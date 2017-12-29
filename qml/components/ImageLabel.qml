/*
*   This file is part of BeRail.
*
*   BeRail is free software: you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation, either version 3 of the License, or
*   (at your option) any later version.
*
*   BeRail is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with BeRail.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Row {
    property string text
    property string source

    id: imageLabel
    spacing: Theme.paddingMedium

    Label {
        id: label
        text: imageLabel.text
    }

    Image {
        width: Theme.iconSizeSmall
        height: Theme.iconSizeSmall
        anchors.verticalCenter: parent.verticalCenter
        source: imageLabel.source
    }
}
