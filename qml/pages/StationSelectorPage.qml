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
import Harbour.BeRail.API 1.0
import "../components"

Page {
    property string _searchString
    signal selected(string station)

    id: searchPage

    API {
        id: api
        Component.onCompleted: api.getStations()
        onStationsChanged: stationListView.model = api.stations
    }

    SilicaListView {
        id: stationListView
        anchors.fill: parent
        header: StationSelectorHeader {
            id: header
            onSearchStringChanged: {
                _searchString = header.searchString
                api.stations.searchName = header.searchString
                console.debug("Searching for: " + api.stations.searchName)
            }
            onFocusChanged: console.debug("Focus stealing")
        }
        delegate: StationSelectorDelegate {
            id: delegate
            searchString: _searchString
            onClicked: {
                searchPage.selected(model.name)
                console.debug("Station selected:" + model.name)
                pageStack.pop()
            }
        }
    }
}
