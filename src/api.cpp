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
#include "api.h"

/**
 * @class API
 * @brief API constructor.
 * @details Constructs a new API object while setting up a QNetworkAccessManager together with a QNetworkDiskCache, connecting the signals and configuring the useragent.
 */
API::API()
{
    // Initiate a new QNetworkAccessManager with cache
    QNAM = new QNetworkAccessManager(this);
    QNetworkConfigurationManager QNAMConfig;
    QNAM->setConfiguration(QNAMConfig.defaultConfiguration());
    QNAMCache = new QNetworkDiskCache(this);
    QNAMCache->setCacheDirectory(SFOS.cacheLocation()+ "/network");
    QNAM->setCache(QNAMCache);
    this->setNetworkEnabled(QNAM->networkAccessible() > 0);

    // Connect QNetworkAccessManager signals
    connect(QNAM, SIGNAL(networkAccessibleChanged(QNetworkAccessManager::NetworkAccessibility)), this, SLOT(networkAccessible(QNetworkAccessManager::NetworkAccessibility)));
    connect(QNAM, SIGNAL(sslErrors(QNetworkReply*,QList<QSslError>)), this, SLOT(sslErrors(QNetworkReply*,QList<QSslError>)));
    connect(QNAM, SIGNAL(finished(QNetworkReply*)), this, SLOT(finished(QNetworkReply*)));

    // Create User-Agent
    qDebug() << SFOS.appVersion();
    this->setUseragent(QString("%1/%2 (%3)").arg(SFOS.appNamePretty(), SFOS.appVersion(), SFOS.release()));
}

/**
 * @class API
 * @brief API destructor.
 * @details Deallocates QNetworkAccessManager and QNetworkDiskCache memory space on destruction.
 * By checking if the pointers are set we avoid to delete NULL pointers.
 */
API::~API()
{
    if(QNAM) {
        QNAM->deleteLater();
    }

    if(QNAMCache) {
        QNAMCache->deleteLater();
    }
}

/**
 * @class API
 * @brief Translate the QLocale::Language enum to iRail API
 * @details iRail API uses abbreviations for the languages it supports,
 * QtLocale::Language enum is in a different format so it needs to be mapped on the iRail standards.
 * @param language
 * @return QString
 */
QString API::parseLanguage(QLocale::Language language)
{
    switch(language) {
    case QLocale::Dutch:
        return "nl";
    case QLocale::French:
        return "fr";
    case QLocale::German:
        return "de";
    case QLocale::English:
    default:
        return "en";
    }
}

QString API::parseDate(QDateTime time)
{
    return time.toString("ddMMyy");
}

QString API::parseDateOccupancy(QDateTime time)
{
    return time.toString("yyyyMMdd");
}

QString API::parseTime(QDateTime time)
{
    return time.toString("HHmm");
}

QString API::parseArrdep(IRail::ArrDep arrdep) {
    if(arrdep == IRail::ArrDep::Arrival)
    {
        return "arrival";
    }
    return "departure";
}

QString API::parseTransport(IRail::Transport transportType) {
    if(transportType == IRail::Transport::Trains)
    {
        return "trains";
    }
    else if(transportType == IRail::Transport::NoInternationalTrains)
    {
        return "nointernationaltrains";
    }
    return "all";
}

IRail::Occupancy API::parseOccupancy(QString occupancy)
{
    if(occupancy.contains("low"))
    {
        return IRail::Occupancy::Low;
    }
    else if(occupancy.contains("medium"))
    {
        return IRail::Occupancy::Medium;
    }
    else if(occupancy.contains("high"))
    {
        return IRail::Occupancy::High;
    }

    return IRail::Occupancy::Unknown;
}

bool API::parseStringToBool(QString value)
{
    if(value == "1") {
        return true;
    }
    return false;
}

/**
 * @class API
 * @brief Prepare HTTP request
 * @details iRail API requires the same headers every time so writing them once is easier to maintain.
 * @param url
 * @param parameters
 * @return QNetworkRequest
 */
QNetworkRequest API::prepareRequest(QUrl url, QUrlQuery parameters)
{
    // Set busy state
    this->setBusy(true);

    // Add default URL parameters
    parameters.addQueryItem("format", "json");
    parameters.addQueryItem("lang", this->parseLanguage(language()));
    url.setQuery(parameters);

    // Create QNetworkRequest
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setHeader(QNetworkRequest::UserAgentHeader, this->useragent());
    request.setAttribute(QNetworkRequest::FollowRedirectsAttribute, true);
    request.setAttribute(QNetworkRequest::CacheLoadControlAttribute, QNetworkRequest::PreferNetwork);
    return request;
}

