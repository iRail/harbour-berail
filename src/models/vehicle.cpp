#include "vehicle.h"

Vehicle::Vehicle(QString id, QDate date, QList<Stop*> stops, QGeoCoordinate location, bool canceled, IRail::Occupancy occupancy, Disturbances* disturbances, QDateTime timestamp)
{
    setId(id);
    setDate(date);
    setStops(stops);
    setLocation(location);
    setCanceled(canceled);
    setOccupancy(occupancy);
    setDisturbances(disturbances);
    setTimestamp(timestamp);
}

/*********************
 * Getters & Setters *
 *********************/

QString Vehicle::id() const
{
    return m_id;
}

void Vehicle::setId(const QString &id)
{
    m_id = id;
}

QDate Vehicle::date() const
{
    return m_date;
}

void Vehicle::setDate(const QDate &date)
{
    m_date = date;
}

QList<Stop *> Vehicle::stops() const
{
    return m_stops;
}

void Vehicle::setStops(const QList<Stop *> &stops)
{
    m_stops = stops;
}

QGeoCoordinate Vehicle::location() const
{
    return m_location;
}

void Vehicle::setLocation(const QGeoCoordinate &location)
{
    m_location = location;
}

bool Vehicle::canceled() const
{
    return m_canceled;
}

void Vehicle::setCanceled(bool canceled)
{
    m_canceled = canceled;
}

IRail::Occupancy Vehicle::occupancy() const
{
    return m_occupancy;
}

void Vehicle::setOccupancy(const IRail::Occupancy &occupancy)
{
    m_occupancy = occupancy;
}

Disturbances *Vehicle::disturbances() const
{
    return m_disturbances;
}

void Vehicle::setDisturbances(Disturbances *disturbances)
{
    m_disturbances = disturbances;
}

QDateTime Vehicle::timestamp() const
{
    return m_timestamp;
}

void Vehicle::setTimestamp(const QDateTime &timestamp)
{
    m_timestamp = timestamp;
}
