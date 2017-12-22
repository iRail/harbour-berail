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

function convertAlertsToListmodel(data) {
    for(var i=0; i < data.length; i++) {
        alertsModel.append(data[i]);
    }
}

function calculateTraject(numberOfStops) {
    return numberOfStops*(Theme.itemSizeSmall/2) + (numberOfStops-1)*(3*Theme.paddingLarge) + 2*Theme.itemSizeSmall; // Each stop has a height of Theme.itemSizeSmall/2 for the stop itself, 2*Theme.paddingLarge as spacing and Theme.itemsSizeSmall as intial spacing
}

function calculateProgress(currentStop) {
    return currentStop*(Theme.itemSizeSmall/2 + 3*Theme.paddingLarge) + Theme.itemSizeSmall/2; // Middle of the current stop
}

function formatDelay(delay) {
    var hours = Math.floor(delay/60);
    var minutes = delay%60;
    if(minutes < 10) {
        return "+ " + hours + ":0" + minutes;
    }
    else {
        return "+ " + hours + ":" + minutes;
    }
}

function load(from, to, time, date, detail) {
    python.call("app.route.get_route", [from, to, formatTimeForAPI(time), formatDateForAPI(date), settings.arriveFromGivenTime], function(trip) {
        if(trip) { // Valid trip is TRUE
            succes = true; // Reset when previous request failed
            for(var i=0; i < Object.keys(trip).length; i++) { // Run through whole connection object
                tripModel.append({
                                     "depart": { "station": trip[i].departure.station,
                                         "stationinfo": trip[i].departure.stationinfo,
                                         "time": formatUnixTimeToUTC(trip[i].departure.time, true),
                                         "delay": trip[i].departure.delay,
                                         "canceled": parseInt(trip[i].departure.canceled) !== 0, //C onvert to int first then to boolean
                                         "platform": trip[i].departure.platform.length === 0? trip[i].departure.platforminfo.name: trip[i].departure.platform, // Fallback when platform is missing
                                         "platformChanged": parseInt(trip[i].departure.platforminfo.normal) !== 1, // Convert to boolean
                                         "vehicleId": trip[i].departure.vehicle,
                                         "direction": trip[i].departure.direction,
                                         "train": trip[i].departure.vehicle.split(".")[2] // BE.NMBS.TRAINID
                                     },
                                     "arrival": { "station": trip[i].arrival.station,
                                         "stationinfo": trip[i].arrival.stationinfo,
                                         "time": formatUnixTimeToUTC(trip[i].arrival.time, true),
                                         "delay": trip[i].arrival.delay,
                                         "canceled": parseInt(trip[i].arrival.canceled) !== 0, // Convert to int first and then to boolean
                                         "platform": trip[i].arrival.platform.length === 0? trip[i].arrival.platforminfo.name: trip[i].arrival.platform, // Fallback when platform is missing
                                         "platformChanged": parseInt(trip[i].arrival.platforminfo.normal) !== 1, // Convert to boolean
                                         "vehicleId": trip[i].arrival.vehicle,
                                         "direction": trip[i].arrival.direction,
                                         "train": trip[i].arrival.vehicle.split(".")[2] // BE.NMBS.TRAINID
                                     },
                                     "vias": {
                                         "number": trip[i].hasOwnProperty("vias")? trip[i].vias.number: 0, // When no vias are available then write 0 and an empty array to create the same model for vias and non vias connections
                                         "via": trip[i].hasOwnProperty("vias")? buildViaModel(trip[i]): []
                                     },
                                     "alerts": {
                                         "alert": trip[i].hasOwnProperty("alerts")? trip[i].alerts.alert: [],
                                         "number":  trip[i].hasOwnProperty("alerts")? trip[i].alerts.number: 0
                                     },
                                     "duration": formatDuration(trip[i].duration),
                                     //"stops": detail? buildStopsModel(): undefined;
                                 });
            }
        }
        else {
            succes = false;
        }
    });
}

