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

    // Connect QNetworkAccessManager signals
    connect(QNAM, SIGNAL(networkAccessibleChanged(QNetworkAccessManager::NetworkAccessibility)), this, SLOT(networkAccessible(QNetworkAccessManager::NetworkAccessibility)));
    connect(QNAM, SIGNAL(sslErrors(QNetworkReply*,QList<QSslError>)), this, SLOT(sslErrors(QNetworkReply*,QList<QSslError>)));
    connect(QNAM, SIGNAL(finished(QNetworkReply*)), this, SLOT(finished(QNetworkReply*)));

    // Create User-Agent
    qDebug() << SFOS.appVersion();
    setUseragent(QString("%1/%2 (%3)").arg(SFOS.appNamePretty(), SFOS.appVersion(), SFOS.release()));
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

QString API::parseArrdep(ArrDep arrdep) {
    if(arrdep == ArrDep::Arrival)
    {
        return "arrival";
    }
    return "departure";
}

QString API::parseTransport(Transport transportType) {
    if(transportType == Transport::Trains)
    {
        return "trains";
    }
    else if(transportType == Transport::NoInternationalTrains)
    {
        return "nointernationaltrains";
    }
    return "all";
}

Occupancy API::parseOccupancy(QString occupancy)
{
    if(occupancy.contains("low"))
    {
        return Occupancy::Low;
    }
    else if(occupancy.contains("medium"))
    {
        return Occupancy::Medium;
    }
    else if(occupancy.contains("high"))
    {
        return Occupancy::High;
    }

    return Occupancy::Unknown;
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
    request.setAttribute(QNetworkRequest::CacheLoadControlAttribute, QNetworkRequest::PreferCache);
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

void API::getLiveboard(QString stationName, QDateTime time, ArrDep arrdep)
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

void API::getConnections(QString fromStation, QString toStation, ArrDep arrdep, QDateTime time, Transport transportType)
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
    if(reply->error()) {
        qCritical() << reply->errorString();
        emit errorOccurred(reply->errorString());
    }
    else if(reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() == 301 || reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() == 302) {
        qDebug() << "HTTP 301/302: MOVED, following redirect...";
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
            // emit error here
            qCritical() << "Received data isn't properly formatted as JSON! QJsonParseError:" << parseError.errorString();
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
    emit errorOccurred(QString("SSL error occured"));
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
    }
    else {
        qInfo() << "Network online";
    }
}

/**
 * @brief Parses Station JSON data
 * @details Parses the iRail Station JSON data from the /stations endpoint.
 * @warning Station objects aren't owned by the QList, deleting the QList requires to delete the Station objects as well!
 * @param json
 * @return QList<Station*>
 */
QList<Station*> API::parseStations(QJsonObject json)
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
    }

    qDebug() << stationsList;
    return stationsList;
}

Disturbances* API::parseDisturbances(QJsonObject json)
{
    qDebug() << "Parsing disturbances";
    QList<Alert*> alertsList;
    QDateTime timestampDisturbances;
    timestampDisturbances.setTime_t(json["timestamp"].toString().toInt());
    qDebug() << timestampDisturbances;
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
    qDebug() << alertsList;

    return disturbances;
}

