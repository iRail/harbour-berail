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
