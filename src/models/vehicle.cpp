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
#include "vehicle.h"

Vehicle::Vehicle(QString id, QDate date, QList<Stop*> stops, QGeoCoordinate location, bool canceled, IRail::Occupancy occupancy, Disturbances* disturbances, QDateTime timestamp)
{
    this->setId(id);
    this->setDate(date);
    this->setStops(stops);
    this->setLocation(location);
    this->setCanceled(canceled);
    this->setOccupancy(occupancy);
    this->setDisturbances(disturbances);
    this->setTimestamp(timestamp);
}

Vehicle::~Vehicle()
{
    if(!this->stops().isEmpty()) {
        foreach(Stop* item, this->stops()) {
            item->deleteLater();
        }
    }
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
    emit this->idChanged();
}

QDate Vehicle::date() const
{
    return m_date;
}

void Vehicle::setDate(const QDate &date)
{
    m_date = date;
    emit this->dateChanged();
}

QList<Stop *> Vehicle::stops() const
{
    return m_stops;
}

void Vehicle::setStops(const QList<Stop *> &stops)
{
    m_stops = stops;
    this->setStopListModel(new StopListModel(stops));
    emit this->stopsChanged();
}

QGeoCoordinate Vehicle::location() const
{
    return m_location;
}

void Vehicle::setLocation(const QGeoCoordinate &location)
{
    m_location = location;
    emit this->locationChanged();
}

bool Vehicle::canceled() const
{
    return m_canceled;
}

void Vehicle::setCanceled(bool canceled)
{
    m_canceled = canceled;
    emit this->canceledChanged();
}

IRail::Occupancy Vehicle::occupancy() const
{
    return m_occupancy;
}

void Vehicle::setOccupancy(const IRail::Occupancy &occupancy)
{
    m_occupancy = occupancy;
    emit this->occupancyChanged();
}

Disturbances *Vehicle::disturbances() const
{
    return m_disturbances;
}

void Vehicle::setDisturbances(Disturbances *disturbances)
{
    m_disturbances = disturbances;
    this->setAlertListModel(new AlertListModel(disturbances->alerts()));
    emit this->disturbancesChanged();
}

QDateTime Vehicle::timestamp() const
{
    return m_timestamp;
}

void Vehicle::setTimestamp(const QDateTime &timestamp)
{
    m_timestamp = timestamp;
    emit this->timestampChanged();
}

StopListModel *Vehicle::stopListModel() const
{
    return m_stopListModel;
}

void Vehicle::setStopListModel(StopListModel *stopListModel)
{
    m_stopListModel = stopListModel;
    emit this->stopListModelChanged();
}

AlertListModel *Vehicle::alertListModel() const
{
    return m_alertListModel;
}

void Vehicle::setAlertListModel(AlertListModel *alertListModel)
{
    m_alertListModel = alertListModel;
}
