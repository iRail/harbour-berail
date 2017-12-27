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

function formatDelay(delayInSeconds) {
    var delayMinutes = delayInSeconds/60; // Convert to minutes
    var delayHours = Math.floor(delayMinutes/60); // Convert to hours

    if(delayMinutes < 10) { // Add leading zero if needed
        delayMinutes = "0" + delayMinutes;
    }

    return "+" + delayHours + "H" + delayMinutes;
}

function filterId(id) {
    var filterRegex = /^(S[0-9])|(ICE)|(THA)|(IC)|(EUR)|(P)|(L)/;
    return filterRegex.exec(id)[0];
}