function buildViaModel(trip) {
    var viaArray = [];
    for(var j=0; j < Object.keys(trip.vias.via).length; j++) {
        viaArray.push({
                          "depart": {
                              "direction": trip.vias.via.hasOwnProperty("direction")? trip.vias.via[j].direction.name: "", // iRail tries to add an direction but that's not always possible
                              "time": formatUnixTimeToUTC(trip.vias.via[j].departure.time, true),
                              "delay": trip.vias.via[j].departure.delay,
                              "canceled": parseInt(trip.vias.via[j].departure.canceled) !== 0, //convert to boolean
                              "platform": trip.vias.via[j].departure.platform,
                              "platformChanged": parseInt(trip.vias.via[j].departure.platforminfo.normal) !== 1, //convert to boolean
                              "vehicleId": trip.vias.via[j].departure.vehicle,
                              "train": trip.vias.via[j].vehicle.split(".")[2] // BE.NMBS.TRAIN
                          },
                          "arrival": {
                              "time": formatUnixTimeToUTC(trip.vias.via[j].arrival.time, true),
                              "delay": trip.vias.via[j].arrival.delay,
                              "canceled": trip.vias.via[j].arrival.canceled !== 0, //convert to boolean
                              "platform": trip.vias.via[j].arrival.platform,
                              "platformChanged": trip.vias.via[j].arrival.platforminfo.normal !== 1, //convert to boolean
                          },
                          "station": trip.vias.via[j].station,
                          "stationinfo": trip.vias.via[j].stationinfo,
                          "timebetween": formatTimeBetween(trip.vias.via[j].timeBetween)
                      });
    }
    return viaArray;
}

function formatUnixTimeToUTC(unixTime, leadingZero) { // Arrive/depart time is given in UNIX time format
    var unixTimeObject = new Date(unixTime * 1000);
    var months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
    var year = unixTimeObject.getFullYear();
    var month = months[unixTimeObject.getMonth()];
    var day = unixTimeObject.getDate();
    var hour = unixTimeObject.getHours();
    var min = unixTimeObject.getMinutes();
    var sec = unixTimeObject.getSeconds();
    if (leadingZero && day < 10) {
        day = "0" + day;
    }
    if (leadingZero && min < 10) {
        min = "0" + min;
    }
    if (leadingZero && hour < 10) {
        hour = "0" + hour;
    }
    var time = hour + ":" + min;
    var date = day + " " + month + " " + year.toString().substring(2,2);
    var object = { "time": time, "date": date};
    return object;
}

function formatTimeBetween(timebetween) { // Same as formatDelay
    return formatDelay(timebetween).replace("+", "");
}

function formatDuration(duration) { // Same as formatDelay
    return formatDelay(duration).replace("+", "");
}

function formatDelay(delay) { // Convert the seconds to a string of hours and minutes
    delay = delay/60; // Seconds to minutes
    var delayHour = Math.floor(delay/60); // Minutes to hours
    var delayMin = Math.ceil(delay); // Round up
    if(delayMin < 10) {
        delayMin = "0" + delayMin;
    }

    return "+" + delayHour + "H" + delayMin;
}

function formatTrainName(iRailTrainId) { //Remove ID related stuff, we only need the name of the train
    return iRailTrainId.split(".")[2];
}

function formatTimeForAPI(time) { // Convert time to API time
    return time.replace(":", "");
}

function formatDateForAPI(date) { //Convert date to API date + remove white spaces
    date = date.replace(" Jan ", "01");
    date = date.replace(" Feb ", "02");
    date = date.replace(" Mar ", "03");
    date = date.replace(" Apr ", "04");
    date = date.replace(" May ", "05");
    date = date.replace(" Jun ", "06");
    date = date.replace(" Jul ", "07");
    date = date.replace(" Aug ", "08");
    date = date.replace(" Sep ", "09");
    date = date.replace(" Oct ", "10");
    date = date.replace(" Nov ", "11");
    date = date.replace(" Dec ", "12");
    return date
}