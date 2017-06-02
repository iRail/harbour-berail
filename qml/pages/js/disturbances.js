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

function load() {
    alertsModel.clear() // Make model empty

    python.call("app.disturbances.get_disturbances", [], function(disturbances) {
        if(disturbances) { // Valid trip is TRUE
            if("empty" in disturbances) { // No data available
                succes = false;
                return false;
            }
            for(var i=0; i < Object.keys(disturbances.disturbance).length; i++) { // Run through whole connection object
                alertsModel.append({
                                     "header": disturbances.disturbance[i].title,
                                     "description": disturbances.disturbance[i].description,
                                     "time": disturbances.disturbance[i].time,
                                     "id": disturbances.disturbance[i].id,
                                     "link": disturbances.disturbance[i].link
                                 });
            }
            return true;
        }
        else {
            succes = false;
            return false;
        }
    });
}
