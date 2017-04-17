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

function getDay() {
    return date.getDate();
}

function getMonth() {
    return covertMonth(date.getMonth())
}

function covertMonth(month) {
    switch(month) {
    case 0:
        return qsTr("Jan");
    case 1:
        return qsTr("Feb");
    case 2:
        return qsTr("Mar");
    case 3:
        return qsTr("Apr");
    case 4:
        return qsTr("May");
    case 5:
        return qsTr("Jun");
    case 6:
        return qsTr("Jul");
    case 7:
        return qsTr("Aug");
    case 8:
        return qsTr("Sep");
    case 9:
        return qsTr("Oct");
    case 10:
        return qsTr("Nov");
    case 11:
        return qsTr("Dec");
    }
}

function getYear() {
    return date.getFullYear();
}
