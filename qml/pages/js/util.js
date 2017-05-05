var date = new Date();

function getHours(leadingZero) {
    if(leadingZero && date.getHours() < 10) {
        return "0" + date.getHours();
    }
    return date.getHours();
}

function getMinutes(leadingZero) {
    if(leadingZero && date.getMinutes() < 10) {
        return "0" + date.getMinutes();
    }
    return date.getMinutes();
}

function getDay(leadingZero) {
    if(leadingZero && date.getDate() < 10) {
        return "0" + date.getDate();
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
