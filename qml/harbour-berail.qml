/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import org.nemomobile.configuration 1.0
import "pages"

ApplicationWindow
{
    id: app
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    readonly property string name: "BeRail"
    readonly property string version: "V0.1"

    // Colors
    readonly property string blue: "#2196f3"
    readonly property string red: "#f44336"
    readonly property string green: "#43a047"
    readonly property string orange: "#f9a825"
    readonly property string yellow: "#ffeb3b"
    readonly property string grey: "#37474f"
    readonly property string black: "#263238"
    readonly property string white: "#fffde7"

    property bool pythonReady

    Python {
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
                    pythonReady = true
                    call("app.stations.get_list", [], function(result) {
                                console.log(JSON.stringify(result))
                            })
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
        }
}

