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
