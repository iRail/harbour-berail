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
#include "connection.h"

Connection::Connection(int id, Stop* fromStation, Stop* toStation, Disturbances* alerts, Remarks* remarks, IRail::Occupancy occupancy, int duration, ViaListModel* vias, QDateTime timestamp)
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

IRail::Occupancy Connection::occupancy() const
{
    return m_occupancy;
}

void Connection::setOccupancy(const IRail::Occupancy &occupancy)
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

Remarks *Connection::remarks() const
{
    return m_remarks;
}

void Connection::setRemarks(Remarks *remarks)
{
    m_remarks = remarks;
    emit this->remarksChanged();
}

ViaListModel *Connection::vias() const
{
    return m_vias;
}

void Connection::setVias(ViaListModel *vias)
{
    m_vias = vias;
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
