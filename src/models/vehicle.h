#ifndef VEHICLE_H
#define VEHICLE_H

#include <QtCore/QObject>
#include <QtCore/QString>
#include <QtCore/QDateTime>
#include <QtCore/QList>
#include <QtPositioning/QGeoCoordinate>

#include "disturbances.h"
#include "stop.h"
#include "enum.h"

class Vehicle: public QObject
{
    Q_OBJECT
public:
    explicit Vehicle(QString id, QDate date, QList<Stop*> stops, QGeoCoordinate location, bool canceled, Occupancy occupancy, Disturbances* disturbances, QDateTime timestamp);
    //virtual ~Vehicle();

    QString id() const;
    void setId(const QString &id);
    QDate date() const;
    void setDate(const QDate &date);
    QString name() const;
    void setName(const QString &name);
    QList<Stop *> stops() const;
    void setStops(const QList<Stop *> &stops);
    QGeoCoordinate location() const;
    void setLocation(const QGeoCoordinate &location);
    bool canceled() const;
    void setCanceled(bool cancelled);
    Occupancy occupancy() const;
    void setOccupancy(const Occupancy &occupancy);
    Disturbances *disturbances() const;
    void setDisturbances(Disturbances *disturbances);
    QDateTime timestamp() const;
    void setTimestamp(const QDateTime &timestamp);

private:
    QString m_id;
    QDate m_date;
    QString m_name;
    QList<Stop*> m_stops;
    QGeoCoordinate m_location;
    bool m_canceled;
    Occupancy m_occupancy;
    Disturbances* m_disturbances;
    QDateTime m_timestamp;
};

#endif // VEHICLE_H
