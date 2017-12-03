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
    setBusy(true);

    // Add default URL parameters
    parameters.addQueryItem("format", "json");
    parameters.addQueryItem("lang", parseLanguage(language()));
    url.setQuery(parameters);

    // Create QNetworkRequest
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setHeader(QNetworkRequest::UserAgentHeader, useragent());
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
    QNAM->get(prepareRequest(url, parameters));
}

void API::getDisturbances()
{
    // Build URL
    QUrl url(QString(DISTURBANCES_ENDPOINT));
    QUrlQuery parameters;

    // Prepare & do request
    QNAM->get(prepareRequest(url, parameters));
}

void API::getVehicle(QString id, QDateTime time)
{
    // Build URL
    QUrl url(QString(VEHICLE_ENDPOINT));
    QUrlQuery parameters;
    parameters.addQueryItem("id", id);
    parameters.addQueryItem("date", parseDate(time));

    // Prepare & do request
    QNAM->get(prepareRequest(url, parameters));
}

void API::getLiveboard(QString stationName, QDateTime time, ArrDep arrdep)
{
    // Build URL
    QUrl url(QString(LIVEBOARD_ENDPOINT));
    QUrlQuery parameters;
    parameters.addQueryItem("station", stationName);
    parameters.addQueryItem("date", parseDate(time));
    parameters.addQueryItem("time", parseTime(time));
    parameters.addQueryItem("arrdep", parseArrdep(arrdep));

    // Prepare & do request
    QNAM->get(prepareRequest(url, parameters));
}

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
        qDebug() << "HTTP 301/302: moved, following redirect";
    }
    else {
        qDebug() << "Content-Header:" << reply->header(QNetworkRequest::ContentTypeHeader).toString();
        qDebug() << "Content-Length:" << reply->header(QNetworkRequest::ContentLengthHeader).toULongLong() << "bytes";
        qDebug() << "HTTP code:" << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
        qDebug() << "HTTP reason:" << reply->attribute(QNetworkRequest::HttpReasonPhraseAttribute).toString();
        qDebug() << "Cache:" << reply->attribute(QNetworkRequest::SourceIsFromCacheAttribute).toBool();

        // Get the data from the request
        QString replyData = (QString)reply->readAll();
        qDebug() << replyData;

        // Try to parse the data as JSON
        QJsonParseError parseError;
        QJsonDocument jsonData = QJsonDocument::fromJson(replyData.toUtf8(), &parseError);

        // If parsing succesfull, use the data
        if(parseError.error == QJsonParseError::NoError) {
            QJsonObject jsonObject = jsonData.object();

            // Parse data in the right C++ model or database
            if(reply->url().toString().contains("stations", Qt::CaseInsensitive)) {
                qDebug() << "iRail stations data received";
                setStations(parseStations(jsonObject));
            }
            else if(reply->url().toString().contains("liveboard", Qt::CaseInsensitive)) {
                qDebug() << "iRail liveboard data received";
                setLiveboard(parseLiveboard(jsonObject));
            }
            else if(reply->url().toString().contains("connections", Qt::CaseInsensitive)) {
                qDebug() << "iRail connections data received";
                //setRoute(parseRoute(jsonObject));
            }
            else if(reply->url().toString().contains("vehicle", Qt::CaseInsensitive)) {
                qDebug() << "iRail vehicle data received";
                setVehicle(parseVehicle(jsonObject));
            }
            else if(reply->url().toString().contains("occupancy", Qt::CaseInsensitive)) {
                qDebug() << "iRail occupancy data received";
            }
            else if(reply->url().toString().contains("disturbances", Qt::CaseInsensitive)) {
                qDebug() << "iRail disturbances data received";
                setDisturbances(parseDisturbances(jsonObject));
            }
            else if(reply->url().toString().contains("logs", Qt::CaseInsensitive)) {
                qDebug() << "iRail Log data received";
            }
        }
        else {
            qCritical() << "Received data isn't properly formatted as JSON! QJsonParseError:" << parseError.errorString();
        }
    }

    reply->deleteLater();
    setBusy(false);
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


        Stop* stop = new Stop(
                        stopObj["id"].toString().toInt(),
                        station,
                        platformObj["name"].toString(),
                        platformObj["normal"].toString().toInt(),
                        stopObj["departureDelay"].toString().toInt(),
                        scheduledDepartureTime,
                        parseJSONStringToBool(stopObj["departureCanceled"].toString()),
                        stopObj["arrivalDelay"].toString().toInt(),
                        scheduledArrivalTime,
                        parseJSONStringToBool(stopObj["arrivalCanceled"].toString()),
                        parseJSONStringToBool(stopObj["left"].toString()),
                        parseOccupancy(occupancyObj["name"].toString())
                        );
        stopList.append(stop);

        if(!isCanceled) {
            isCanceled = parseJSONStringToBool(stopObj["departureCanceled"].toString()) || parseJSONStringToBool(stopObj["arrivalCanceled"].toString());
        }

        occupancyList.append(parseOccupancy(occupancyObj["name"].toString()));
    }

    std::sort(occupancyList.begin(), occupancyList.end());
    Occupancy occupancyMedian = occupancyList.at(occupancyList.length()/2);
    Vehicle* vehicle = new Vehicle(vehicleInfo["name"].toString(), timestampVehicle.date(), stopList, vehicleLocation, isCanceled, occupancyMedian, disturbances, timestampVehicle);
    qDebug() << vehicle;
    qDebug() << vehicle->disturbances();
    qDebug() << vehicle->id();
    qDebug() << stopList;
    return vehicle;
}

Liveboard *API::parseLiveboard(QJsonObject json)
{
    // TO DO: parsing function for the JSON Liveboard data
}

bool API::parseJSONStringToBool(QString value)
{
    if(value == "1") {
        return true;
    }
    return false;
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
    emit stationsChanged();
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
    emit busyChanged();
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
    emit useragentChanged();
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
