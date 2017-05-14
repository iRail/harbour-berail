function load() {
    alertsModel.clear() // Make model empty

    python.call("app.disturbances.get_disturbances", [], function(disturbances) {
        console.log(JSON.stringify(disturbances))

        if(disturbances) { // Valid trip is TRUE
            if("empty" in disturbances) { // No data available
                succes = false;
                return false;
            }
            for(var i=0; i < Object.keys(disturbances).length; i++) { // Run through whole connection object
                /*alertsModel.append({
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
                                     "alerts": trip[i].hasOwnProperty("alerts")? true: false, // TO DO
                                     "duration": formatDuration(trip[i].duration),
                                     //"stops": detail? buildStopsModel(): undefined;
                                 });*/
            }
        }
        else {
            succes = false;
        }
    });
}
