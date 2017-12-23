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
#include "via.h"

Via::Via(Stop* arrival, Stop* departure, Station* station, int timeBetween, QString vehicleId, Disturbances* disturbances)
{
    this->setArrival(arrival);
    this->setDeparture(departure);
    this->setStation(station);
    this->setTimeBetween(timeBetween);
    this->setVehicleId(vehicleId);
    this->setDisturbances(disturbances);
}

/*********************
 * Getters & Setters *
 *********************/

int Via::id() const
{
    return m_id;
}

void Via::setId(int id)
{
    m_id = id;
    emit this->idChanged();
}

Stop *Via::arrival() const
{
    return m_arrival;
}

void Via::setArrival(Stop *arrival)
{
    m_arrival = arrival;
    emit this->arrivalChanged();
}

Stop *Via::departure() const
{
    return m_departure;
}

void Via::setDeparture(Stop *departure)
{
    m_departure = departure;
    emit this->departureChanged();
}

Station *Via::station() const
{
    return m_station;
}

void Via::setStation(Station *station)
{
    m_station = station;
    emit this->stationChanged();
}

int Via::timeBetween() const
{
    return m_timeBetween;
}

void Via::setTimeBetween(int timeBetween)
{
    m_timeBetween = timeBetween;
    emit this->timeBetweenChanged();
}

QString Via::vehicleId() const
{
    return m_vehicleId;
}

void Via::setVehicleId(const QString &vehicleId)
{
    m_vehicleId = vehicleId;
    emit this->vehicleIdChanged();
}

Disturbances *Via::disturbances() const
{
    return m_disturbances;
}

void Via::setDisturbances(Disturbances *disturbances)
{
    m_disturbances = disturbances;
}

