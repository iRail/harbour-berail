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

import QtQuick 2.2
import Sailfish.Silica 1.0
import Nemo.Configuration 1.0
import "pages"
import "components"

ApplicationWindow
{
    id: app
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    // Colors
    readonly property string blue: "#3f51b5"
    readonly property string red: "#f44336"
    readonly property string green: "#43a047"
    readonly property string orange: "#f9a825"
    readonly property string yellow: "#ffeb3b"
    readonly property string grey: "#37474f"
    readonly property string black: "#263238"
    readonly property string white: "#fffde7"
    readonly property string transparent: "transparent"

    // Enable/Disable fade values
    readonly property real fadeOutValue: 0.4
    readonly property real fadeInValue: 1.0

    // App settings
    ConfigurationGroup {
        id: settings
        path: "/apps/harbour-berail/settings"

        property bool rememberLiveboardStation: true
        property bool favouriteStationsEnabled
        property int timeIs
        property string favouriteFromStation
        property string favouriteToStation
        property string savedLiveboardStation
    }
}

