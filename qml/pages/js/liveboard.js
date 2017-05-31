function getTimeString() {
    var time = new Date();
    var hours = time.getHours();
    var minutes = time.getMinutes();
    var seconds = time.getSeconds();
    if(hours < 10) {
        hours = "0" + hours;
    }
    if(minutes < 10) {
        minutes = "0" + minutes;
    }
    if(seconds < 10) {
        seconds = "0" + seconds;
    }
    return hours + ":" + minutes + ":" + seconds;
}

function load(station) {
    liveboardModel.clear(); // Make model empty
    alertsModel.clear();
    succes = true; // Reset

    python.call("app.liveboard.get_liveboard", [station], function(liveboard) {
        if(liveboard) { // Valid liveboard is TRUE
            var _hasDelay = false;

            // No data available
            if("empty" in liveboard) {
                succes = false;
                return false;
            }

            // Build AlertsModel with all alerts for a certain station
            for(var i=0; i < Object.keys(liveboard.departures.departure).length; i++) {

                if(_hasDelay == false && liveboard.departures.departure[i].delay > 0) { // Detect if we have a delay in this data, improve performance by skipping this test if _hasDelay is already 'true'
                    _hasDelay = true;
                }

                if(liveboard.departures.departure[i].hasOwnProperty("alerts")) { // Detect if we have alerts in this data
                    for(var j=0; j < Object.keys(liveboard.departures.departure[i].alerts.alert).length; j++) {
                        alertsModel.append({
                                               "header": liveboard.departures.departure[i].alerts.alert[j].header,
                                               "description": liveboard.departures.departure[i].alerts.alert[j].description
                                           });
                    }
                }
            }

            // Remove duplicates from AlertsModel if the model is > 1
            if(alertsModel.count > 1) {
                for(var i=0; i < alertsModel.count; i++) {
                    for(var j=i; j < alertsModel.count; j++) { // Only check for the same elements after the current one
                        if(alertsModel.get(i).header == alertsModel.get(j).header) {
                            alertsModel.remove(j);
                        }
                    }
                }
            }

            // Build liveboardModel
            for(var i=0; i < Object.keys(liveboard.departures.departure).length; i++) {
                liveboardModel.append({
                                          "depart": { "station": liveboard.departures.departure[i].station,
                                              "stationinfo": liveboard.departures.departure[i].stationinfo,
                                              "time": formatUnixTimeToUTC(liveboard.departures.departure[i].time, true),
                                              "delay": liveboard.departures.departure[i].delay,
                                              "canceled": parseInt(liveboard.departures.departure[i].canceled) !== 0, // Convert to int first then to boolean
                                              "platform": liveboard.departures.departure[i].platform.length === 0? liveboard.departures.departure[i].platforminfo.name: liveboard.departures.departure[i].platform, // Fallback when platform is missing
                                                                                                                   "platformChanged": parseInt(liveboard.departures.departure[i].platforminfo.normal) !== 1, // Convert to boolean
                                                                                                                   "vehicleId": liveboard.departures.departure[i].vehicle,
                                                                                                                   "train": liveboard.departures.departure[i].vehicle.split(".")[2] // BE.NMBS.TRAINID
                                          },
                                          "hasDelay": _hasDelay,
                                          "alerts": liveboard.departures.departure[i].hasOwnProperty("alerts")? liveboard.departures.departure[i].alerts.alert: []
                                      });
            }
        }
        else {
            succes = false;
        }
    });
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

function formatDelay(delay) { // Convert the seconds to a string of hours and minutes
    delay = delay/60; // Seconds to minutes
    var delayHour = Math.floor(delay/60); // Minutes to hours
    var delayMin = Math.ceil(delay); // Round up
    if(delayMin < 10) {
        delayMin = "0" + delayMin;
    }

    return "+" + delayHour + "H" + delayMin;
}
