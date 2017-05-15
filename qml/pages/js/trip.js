/*Handles all the JS related to the trip planner in BeRail*/

function calculateTraject(numberOfStops) {
    return numberOfStops*(Theme.itemSizeSmall/2 + 2*Theme.paddingLarge); // Each stop has a height of Theme.itemSizeSmall/2 for the stop itself and 2*Theme.paddingLarge as spacing
}

function calculateProgress(currentStop) {
    return currentStop*(Theme.itemSizeSmall/2 + 2*Theme.paddingLarge) + Theme.itemSizeSmall/2; // Middle of the current stop
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
    python.call("app.route.get_route", [from, to, formatTimeForAPI(time), formatDateForAPI(date)], function(trip) {
        console.log(JSON.stringify(trip))
        if(trip) { // Valid trip is TRUE
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

//BUILD ALERTS MODEL
/*
"alerts":{
                "alert":[
                    {
                        "description":"Situation back to normal. Delays may still occur.",
                        "header":"Mechelen - Antwerpen-Centraal: Signal failure.",
                        "id":"0"
                    },
                    {
                        "description":"Due to an IT problem it isn&#39;t possible to get real time train information via the real time information search engine. Please listen to the announcements made in the train or in the train station.",
                        "header":"IT problem",
                        "id":"1"
                    }
                ],
                "number":"2"
            },*/

function buildViaModel(trip) {
    var viaArray = [];
    for(var j=0; j < Object.keys(trip).length; j++) {
        viaArray.push({
                          "depart": {
                              "station": trip.departure.station,
                              "time": formatUnixTimeToUTC(trip.departure.time, true),
                              "delay": trip.departure.delay,
                              "canceled": trip.departure.canceled !== 0, //convert to boolean
                              "platform": trip.departure.platform,
                              "platformChanged": trip.departure.platforminfo.normal !== 1, //convert to boolean
                              "stationinfo": trip.departure.stationinfo,
                              "vehicleId": trip.departure.vehicle,
                              "direction": trip.departure.direction,
                              "train": trip.departure.vehicle.split(".")[2] // BE.NMBS.TRAIN
                          },
                          "arrival": {
                              "station": trip.arrival.station,
                              "time": formatUnixTimeToUTC(trip.arrival.time, true),
                              "delay": trip.arrival.delay,
                              "canceled": trip.arrival.canceled !== 0, //convert to boolean
                              "platform": trip.arrival.platform,
                              "platformChanged": trip.arrival.platforminfo.normal !== 1, //convert to boolean
                              "stationinfo": trip.arrival.stationinfo,
                              "vehicleId": trip.arrival.vehicle,
                              "direction": trip.arrival.direction,
                              "train": trip.arrival.vehicle.split(".")[2] // BE.NMBS.TRAIN
                          }
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

function formatDuration(duration) { // Same as formatDelay
    return formatDelay(duration);
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
