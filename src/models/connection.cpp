#include "connection.h"

Connection::Connection(int id, Stop* fromStation, Stop* toStation, Disturbances* alerts, Disturbances* remarks, Occupancy occupancy, int duration, QList<Stop*> vias, QDateTime timestamp)
{
    this->setId(id);
    this->setFrom(fromStation);
    this->setTo(toStation);
    this->setAlerts(alerts);
    this->setRemarks(remarks);
    this->setOccupancy(occupancy);
    this->setDuration(duration);
    this->setVias(vias);
    this->setTimestamp(timestamp);
}

/*********************
 * Getters & Setters *
 *********************/

int Connection::id() const
{
    return m_id;
}

void Connection::setId(const int &id)
{
    m_id = id;
    emit this->idChanged();
}

Occupancy Connection::occupancy() const
{
    return m_occupancy;
}

void Connection::setOccupancy(const Occupancy &occupancy)
{
    m_occupancy = occupancy;
    emit this->occupancyChanged();
}

int Connection::duration() const
{
    return m_duration;
}

void Connection::setDuration(int duration)
{
    m_duration = duration;
    emit this->durationChanged();
}

Stop *Connection::from() const
{
    return m_from;
}

void Connection::setFrom(Stop *from)
{
    m_from = from;
    emit this->fromChanged();
}

Stop *Connection::to() const
{
    return m_to;
}

void Connection::setTo(Stop *to)
{
    m_to = to;
    emit this->toChanged();
}

Disturbances *Connection::alerts() const
{
    return m_alerts;
}

void Connection::setAlerts(Disturbances *alerts)
{
    m_alerts = alerts;
    emit this->alertsChanged();
}

Disturbances *Connection::remarks() const
{
    return m_remarks;
}

void Connection::setRemarks(Disturbances *remarks)
{
    m_remarks = remarks;
    emit this->remarksChanged();
}

QList<Stop *> Connection::vias() const
{
    return m_vias;
}

void Connection::setVias(const QList<Stop *> &vias)
{
    m_vias = vias;
    emit this->viasChanged();
}

QDateTime Connection::timestamp() const
{
    return m_timestamp;
}

void Connection::setTimestamp(const QDateTime &value)
{
    m_timestamp = value;
    emit this->timestampChanged();
}