/**
 * @class API
 * @brief HTTP GET request to the /stations endpoint.
 * @details Performs a HTTP GET request to the iRail /stations endpoint with the right headers to retrieve the data as JSON.
 * A networkcache is also included to increase performance, cache is controlled by the Cache Headers from the iRail server.
 */
void API::getStations()
{
    // Build URL
    QUrl url(QString(STATIONS_ENDPOINT));
    QUrlQuery parameters;

    // Prepare & do request
    QNAM->get(this->prepareRequest(url, parameters));
}

void API::getDisturbances()
{
    // Build URL
    QUrl url(QString(DISTURBANCES_ENDPOINT));
    QUrlQuery parameters;

    // Prepare & do request
    QNAM->get(this->prepareRequest(url, parameters));
}

void API::getVehicle(QString id, QDateTime time)
{
    // Build URL
    QUrl url(QString(VEHICLE_ENDPOINT));
    QUrlQuery parameters;
    parameters.addQueryItem("id", id);
    parameters.addQueryItem("date", this->parseDate(time));
    parameters.addQueryItem("alerts", "true");

    // Prepare & do request
    QNAM->get(this->prepareRequest(url, parameters));
}

void API::getLiveboard(QString stationName, QDateTime time, IRail::ArrDep arrdep)
{
    // Build URL
    QUrl url(QString(LIVEBOARD_ENDPOINT));
    QUrlQuery parameters;
    parameters.addQueryItem("station", stationName);
    parameters.addQueryItem("date", this->parseDate(time));
    parameters.addQueryItem("time", this->parseTime(time));
    parameters.addQueryItem("arrdep", this->parseArrdep(arrdep));
    parameters.addQueryItem("alerts", "true");

    // Prepare & do request
    QNAM->get(this->prepareRequest(url, parameters));
}

void API::getConnections(QString fromStation, QString toStation, IRail::ArrDep arrdep, QDateTime time, IRail::Transport transportType)
{
    // Build URL
    QUrl url(QString(CONNECTIONS_ENDPOINT));
    QUrlQuery parameters;
    parameters.addQueryItem("from", fromStation);
    parameters.addQueryItem("to", toStation);
    parameters.addQueryItem("date", this->parseDate(time));
    parameters.addQueryItem("time", this->parseTime(time));
    parameters.addQueryItem("timesel", this->parseArrdep(arrdep));
    parameters.addQueryItem("typeOfTransport", this->parseTransport(transportType));

    // Prepare & do request
    QNAM->get(this->prepareRequest(url, parameters));
}

/*
 * @brief: Refreshes all the API endpoints
 * @description: Refreshes all the data from the iRail API endpoints for example after a network outage.
 * We want to provide the user then as soon as possible the most recent information available.
 */
void API::refreshAll()
{
    if(this->vehicle()) {
        this->getVehicle(this->vehicle()->id(), QDateTime(this->vehicle()->date()));
    }
    /*if(this->connections()) {
        this->getConnections(this->connections(),
    }*/
    if(this->liveboard() && this->liveboard()->station()) {
        this->getLiveboard(this->liveboard()->station()->name(), this->liveboard()->timestamp(), this->liveboard()->arrdep());
    }
    this->getDisturbances();
    this->getStations();
}

/*void API::postOccupancy(QString connectionId, Station* station, Vehicle* vehicle, Occupancy occupancy) {
    {
      "connection": "http://irail.be/connections/8871308/20160722/IC4516",
      "from": "http://irail.be/stations/NMBS/008871308",
      "date": "20160722",
      "vehicle": "http://irail.be/vehicle/IC4516",
      "occupancy": "http://api.irail.be/terms/low"
    }

    // Build URL
    QUrl url(QString(OCCUPANCY_ENDPOINT));

    // Prepare & do request
    QNAM->post(prepareRequest(url, parameters));

    parseDateOccupancy
}*/

/**
 * @class API
 * @brief Handling HTTP replies.
 * @details Handles the iRail HTTP JSON replies, dispatches them to the right JSON parser
 * and updates the API data with the help of the JSON parsers.
 * @param reply
 */
