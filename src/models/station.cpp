#include "station.h"

Station::Station() {

}

Station::Station(QString id, QString name, QGeoCoordinate location) {
    setId(id);
    setName(name);
    setLocation(location);
}

/*********************
 * Getters & Setters *
 *********************/

QString Station::id() const
{
    return m_id;
}

void Station::setId(const QString &id)
{
    m_id = id;
}

QString Station::name() const
{
    return m_name;
}

void Station::setName(const QString &name)
{
    m_name = name;
}

QGeoCoordinate Station::location() const
{
    return m_location;
}

void Station::setLocation(const QGeoCoordinate &location)
{
    m_location = location;
}
