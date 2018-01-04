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

#include "stopabstract.h"

StopAbstract::StopAbstract()
{

}

/*********************
 * Getters & Setters *
 *********************/

int StopAbstract::id() const
{
    return m_id;
}

void StopAbstract::setId(int id)
{
    m_id = id;
    emit this->idChanged();
}

Station *StopAbstract::station() const
{
    return m_station;
}

void StopAbstract::setStation(Station *station)
{
    m_station = station;
    emit this->stationChanged();
}

int StopAbstract::departureDelay() const
{
    return m_departureDelay;
}

void StopAbstract::setDepartureDelay(int departureDelay)
{
    m_departureDelay = departureDelay;
    emit this->departureDelayChanged();
}

QDateTime StopAbstract::scheduledDepartureTime() const
{
    return m_scheduledDepartureTime;
}

void StopAbstract::setScheduledDepartureTime(const QDateTime &scheduledDepartureTime)
{
    m_scheduledDepartureTime = scheduledDepartureTime;
    emit this->scheduledDepartureTimeChanged();
}

bool StopAbstract::departureCanceled() const
{
    return m_departureCanceled;
}

void StopAbstract::setDepartureCanceled(bool departureCanceled)
{
    m_departureCanceled = departureCanceled;
    emit this->departureCanceledChanged();
}

int StopAbstract::arrivalDelay() const
{
    return m_arrivalDelay;
}

void StopAbstract::setArrivalDelay(int arrivalDelay)
{
    m_arrivalDelay = arrivalDelay;
    emit this->arrivalDelayChanged();
}

QDateTime StopAbstract::scheduledArrivalTime() const
{
    return m_scheduledArrivalTime;
}

void StopAbstract::setScheduledArrivalTime(const QDateTime &scheduledArrivalTime)
{
    m_scheduledArrivalTime = scheduledArrivalTime;
    emit this->scheduledArrivalTimeChanged();
}

bool StopAbstract::arrivalCanceled() const
{
    return m_arrivalCanceled;
}

void StopAbstract::setArrivalCanceled(bool arrivalCanceled)
{
    m_arrivalCanceled = arrivalCanceled;
    emit this->arrivalCanceledChanged();
}

IRail::Occupancy StopAbstract::occupancy() const
{
    return m_occupancy;
}

void StopAbstract::setOccupancy(const IRail::Occupancy &occupancy)
{
    m_occupancy = occupancy;
    emit this->occupancyChanged();
}

bool StopAbstract::isExtraStop() const
{
    return m_isExtraStop;
}

void StopAbstract::setIsExtraStop(bool isExtraStop)
{
    m_isExtraStop = isExtraStop;
    emit this->isExtraStopChanged();
}

QString StopAbstract::direction() const
{
    return m_direction;
}

void StopAbstract::setDirection(const QString &direction)
{
    m_direction = direction;
    emit this->directionChanged();
}

bool StopAbstract::walking() const
{
    return m_walking;
}

void StopAbstract::setWalking(bool walking)
{
    m_walking = walking;
    emit this->walkingChanged();
}