void API::finished (QNetworkReply *reply)
{
    if(!this->networkEnabled()) {
        qWarning() << "Network inaccesible, can't retrieve API request!";
    }
    else if(reply->error()) {
        if(reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() == 404 || reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() == 500)
        {
            qWarning() << reply->errorString();
            //: Error shown to the user when the iRail API failed to retrieve the requested data
            //% "iRail API couldn't complete your request!"
            emit this->errorOccurred(qtTrId("berail-api-error"));
        }
        else {
            qCritical() << reply->errorString();
            emit this->errorOccurred(reply->errorString());
        }
    }
    else if(reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() == 301 || reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() == 302) {
        qDebug() << "HTTP 301/302: Moved, following redirect...";
    }
    else if(reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() == 304) {
        qDebug() << "HTTP 304: Not-Modified";
    }
    else {
        qDebug() << "Content-Header:" << reply->header(QNetworkRequest::ContentTypeHeader).toString();
        qDebug() << "Content-Length:" << reply->header(QNetworkRequest::ContentLengthHeader).toULongLong() << "bytes";
        qDebug() << "HTTP code:" << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
        qDebug() << "HTTP reason:" << reply->attribute(QNetworkRequest::HttpReasonPhraseAttribute).toString();
        qDebug() << "Cache:" << reply->attribute(QNetworkRequest::SourceIsFromCacheAttribute).toBool();

        // Get the data from the request
        QString replyData = (QString)reply->readAll();

        // Try to parse the data as JSON
        QJsonParseError parseError;
        QJsonDocument jsonData = QJsonDocument::fromJson(replyData.toUtf8(), &parseError);

        // If parsing succesfull, use the data
        if(parseError.error == QJsonParseError::NoError) {
            QJsonObject jsonObject = jsonData.object();

            // Parse data in the right C++ model or database
            if(reply->url().toString().contains("stations", Qt::CaseInsensitive)) {
                qDebug() << "iRail stations data received";
                this->setStations(this->parseStations(jsonObject));
            }
            else if(reply->url().toString().contains("liveboard", Qt::CaseInsensitive)) {
                qDebug() << "iRail liveboard data received";
                this->setLiveboard(this->parseLiveboard(jsonObject));
            }
            else if(reply->url().toString().contains("connections", Qt::CaseInsensitive)) {
                qDebug() << "iRail connections data received";
                this->setConnections(this->parseConnections(jsonObject));
            }
            else if(reply->url().toString().contains("vehicle", Qt::CaseInsensitive)) {
                qDebug() << "iRail vehicle data received";
                this->setVehicle(this->parseVehicle(jsonObject));
            }
            else if(reply->url().toString().contains("occupancy", Qt::CaseInsensitive)) {
                qDebug() << "iRail occupancy data received";
                emit occupancyUpdated();
            }
            else if(reply->url().toString().contains("disturbances", Qt::CaseInsensitive)) {
                qDebug() << "iRail disturbances data received";
                this->setDisturbances(this->parseDisturbances(jsonObject));
            }
            else if(reply->url().toString().contains("logs", Qt::CaseInsensitive)) {
                qInfo() << "iRail log data received";
            }
        }
        else {
            qCritical() << "Received data isn't properly formatted as JSON! QJsonParseError:" << parseError.errorString();
            //: Error shown to the user when the data is invalid JSON data
            //% "Invalid JSON data received, please try again later"
            emit this->errorOccurred(qtTrId("berail-json-error"));
        }
    }

    reply->deleteLater();
    this->setBusy(false);
}

/**
 * @class API
 * @brief Logs SSL errors.
 * @param reply
 * @param sslError
 */
void API::sslErrors(QNetworkReply* reply, QList<QSslError> sslError)
{
    qCritical() << "SSL error occured:" << reply->errorString() << sslError;
    //: Error shown to the user when an SSL error occurs due a bad certificate or incorrect time settings.
    //% "SSL error, please check your device is running with the correct date and time."
    emit this->errorOccurred(qtTrId("berail-ssl-error"));
}

/**
 * @class API
 * @brief Logs the networkstate.
 * @details The networkstate can be handy for debugging purposes.
 * @param state
 */
void API::networkAccessible(QNetworkAccessManager::NetworkAccessibility state)
{
    if(state == 0) {
        qInfo() << "Network offline";
        this->setNetworkEnabled(false);
    }
    else {
        qInfo() << "Network online";
        this->setNetworkEnabled(true);
    }
}

/**
 * @brief Parses Station JSON data
 * @details Parses the iRail Station JSON data from the /stations endpoint.
 * @warning Station objects aren't owned by the QList, deleting the QList requires to delete the Station objects as well!
 * @param json
 * @return QList<Station*>
 */
StationListModelFilter* API::parseStations(QJsonObject json)
{
    qDebug() << "Parsing stations";
    QList<Station*> stationsList;
    QJsonArray stationArray = json["station"].toArray();

    // Loop through array and parse the JSON Station objects as C++ models
    foreach (const QJsonValue &item, stationArray) {
        QJsonObject stationObj = item.toObject();
        QGeoCoordinate stationLocation(stationObj["locationY"].toString().toDouble(), stationObj["locationX"].toString().toDouble());
        QString stationId(stationObj["id"].toString());
        QString stationName(stationObj["standardname"].toString());
        Station* station = new Station(stationId, stationName, stationLocation);
        stationsList.append(station);
        qDebug() << "STATION:";
        qDebug() << "\tName:" << station->name();
    }

    return new StationListModelFilter(new StationListModel(stationsList));
}

