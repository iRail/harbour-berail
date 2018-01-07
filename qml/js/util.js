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

function formatTime(timeInSeconds) {
    var minutes = timeInSeconds/60; // Convert to minutes
    var hours = Math.floor(minutes/60); // Convert to hours
    minutes = minutes - hours*60 // Remove the converted hours

    if(minutes < 10) { // Add leading zero if needed
        minutes = "0" + minutes;
    }

    return hours + "H" + minutes;
}

function formatDelay(delayInSeconds) {
    return "+" + formatTime(delayInSeconds);
}

function mergeTimeDelay(time, delayInSeconds) {
    return new Date(time.getTime() + delayInSeconds*1000)
}

function filterId(id) {
    var filterRegex = /^(S[0-9])|(ICE)|(THA)|(IC)|(EUR)|(TGV)|(P)|(L)/;
    return filterRegex.exec(id)[0];
}

function convertTransportType(type) {
    switch(type) {
    case 0:
        return IRail.All
    case 1:
        return IRail.NoInternationalTrains
    }
}

// QML JS doesn't know IRail Enum types as value, they can be only a return value
// IRail.High = 3
// IRail.Medium = 2
// IRail.Low = 1
// IRail.Unknown = 0
function convertOccupancyType(type) {
    switch(type) {
    case 3:
        return "qrc:///icons/icon-occupancy-high.svg"
    case 2:
        return "qrc:///icons/icon-occupancy-medium.svg"
    case 1:
        return "qrc:///icons/icon-occupancy-low.svg"
    case 0:
    default:
        return "qrc:///icons/icon-occupancy-unknown.svg"
    }
}
