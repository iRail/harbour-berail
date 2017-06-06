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

var date = new Date();

function getHours(leadingZero) {
    if(leadingZero) {
        return addLeadingZero(date.getHours());
    }
    return date.getHours();
}

function getMinutes(leadingZero) {
    if(leadingZero) {
        return addLeadingZero(date.getMinutes());
    }
    return date.getMinutes();
}

function getDay(leadingZero) {
    if(leadingZero) {
        return addLeadingZero(date.getDate());
    }
    return date.getDate();
}

function getMonth() {
    return covertMonth(date.getMonth());
}

function covertMonth(month) {
    var months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
    return months[month];
}

function getYear() {
    return date.getFullYear();
}

function addLeadingZero(value) {
    if(value < 10) {
        return "0" + value
    }
    return value
}

function getLocal() {
    var locale = Qt.locale().name
    if(locale.match("EN")) {
        return "EN";
    }
    else if(locale.match("NL")) {
        return "NL";
    }
    else if(locale.match("FR")) {
        return "FR"
    }
    else if(locale.match("DE")) {
        return "DE";
    }
    else {
        return "EN";
    }
}

function updatePythonLocal() {
    python.call("app.language.set_language", [getLocal()], function(callback){
        pythonReady = true; // Local set, Python is ready
    })
}
