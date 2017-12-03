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
//import io.thp.pyotherside 1.3
import org.nemomobile.configuration 1.0
import "pages"
import "./pages/js/util.js" as Util

ApplicationWindow
{
    id: app
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    readonly property string name: "BeRail"
    readonly property string version: "1.1"

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

    property bool pythonReady

    // App settings
    ConfigurationGroup {
        id: settings
        path: "/apps/harbour-berail/settings"

        property bool rememberLiveboardStation: true
        property bool favouriteStations
        property int arriveFromGivenTime
        property string lastLiveboardStation
        property string favouriteDepartStation
        property string favouriteArriveStation
    }

    /*Python {
            id: python
            property bool _networkWasLost

            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl("./backend")); //Add the import path for our QML/Python bridge 'app.py'
                addImportPath(Qt.resolvedUrl("./backend/berail")); //Add import path for our backend module 'sailfinder'
                importModule("platform", function() {   //Add the right import path depending on the architecture of the processor
                    if (evaluate("platform.machine()") == "armv7l") {
                        console.info("[INFO] ARM processor detected")
                        addImportPath(Qt.resolvedUrl("./backend/lib/armv7l/"));
                    } else {
                        console.info("[INFO] x86 processor detected")
                        addImportPath(Qt.resolvedUrl("./backend/lib/i486/"));
                    }
                    importModule("app", function() {}); // Import "app" after we imported our platform specific modules
                    Util.updatePythonLocal() // When done, pythonReady will be TRUE
                });

                //Notify user of the current network state
                setHandler("network", function (status) {
                    if(!status)
                    {
                        toaster.previewBody = qsTr("Network down") + "!"
                        toaster.publish()
                        _networkWasLost = true
                    }
                    else if (_networkWasLost) {
                        toaster.previewBody = qsTr("Network recovered") + "!"
                        toaster.publish()
                        _networkWasLost = false
                    }
                });

            }
            onError: console.error("[ERROR] %1".arg(traceback));
            onReceived: console.info("[INFO] Message: " + JSON.stringify(data));
        }*/
}

