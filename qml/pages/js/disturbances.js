function load() {
    alertsModel.clear() // Make model empty

    python.call("app.disturbances.get_disturbances", [], function(disturbances) {
        console.log(JSON.stringify(disturbances))

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