Disturbances* API::parseDisturbances(QJsonObject json)
{
    qDebug() << "Parsing disturbances";
    QList<Alert*> alertsList;
    QDateTime timestampDisturbances;
    timestampDisturbances.setTime_t(json["timestamp"].toString().toInt());
    QJsonArray alertArray = json["disturbance"].toArray();

    // Loop through array and parse the JSON Alerts objects as C++ models
    foreach (const QJsonValue &item, alertArray) {
        QJsonObject alertObj = item.toObject();
        QDateTime timestampAlert;
        QUrl linkAlert(alertObj["link"].toString());

        timestampAlert.setTime_t(alertObj["timestamp"].toString().toInt());
        Alert* alert = new Alert(alertObj["id"].toString().toInt(), alertObj["title"].toString(), alertObj["description"].toString(), timestampAlert, linkAlert);
        alertsList.append(alert);
    }

    // Save them in a Disturbance object
    Disturbances* disturbances = new Disturbances(alertsList, timestampDisturbances);
    qDebug() << "DISTURBANCES:";
    qDebug() << "\tTimestamp:" << disturbances->timestamp();
    qDebug() << "\tAlerts:" << disturbances->alerts();

    return disturbances;
}

Vehicle* API::parseVehicle(QJsonObject json)
{
    qDebug() << "Parsing vehicle";
    QList<Stop*> stopList;
    QList<Alert*> alertsList;
    QDateTime timestampVehicle;
    timestampVehicle.setTime_t(json["timestamp"].toString().toInt());
    qDebug() << timestampVehicle;
    QJsonObject vehicleInfo = json["vehicleinfo"].toObject();
    QGeoCoordinate vehicleLocation(vehicleInfo["locationY"].toString().toDouble(), vehicleInfo["locationX"].toString().toDouble());
    QJsonArray stopArray = json["stops"].toObject()["stop"].toArray();
    bool isCanceled = false;
    QList<IRail::Occupancy> occupancyList;

    // Return an empty Disturbances object if no alerts are available
    Disturbances *disturbances = new Disturbances();
    if(json.contains("alerts")) {
        qDebug() << "Alerts detected";
        QJsonArray alertArray = json["alerts"].toObject()["alert"].toArray();

        // Loop through array and parse the JSON Alerts objects as C++ models
        foreach (const QJsonValue &item, alertArray) {
            QJsonObject alertObj = item.toObject();
            Alert* alert = new Alert(alertObj["id"].toString().toInt(), alertObj["title"].toString(), alertObj["description"].toString(), timestampVehicle);
            alertsList.append(alert);
        }
        disturbances->setAlerts(alertsList);
    }

    // Loop through array and parse the JSON Stop objects as C++ models
    foreach (const QJsonValue &item, stopArray) {
        QJsonObject stopObj = item.toObject();
        QJsonObject platformObj = stopObj["platforminfo"].toObject();
        QJsonObject stationObj = stopObj["stationinfo"].toObject();
        QJsonObject occupancyObj = stopObj["occupancy"].toObject();
        QDateTime scheduledDepartureTime;
        QDateTime scheduledArrivalTime;
        QGeoCoordinate stationLocation(stationObj["locationY"].toString().toDouble(), stationObj["locationX"].toString().toDouble());
        Station* station = new Station(stationObj["id"].toString(), stationObj["standardname"].toString(), stationLocation);
        scheduledDepartureTime.setTime_t(stopObj["scheduledDepartureTime"].toString().toInt());
        scheduledArrivalTime.setTime_t(stopObj["scheduledArrivalTime"].toString().toInt());


        Stop* stop = new Stop(stopObj["id"].toString().toInt(),
                station,
                platformObj["name"].toString(),
                this->parseStringToBool(platformObj["normal"].toString()),
                stopObj["departureDelay"].toString().toInt(),
                scheduledDepartureTime,
                this->parseStringToBool(stopObj["departureCanceled"].toString()),
                stopObj["arrivalDelay"].toString().toInt(),
                scheduledArrivalTime,
                this->parseStringToBool(stopObj["arrivalCanceled"].toString()),
                this->parseStringToBool(stopObj["left"].toString()),
                this->parseOccupancy(occupancyObj["name"].toString())
                );
        stopList.append(stop);

        if(!isCanceled) {
            isCanceled = this->parseStringToBool(stopObj["departureCanceled"].toString()) || this->parseStringToBool(stopObj["arrivalCanceled"].toString());
        }

        occupancyList.append(this->parseOccupancy(occupancyObj["name"].toString()));
    }

    std::sort(occupancyList.begin(), occupancyList.end());
    IRail::Occupancy occupancyMedian = occupancyList.at(occupancyList.length()/2);
    Vehicle* vehicle = new Vehicle(vehicleInfo["name"].toString(), timestampVehicle.date(), stopList, vehicleLocation, isCanceled, occupancyMedian, disturbances, timestampVehicle);
    qDebug() << "VEHICLE:" << vehicle->id();
    qDebug() << "\tAlerts:" << vehicle->disturbances()->alerts();
    qDebug() << "\tStops:" << vehicle->stops();
    return vehicle;
}

