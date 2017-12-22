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
import "../components"

Page {
    SilicaListView {
        anchors.fill: parent
        header: ConnectionSelectorDelegate {}

        PullDownMenu {
            MenuItem {
                //: Liveboard PullDownMenu item
                //% "Liveboard"
                //~ Overview of all departing/arriving trains in a station.
                text: qsTrId("berail-liveboard")
            }

            MenuItem {
                //: Settings PullDownMenu item
                //% "Settings"
                //~ Settings for the application.
                text: qsTrId("berail-settings")
            }
        }
    }
}
