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
#include "models/alert.h"
#include "models/liveboard.h"

#define STATIONS_ENDPOINT "https://api.irail.be/stations"
#define LIVEBOARD_ENDPOINT "https://api.irail.be/liveboard"
#define CONNECTIONS_ENDPOINT "https://api.irail.be/connections"
#define DISTURBANCES_ENDPOINT "https://api.irail.be/disturbances"
#define VEHICLE_ENDPOINT "https://api.irail.be/vehicle"
#define OCCUPANCY_ENDPOINT "https://api.irail.be/occupancy"

class API: public QObject
{
    Q_OBJECT
public:
    explicit API();
    virtual ~API();
    Q_INVOKABLE void getStations();
    Q_INVOKABLE void getDisturbances();
    Q_INVOKABLE void getVehicle(QString id, QDateTime time);
    Q_INVOKABLE void getLiveboard(QString stationName, QDateTime time, ArrDep arrdep);
    bool busy() const;
    void setBusy(bool busy);
    QString useragent() const;
    void setUseragent(const QString &useragent);
    QList<Station*> stations() const;
    void setStations(const QList<Station*> &stations); 
    QLocale::Language language() const;
    void setLanguage(const QLocale::Language &language);
    Disturbances* disturbances() const;
    void setDisturbances(Disturbances *disturbances);
    Liveboard *liveboard() const;
    void setLiveboard(Liveboard *liveboard);
    Vehicle *vehicle() const;
    void setVehicle(Vehicle *vehicle);

signals:
    void busyChanged();
    void useragentChanged();
    void stationsChanged();
    void disturbancesChanged();
    void errorOccurred(const QString &errorText);

private slots:
    void sslErrors(QNetworkReply* reply, QList<QSslError> sslError);
    void networkAccessible(QNetworkAccessManager::NetworkAccessibility state);
    void finished (QNetworkReply *reply);

private:
    bool m_busy;
    bool m_alertsEnabled;
    QString m_useragent;
    QLocale::Language m_language = QLocale::English;
    QList<Station*> m_stations;
    Disturbances* m_disturbances;
    Liveboard* m_liveboard;
    Vehicle* m_vehicle;
    QNetworkAccessManager* QNAM;
    QNetworkDiskCache* QNAMCache;
    OS SFOS;
    QString parseLanguage(QLocale::Language language);
    QString parseDate(QDateTime time);
    QString parseTime(QDateTime time);
    QString parseArrdep(ArrDep arrdep);
    Occupancy parseOccupancy(QString occupancy);
    QNetworkRequest prepareRequest(QUrl url, QUrlQuery parameters);
    QList<Station*> parseStations(QJsonObject json);
    Disturbances* parseDisturbances(QJsonObject json);
    Vehicle* parseVehicle(QJsonObject json);
    Liveboard* parseLiveboard(QJsonObject json);
    bool parseJSONStringToBool(QString value);
};

#endif // API_H