Liveboard *API::parseLiveboard(QJsonObject json)
{
    qDebug() << "Parsing liveboard";
    QJsonObject departureStationObj = json["stationinfo"].toObject();
    QJsonObject departuresObj;
    QJsonArray departureArray;
    Disturbances* disturbancesLiveboard = new Disturbances();
    IRail::ArrDep arrdep;
    QList<Vehicle*> vehicleList;

    // Handle different types of data for the liveboard
    if(json.contains("departures")) {
        departuresObj = json["departures"].toObject();
        departureArray = departuresObj["departure"].toArray();
        arrdep = IRail::ArrDep::Departure;
    }
    else if (json.contains("arrivals")){
        departuresObj = json["arrivals"].toObject();
        departureArray = departuresObj["arrival"].toArray();
        arrdep = IRail::ArrDep::Arrival;
    }
    else {
        qCritical() << "Data parsing failed, JSON doesn't match";
        //: Error shown to the user when the liveboard of the station can't be retrieved
        //% "Retrieving liveboard failed, please try again later."
        //~ The liveboard is a list of all departing/arriving trains in a station.
        emit this->errorOccurred(qtTrId("berail-liveboard-error"));
        return new Liveboard();
    }

    QDateTime timestampLiveboard;
    timestampLiveboard.setTime_t(json["timestamp"].toString().toInt());
    QGeoCoordinate stationLocation(departureStationObj["locationY"].toString().toDouble(), departureStationObj["locationX"].toString().toDouble());
    Station* station = new Station(departureStationObj["id"].toString(), departureStationObj["standardname"].toString(), stationLocation);

    // Loop through array and parse the JSON Stop objects as C++ models
    foreach (const QJsonValue &item, departureArray) { // BUG: not looped
        QJsonObject departure = item.toObject();
        QJsonObject stationObj = departure["stationinfo"].toObject();
        QJsonObject vehicleObj = departure["vehicleinfo"].toObject();
        QJsonObject platformObj = departure["platforminfo"].toObject();
        QJsonObject occupancyObj = departure["occupancy"].toObject();
        QList<Stop*> stopList;
        QList<Alert*> alertsList;
        QGeoCoordinate stationLocation(stationObj["locationY"].toString().toDouble(), stationObj["locationX"].toString().toDouble());
        Station* station = new Station(stationObj["id"].toString(), stationObj["standardname"].toString(), stationLocation);
        QDateTime scheduledDepartureTime;
        scheduledDepartureTime.setTime_t(departure["time"].toString().toInt());

        // Build Stop object based on the departure data of this vehicle
        Stop* stop = new Stop(departure["id"].toString().toInt(),
                station,
                platformObj["name"].toString(),
                this->parseStringToBool(platformObj["normal"].toString()),
                departure["delay"].toString().toInt(),
                scheduledDepartureTime,
                this->parseStringToBool(departure["canceled"].toString()),
                departure["delay"].toString().toInt(),
                scheduledDepartureTime,
                this->parseStringToBool(departure["canceled"].toString()),
                this->parseStringToBool(departure["left"].toString()),
                this->parseOccupancy(occupancyObj["name"].toString())
                );
        stopList.append(stop);

        // Return an empty Disturbances object if no alerts are available
        Disturbances* disturbances = new Disturbances();
        if(json.contains("alerts")) {
            qDebug() << "Alerts detected";
            QJsonArray alertArray = json["alerts"].toObject()["alert"].toArray();

            // Loop through array and parse the JSON Alerts objects as C++ models
            foreach (const QJsonValue &item, alertArray) {
                QJsonObject alertObj = item.toObject();
                Alert* alert = new Alert(alertObj["id"].toString().toInt(), alertObj["title"].toString(), alertObj["description"].toString(), timestampLiveboard);
                alertsList.append(alert);
            }
            // Update the disturbances for the specific item
            disturbances->setAlerts(alertsList);
            // Update the disturbances for the whole liveboard
            QList<Alert*> tempAlertList(disturbancesLiveboard->alerts());
            tempAlertList.append(alertsList);
            disturbancesLiveboard->setAlerts(tempAlertList);
        }

        // Create vehicle
        Vehicle* vehicle = new Vehicle(vehicleObj["name"].toString(),
                timestampLiveboard.date(),
                stopList,
                stationLocation,
                this->parseStringToBool(departure["canceled"].toString()),
                this->parseOccupancy(occupancyObj["name"].toString()),
                disturbances,
                timestampLiveboard
                );
        // Append vehicle to list
        vehicleList.append(vehicle);
    }

    // Create Liveboard using our data from above
    Liveboard* liveboard = new Liveboard(station, vehicleList, timestampLiveboard, arrdep, disturbancesLiveboard);
    qDebug() << "LIVEBOARD:";
    qDebug() << "\tStation:" << liveboard->station()->name();
    qDebug() << "\tVehicles:" << liveboard->vehicles();
    qDebug() << "\tTimestamp:" << liveboard->timestamp();
    qDebug() << "\tAlerts:" << liveboard->disturbances()->alerts();
    return liveboard;
}

