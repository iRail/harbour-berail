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
#ifndef API_H
#define API_H

#include <QtGlobal>
#include <QtCore/QObject>
#include <QtCore/QCoreApplication>
#include <QtCore/QFile>
#include <QtCore/QJsonDocument>
#include <QtCore/QJsonObject>
#include <QtCore/QJsonParseError>
#include <QtCore/QTimer>
#include <QtCore/QUrl>
#include <QtCore/QUrlQuery>
#include <QtGui/QColor>
#include <QtPositioning/QGeoCoordinate>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QNetworkConfigurationManager>
#include <QtNetwork/QNetworkDiskCache>
#include <QtSql/QSqlDatabase>

#include "os.h"
#include "models/station.h"
#include "models/disturbances.h"
#include "models/remarks.h"
#include "models/alert.h"
#include "models/liveboard.h"
#include "models/connection.h"
#include "models/via.h"
#include "models/stationlistmodelfilter.h"
#include "models/connectionlistmodel.h"
#include "models/vialistmodel.h"

#define STATIONS_ENDPOINT "https://api.irail.be/stations"
#define LIVEBOARD_ENDPOINT "https://api.irail.be/liveboard"
#define CONNECTIONS_ENDPOINT "https://api.irail.be/connections"
#define DISTURBANCES_ENDPOINT "https://api.irail.be/disturbances"
#define VEHICLE_ENDPOINT "https://api.irail.be/vehicle"
#define OCCUPANCY_ENDPOINT "https://api.irail.be/occupancy"

class API: public QObject
{
    Q_OBJECT
    Q_PROPERTY(StationListModelFilter* stations READ stations WRITE setStations NOTIFY stationsChanged)
    Q_PROPERTY(Disturbances* disturbances READ disturbances WRITE setDisturbances NOTIFY disturbancesChanged)
    Q_PROPERTY(Liveboard* liveboard READ liveboard WRITE setLiveboard NOTIFY liveboardChanged)
    Q_PROPERTY(Vehicle* vehicle READ vehicle WRITE setVehicle NOTIFY vehicleChanged)
    Q_PROPERTY(ConnectionListModel* connections READ connections WRITE setConnections NOTIFY connectionsChanged)
    Q_PROPERTY(QLocale::Language language READ language WRITE setLanguage NOTIFY languageChanged)
    Q_PROPERTY(QString useragent READ useragent NOTIFY languageChanged)

public:
    explicit API();
    virtual ~API();
    Q_INVOKABLE void getStations();
    Q_INVOKABLE void getDisturbances();
    Q_INVOKABLE void getVehicle(QString id, QDateTime time);
    Q_INVOKABLE void getLiveboard(QString stationName, QDateTime time, IRail::ArrDep arrdep);
    Q_INVOKABLE void getConnections(QString fromStation, QString toStation, IRail::ArrDep arrdep, QDateTime time, IRail::Transport transportType);
    bool busy() const;
    void setBusy(bool busy);
    QString useragent() const;
    void setUseragent(const QString &useragent);
    StationListModelFilter* stations() const;
    void setStations(StationListModelFilter* stations);
    QLocale::Language language() const;
    void setLanguage(const QLocale::Language &language);
    Disturbances* disturbances() const;
    void setDisturbances(Disturbances *disturbances);
    Liveboard *liveboard() const;
    void setLiveboard(Liveboard *liveboard);
    Vehicle *vehicle() const;
    void setVehicle(Vehicle *vehicle);
    ConnectionListModel* connections() const;
    void setConnections(ConnectionListModel* connections);

signals:
    void busyChanged();
    void useragentChanged();
    void stationsChanged();
    void disturbancesChanged();
    void vehicleChanged();
    void liveboardChanged();
    void connectionsChanged();
    void occupancyUpdated();
    void languageChanged();
    void errorOccurred(const QString &errorText);
    void networkStateChanged(const bool &state);

private slots:
    void sslErrors(QNetworkReply* reply, QList<QSslError> sslError);
    void networkAccessible(QNetworkAccessManager::NetworkAccessibility state);
    void finished (QNetworkReply *reply);

private:
    bool m_busy;
    bool m_alertsEnabled;
    QString m_useragent;
    QLocale::Language m_language = QLocale::English;
    StationListModelFilter* m_stations;
    Disturbances* m_disturbances;
    Liveboard* m_liveboard;
    Vehicle* m_vehicle;
    ConnectionListModel* m_connections;
    QNetworkAccessManager* QNAM;
    QNetworkDiskCache* QNAMCache;
    OS SFOS;
    QString parseLanguage(QLocale::Language language);
    QString parseDate(QDateTime time);
    QString parseTime(QDateTime time);
    QString parseArrdep(IRail::ArrDep arrdep);
    QString parseTransport(IRail::Transport transportType);
    IRail::Occupancy parseOccupancy(QString occupancy);
    QString parseDateOccupancy(QDateTime time);
    bool parseStringToBool(QString value);
    QNetworkRequest prepareRequest(QUrl url, QUrlQuery parameters);
    StationListModelFilter* parseStations(QJsonObject json);
    Disturbances* parseDisturbances(QJsonObject json);
    Vehicle* parseVehicle(QJsonObject json);
    Liveboard* parseLiveboard(QJsonObject json);
    ConnectionListModel* parseConnections(QJsonObject json);
};

#endif // API_H