Vehicle* API::parseVehicle(QJsonObject json)
{
    qDebug() << "Parsing vehicles";
    QList<Stop*> stopList;
    QList<Alert*> alertsList;
    QDateTime timestampVehicle;
    timestampVehicle.setTime_t(json["timestamp"].toString().toInt());
    qDebug() << timestampVehicle;
    QJsonObject vehicleInfo = json["vehicleinfo"].toObject();
    QGeoCoordinate vehicleLocation(vehicleInfo["locationY"].toString().toDouble(), vehicleInfo["locationX"].toString().toDouble());
    QJsonArray stopArray = json["stops"].toObject()["stop"].toArray();
    bool isCanceled = false;
    QList<Occupancy> occupancyList;

    // Return an empty Disturbances object if no alerts are available
    Disturbances *disturbances = new Disturbances();
    if(json.contains("alerts")) {
        qDebug() << "Alerts detected";
        QJsonArray alertArray = json["alerts"].toObject()["alert"].toArray();

        // Loop through array and parse the JSON Alerts objects as C++ models
        foreach (const QJsonValue &item, alertArray) {
            QJsonObject alertObj = item.toObject();
            qDebug() << alertObj["id"].toString();
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
    Occupancy occupancyMedian = occupancyList.at(occupancyList.length()/2);
    Vehicle* vehicle = new Vehicle(vehicleInfo["name"].toString(), timestampVehicle.date(), stopList, vehicleLocation, isCanceled, occupancyMedian, disturbances, timestampVehicle);
    qDebug() << "Vehicle:" << vehicle->id();
    qDebug() << "Disturbances:" << vehicle->disturbances();
    qDebug() << "Alerts:" << vehicle->disturbances()->alerts();
    qDebug() << "Stops:" << vehicle->stops();
    return vehicle;
}

Liveboard *API::parseLiveboard(QJsonObject json)
{
    qDebug() << "Parsing liveboard";
    QJsonObject departureStationObj = json["stationinfo"].toObject();
    QJsonObject departuresObj = json["departures"].toObject();
    QJsonArray departureArray = departuresObj["departure"].toArray();
    Disturbances* disturbancesLiveboard = new Disturbances();
    ArrDep arrdep;
    QList<Vehicle*> vehicleList;

    // Handle different types of data for the liveboard
    if(json.contains("departures")) {
        departuresObj = json["departures"].toObject();
        departureArray = departuresObj["departure"].toArray();
        arrdep = ArrDep::Departure;
    }
    else {
        departuresObj = json["arrivals"].toObject();
        departureArray = departuresObj["arrival"].toArray();
        arrdep = ArrDep::Arrival;
    }
    QDateTime timestampLiveboard;
    timestampLiveboard.setTime_t(json["timestamp"].toString().toInt());
    QGeoCoordinate stationLocation(departureStationObj["locationY"].toString().toDouble(), departureStationObj["locationX"].toString().toDouble());
    Station* station = new Station(departureStationObj["id"].toString(), departureStationObj["standardname"].toString(), stationLocation);

    // Loop through array and parse the JSON Stop objects as C++ models
    foreach (const QJsonValue &item, departureArray) {
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
        qDebug() << vehicleObj["name"].toString();

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
                qDebug() << alertObj["id"].toString();
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
        qDebug() << "Vehicle:" << vehicle->id();
        qDebug() << "Timestamp:" << vehicle->timestamp();
        qDebug() << "Disturbances:" << vehicle->disturbances();
        qDebug() << "Departure:" << vehicle->stops().at(0);

        // Append vehicle to list
        vehicleList.append(vehicle);
    }

    // Create Liveboard using our data from above
    Liveboard* liveboard = new Liveboard(station, vehicleList, timestampLiveboard, arrdep, disturbancesLiveboard);
    qDebug() << "Station:" << liveboard->station()->name();
    qDebug() << "1st vehicle:" << liveboard->vehicles().at(0)->name();
    qDebug() << "Timestamp:" << liveboard->timestamp();
    qDebug() << "Disturbances:" << liveboard->disturbances();
    qDebug() << "Alerts:" << liveboard->disturbances()->alerts();
    return liveboard;
}

QList<Connection*> API::parseConnections(QJsonObject json)
{
    qDebug() << "Parsing connections...";
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
        QJsonObject connectionAlertsObj = item["alerts"].toObject();
        int connectionDuration = item["duration"].toString().toInt();
        int connectionId = item["id"].toString().toInt();
        QJsonObject viasObj = item["vias"].toObject();
        QJsonArray viasArray = viasObj["via"].toArray();
        QDateTime fromTime;
        fromTime.setTime_t(departureObj["time"].toString().toInt());
        QDateTime toTime;
        toTime.setTime_t(arrivalObj["time"].toString().toInt());
        QString departureVehicleId = departureObj["vehicle"].toString();
        QString arrivalVehicleId = arrivalObj["vehicle"].toString();
        QList<Stop*> viaList;

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
                departureObj["direction"].toString(),
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
                this->parseStringToBool(arrivalObj["left"].toString()),
                this->parseOccupancy(toOccupancyObj["name"].toString()),
                false, // isExtraStop ALWAYS false
                arrivalObj["direction"].toString(),
                this->parseStringToBool(arrivalObj["walking"].toString())
                );

        // Handle via Stops
        /*foreach (const QJsonValue &via, viasArray) {
            QJsonObject viaStationObj = via["stationinfo"].toObject();

            QDateTime viaTime;
            viaTime.setTime_t(via["time"].toString().toInt());
            QGeoCoordinate viaStationLocation(viaStationObj["locationY"].toString().toDouble(), viaStationObj["locationX"].toString().toDouble());
            Station* viaStation = new Station(viaStationObj["id"].toString(), viaStationObj["standardname"].toString(), viaStationLocation);
            Stop* viaStopArrival = new Stop(via["id"].toString().toInt(),
                    viaStation,
                    toPlatformObj["name"].toString(),
                    this->parseStringToBool(toPlatformObj["normal"].toString()),
                    arrivalObj["delay"].toString().toInt(),
                    viaTime,
                    this->parseStringToBool(arrivalObj["canceled"].toString()),
                    arrivalObj["delay"].toString().toInt(),
                    viaTime,
                    this->parseStringToBool(arrivalObj["canceled"].toString()),
                    this->parseStringToBool(arrivalObj["left"].toString()),
                    this->parseOccupancy(toOccupancyObj["name"].toString()),
                    false, // isExtraStop ALWAYS false
                    arrivalObj["direction"].toString(),
                    this->parseStringToBool(arrivalObj["walking"].toString())
                    );

            Stop* viaStopDeparture = new Stop(via["id"].toString().toInt(),
                    viaStation,
                    toPlatformObj["name"].toString(),
                    this->parseStringToBool(toPlatformObj["normal"].toString()),
                    arrivalObj["delay"].toString().toInt(),
                    viaTime,
                    this->parseStringToBool(arrivalObj["canceled"].toString()),
                    arrivalObj["delay"].toString().toInt(),
                    viaTime,
                    this->parseStringToBool(arrivalObj["canceled"].toString()),
                    this->parseStringToBool(arrivalObj["left"].toString()),
                    this->parseOccupancy(toOccupancyObj["name"].toString()),
                    false, // isExtraStop ALWAYS false
                    arrivalObj["direction"].toString(),
                    this->parseStringToBool(arrivalObj["walking"].toString())
                    );
        }*/

        Occupancy connectionOccupancy = this->parseOccupancy(connectionOccupancyObj["name"].toString());
        Connection* connection = new Connection(connectionId, fromStop, toStop, new Disturbances(), new Disturbances(), connectionOccupancy, connectionDuration, viaList, timestampConnections);
        connectionList.append(connection);
        qDebug() << "Connection:";
        qDebug() << "\tFrom:" << connection->from()->station()->name();
        qDebug() << "\tTo:" << connection->to()->station()->name();
    }

    qDebug() << "Connection list:" << connectionList;
    return connectionList;
}

/*********************
 * Getters & Setters *
 *********************/

/**
 * @class API
 * @brief stations getter.
 * @return QList<Station*>
 */
QList<Station*> API::stations() const
{
    return m_stations;
}

/**
 * @class API
 * @brief stations setter.
 * @param stations
 */
void API::setStations(const QList<Station*> &stations)
{
    m_stations = stations;
}

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
}

Disturbances *API::disturbances() const
{
    return m_disturbances;
}

void API::setDisturbances(Disturbances *disturbances)
{
    m_disturbances = disturbances;
}

Liveboard *API::liveboard() const
{
    return m_liveboard;
}

void API::setLiveboard(Liveboard *liveboard)
{
    m_liveboard = liveboard;
}

Vehicle *API::vehicle() const
{
    return m_vehicle;
}

void API::setVehicle(Vehicle *vehicle)
{
    m_vehicle = vehicle;
}

/**
 * @class API
 * @brief connections getter.
 * @return QList<Connection*>
 */
QList<Connection*> API::connections() const
{
    return m_connections;
}

/**
 * @class API
 * @brief connections setter.
 * @param connections
 */
void API::setConnections(const QList<Connection*> &connections)
{
    m_connections = connections;
}