ConnectionListModel* API::parseConnections(QJsonObject json)
{
    qDebug() << "Parsing connections";
    QList<Connection*> connectionList;
    QJsonArray connectionArray = json["connection"].toArray();
    QDateTime timestampConnections;
    timestampConnections.setTime_t(json["timestamp"].toString().toInt());

    foreach (const QJsonValue &connectionItem, connectionArray) {
        QJsonObject item = connectionItem.toObject();
        QJsonObject departureObj = item["departure"].toObject();
        QJsonObject arrivalObj = item["arrival"].toObject();
        QJsonObject fromStationObj = departureObj["stationinfo"].toObject();
        QJsonObject toStationObj = arrivalObj["stationinfo"].toObject();
        QJsonObject fromPlatformObj = departureObj["platforminfo"].toObject();
        QJsonObject toPlatformObj = arrivalObj["platforminfo"].toObject();
        QJsonObject fromOccupancyObj = departureObj["occupancy"].toObject();
        QJsonObject toOccupancyObj = arrivalObj["occupancy"].toObject();
        QJsonObject connectionOccupancyObj = item["occupancy"].toObject();
        int connectionDuration = item["duration"].toString().toInt();
        int connectionId = item["id"].toString().toInt();
        QJsonObject viasObj = item["vias"].toObject();
        QJsonArray viasArray = viasObj["via"].toArray();
        QDateTime fromTime;
        fromTime.setTime_t(departureObj["time"].toString().toInt());
        QDateTime toTime;
        toTime.setTime_t(arrivalObj["time"].toString().toInt());
        QString fromVehicleId = departureObj["vehicle"].toString();
        QString toVehicleId = arrivalObj["vehicle"].toString();
        QList<Via*> viaList;
        QList<Alert*> alertsListConnection;
        QList<Alert*> remarksListConnection;

        // Departure Stop
        QGeoCoordinate fromStationLocation(fromStationObj["locationY"].toString().toDouble(), fromStationObj["locationX"].toString().toDouble());
        Station* fromStation = new Station(fromStationObj["id"].toString(), fromStationObj["standardname"].toString(), fromStationLocation);
        Stop* fromStop = new Stop(departureObj["id"].toString().toInt(),
                fromStation,
                fromPlatformObj["name"].toString(),
                this->parseStringToBool(fromPlatformObj["normal"].toString()),
                departureObj["delay"].toString().toInt(),
                fromTime,
                this->parseStringToBool(departureObj["canceled"].toString()),
                departureObj["delay"].toString().toInt(),
                fromTime,
                this->parseStringToBool(departureObj["canceled"].toString()),
                this->parseStringToBool(departureObj["left"].toString()),
                this->parseOccupancy(fromOccupancyObj["name"].toString()),
                false, // isExtraStop ALWAYS false
                departureObj["direction"].toObject()["name"].toString(),
                this->parseStringToBool(departureObj["walking"].toString())
                );

        // Arrival Stop
        QGeoCoordinate toStationLocation(toStationObj["locationY"].toString().toDouble(), toStationObj["locationX"].toString().toDouble());
        Station* toStation = new Station(toStationObj["id"].toString(), toStationObj["standardname"].toString(), toStationLocation);
        Stop* toStop = new Stop(arrivalObj["id"].toString().toInt(),
                toStation,
                toPlatformObj["name"].toString(),
                this->parseStringToBool(toPlatformObj["normal"].toString()),
                arrivalObj["delay"].toString().toInt(),
                toTime,
                this->parseStringToBool(arrivalObj["canceled"].toString()),
                arrivalObj["delay"].toString().toInt(),
                toTime,
                this->parseStringToBool(arrivalObj["canceled"].toString()),
                this->parseStringToBool(arrivalObj["arrived"].toString()),
                this->parseOccupancy(toOccupancyObj["name"].toString()),
                false, // isExtraStop ALWAYS false
                arrivalObj["direction"].toObject()["name"].toString(),
                this->parseStringToBool(arrivalObj["walking"].toString())
                );

        // Connection alerts
        // Return an empty Disturbances object if no alerts are available
        Disturbances* disturbancesConnection = new Disturbances();
        if(item.contains("alerts")) {
            qDebug() << "Alerts detected";
            QJsonArray alertArray = item["alerts"].toObject()["alert"].toArray();

            // Loop through array and parse the JSON Alerts objects as C++ models
            foreach (const QJsonValue &item, alertArray) {
                QJsonObject alertObj = item.toObject();
                QDateTime timestampAlert;
                timestampAlert.setTime_t(alertObj["startTime"].toString().toInt());
                Alert* alert = new Alert(alertObj["id"].toString().toInt(), alertObj["title"].toString(), alertObj["description"].toString(), timestampAlert);
                alertsListConnection.append(alert);
            }
            // Update the disturbances for the specific item
            disturbancesConnection->setAlerts(alertsListConnection);
        }

        // Connection remarks
        // Return an empty Disturbances object if no alerts are available
        Remarks* remarksConnection = new Remarks();
        if(item.contains("remarks")) {
            qDebug() << "Remarks detected";
            QJsonArray remarkArray = item["remarks"].toObject()["remark"].toArray();

            // Loop through array and parse the JSON Alerts objects as C++ models
            foreach (const QJsonValue &item, remarkArray) {
                QJsonObject alertObj = item.toObject();
                QDateTime timestampAlert;
                timestampAlert.setTime_t(alertObj["startTime"].toString().toInt());
                Alert* alert = new Alert(alertObj["id"].toString().toInt(), alertObj["title"].toString(), alertObj["description"].toString(), timestampAlert);
                remarksListConnection.append(alert);
            }
            // Update the disturbances for the specific item
            remarksConnection->setAlerts(remarksListConnection);
        }

        // Handle vias Stops
        foreach (const QJsonValue &via, viasArray) {
            QJsonObject viaObj = via.toObject();
            QJsonObject viaStationObj = viaObj["stationinfo"].toObject();
            QJsonObject viaArrivalObj = viaObj["arrival"].toObject();
            QJsonObject viaDepartureObj = viaObj["departure"].toObject();
            QJsonObject viaArrivalPlatformObj = viaArrivalObj["platforminfo"].toObject();
            QJsonObject viaDeparturePlatformObj = viaDepartureObj["platforminfo"].toObject();
            QJsonObject viaArrivalOccupancyObj = viaArrivalObj["occupancy"].toObject();
            QJsonObject viaDepartureOccupancyObj = viaDepartureObj["occupancy"].toObject();
            QString viaVehicleId = viaDepartureObj["vehicle"].toString();
            int viaTimeBetween = viaObj["timeBetween"].toString().toInt();
            QDateTime viaArrivalTime;
            viaArrivalTime.setTime_t(viaArrivalObj["time"].toString().toInt());
            QDateTime viaDepartureTime;
            viaDepartureTime.setTime_t(viaDepartureObj["time"].toString().toInt());
            QList<Alert*> alertsList;

            // Station via
            QGeoCoordinate viaStationLocation(viaStationObj["locationY"].toString().toDouble(), viaStationObj["locationX"].toString().toDouble());
            Station* viaStation = new Station(viaStationObj["id"].toString(), viaStationObj["standardname"].toString(), viaStationLocation);

            // Arrival via
            Stop* viaStopArrival = new Stop(viaArrivalObj["id"].toString().toInt(),
                    viaStation,
                    viaArrivalPlatformObj["name"].toString(),
                    this->parseStringToBool(viaArrivalPlatformObj["normal"].toString()),
                    viaArrivalObj["delay"].toString().toInt(),
                    viaArrivalTime,
                    this->parseStringToBool(viaArrivalObj["canceled"].toString()),
                    viaArrivalObj["delay"].toString().toInt(),
                    viaArrivalTime,
                    this->parseStringToBool(viaArrivalObj["canceled"].toString()),
                    this->parseStringToBool(viaArrivalObj["arrived"].toString()),
                    this->parseOccupancy(viaArrivalOccupancyObj["name"].toString()),
                    this->parseStringToBool(viaArrivalObj["isExtraStop"].toString()),
                    viaArrivalObj["direction"].toObject()["name"].toString(),
                    this->parseStringToBool(viaArrivalObj["walking"].toString())
                    );

            // Departure via
            Stop* viaStopDeparture = new Stop(viaDepartureObj["id"].toString().toInt(),
                    viaStation,
                    viaDeparturePlatformObj["name"].toString(),
                    this->parseStringToBool(viaDeparturePlatformObj["normal"].toString()),
                    viaDepartureObj["delay"].toString().toInt(),
                    viaDepartureTime,
                    this->parseStringToBool(viaDepartureObj["canceled"].toString()),
                    viaDepartureObj["delay"].toString().toInt(),
                    viaDepartureTime,
                    this->parseStringToBool(viaDepartureObj["canceled"].toString()),
                    this->parseStringToBool(viaDepartureObj["left"].toString()),
                    this->parseOccupancy(viaDepartureOccupancyObj["name"].toString()),
                    this->parseStringToBool(viaDepartureObj["isExtraStop"].toString()),
                    viaDepartureObj["direction"].toObject()["name"].toString(),
                    this->parseStringToBool(viaDepartureObj["walking"].toString())
                    );

            // Return an empty Disturbances object if no alerts are available
            Disturbances* viaDisturbances = new Disturbances();
            if(viaObj.contains("alerts")) {
                qDebug() << "Alerts detected";
                QJsonArray alertArray = viaObj["alerts"].toObject()["alert"].toArray();

                // Loop through array and parse the JSON Alerts objects as C++ models
                foreach (const QJsonValue &item, alertArray) {
                    QJsonObject alertObj = item.toObject();
                    qDebug() << alertObj["id"].toString();
                    QDateTime timestampAlert;
                    timestampAlert.setTime_t(alertObj["startTime"].toString().toInt());
                    Alert* alert = new Alert(alertObj["id"].toString().toInt(), alertObj["title"].toString(), alertObj["description"].toString(), timestampAlert);
                    alertsList.append(alert);
                }
                // Update the disturbances for the specific item
                viaDisturbances->setAlerts(alertsList);
            }

            // Append Via to viaList
            viaList.append(new Via(viaStopArrival, viaStopDeparture, viaStation, viaTimeBetween, viaVehicleId, viaDisturbances));
        }

        IRail::Occupancy connectionOccupancy = this->parseOccupancy(connectionOccupancyObj["name"].toString());
        // TO DO: enable disturbances and remarks for the whole connection
        Connection* connection = new Connection(connectionId, fromStop, toStop, fromVehicleId, toVehicleId, disturbancesConnection, remarksConnection, connectionOccupancy, connectionDuration, new ViaListModel(viaList), timestampConnections);
        connectionList.append(connection);
        qDebug() << "CONNECTION:";
        qDebug() << "\tFrom:" << connection->from()->station()->name();
        qDebug() << "\tVia:" << connection->vias();
        qDebug() << "\tTo:" << connection->to()->station()->name();
    }
    return new ConnectionListModel(connectionList);
}

