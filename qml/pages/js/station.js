function load() { // Asynchronous!
    python.call("app.stations.get_list", [], function(stationList) {
        console.log(JSON.stringify(stationList.station))
        stations = stationList.station;
        for (var i = 0; i < Object.keys(stations).length; i++) {
            stationModel.append({ "name": stations[i].name})
        }
    });
}