/*********************
 * Getters & Setters *
 *********************/

/**
 * @class API
 * @brief language getter.
 * @return QLocale::Language
 */
QLocale::Language API::language() const
{
    return m_language;
}

/**
 * @class API
 * @brief language setter.
 * @param language
 */
void API::setLanguage(const QLocale::Language &language)
{
    m_language = language;
    emit this->languageChanged();
}

/**
 * @class API
 * @brief busy getter.
 * @return bool
 */
bool API::busy() const
{
    return m_busy;
}

/**
 * @class API
 * @brief busy setter.
 * @param busy
 */
void API::setBusy(bool busy)
{
    m_busy = busy;
    emit this->busyChanged();
}

/**
 * @class API
 * @brief useragent getter.
 * @return QString
 */
QString API::useragent() const
{
    return m_useragent;
}

/**
 * @class API
 * @brief useragent setter.
 * @param useragent
 */
void API::setUseragent(const QString &useragent)
{
    m_useragent = useragent;
    emit this->useragentChanged();
}

StationListModelFilter *API::stations() const
{
    return m_stations;
}

void API::setStations(StationListModelFilter* stations)
{
    m_stations = stations;
    emit this->stationsChanged();
}

Disturbances *API::disturbances() const
{
    return m_disturbances;
}

void API::setDisturbances(Disturbances *disturbances)
{
    m_disturbances = disturbances;
    emit this->disturbancesChanged();
}

Liveboard *API::liveboard() const
{
    return m_liveboard;
}

void API::setLiveboard(Liveboard *liveboard)
{
    m_liveboard = liveboard;
    emit this->liveboardChanged();
}

Vehicle *API::vehicle() const
{
    return m_vehicle;
}

void API::setVehicle(Vehicle *vehicle)
{
    m_vehicle = vehicle;
    emit this->vehicleChanged();
}

/**
 * @class API
 * @brief connections getter.
 * @return QList<Connection*>
 */
ConnectionListModel* API::connections() const
{
    return m_connections;
}

/**
 * @class API
 * @brief connections setter.
 * @param connections
 */
void API::setConnections(ConnectionListModel* connections)
{
    m_connections = connections;
    emit this->connectionsChanged();
}

bool API::networkEnabled() const
{
    return m_networkEnabled;
}

void API::setNetworkEnabled(bool networkEnabled)
{
    m_networkEnabled = networkEnabled;
    emit this->networkStateChanged(networkEnabled);
}
