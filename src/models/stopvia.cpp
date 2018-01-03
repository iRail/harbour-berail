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

#include "stopvia.h"
#include <QtGlobal>
#include <QDebug>

StopVia::StopVia(int id, Station *station, QString arrivalPlatform, bool isDefaultArrivalPlatform, QString departurePlatform, bool isDefaultDeparturePlatform, int departureDelay, QDateTime scheduledDepartureTime, bool departureCanceled, int arrivalDelay, QDateTime scheduledArrivalTime, bool arrivalCanceled, bool arrived, bool left, IRail::Occupancy occupancy)
{
    this->setId(id);
    this->setStation(station);
    this->setArrivalPlatform(arrivalPlatform);
    this->setIsDefaultArrivalPlatform(isDefaultArrivalPlatform);
    this->setDeparturePlatform(departurePlatform);
    this->setIsDefaultDeparturePlatform(isDefaultDeparturePlatform);
    this->setDepartureDelay(departureDelay);
    this->setScheduledDepartureTime(scheduledDepartureTime);
    this->setDepartureCanceled(departureCanceled);
    this->setArrivalDelay(arrivalDelay);
    this->setScheduledArrivalTime(scheduledArrivalTime);
    this->setArrivalCanceled(arrivalCanceled);
    this->setArrived(arrived);
    this->setLeft(left);
    this->setOccupancy(occupancy);
}

StopVia::StopVia(int id, Station *station, QString arrivalPlatform, bool isDefaultArrivalPlatform, QString departurePlatform, bool isDefaultDeparturePlatform, int departureDelay, QDateTime scheduledDepartureTime, bool departureCanceled, int arrivalDelay, QDateTime scheduledArrivalTime, bool arrivalCanceled, bool arrived, bool left, IRail::Occupancy occupancy, bool isExtraStop, QString arrivalDirection, QString departureDirection, bool walking)
{
    this->setId(id);
    this->setStation(station);
    this->setArrivalPlatform(arrivalPlatform);
    this->setIsDefaultArrivalPlatform(isDefaultArrivalPlatform);
    this->setDeparturePlatform(departurePlatform);
    this->setIsDefaultDeparturePlatform(isDefaultDeparturePlatform);
    this->setDepartureDelay(departureDelay);
    this->setScheduledDepartureTime(scheduledDepartureTime);
    this->setDepartureCanceled(departureCanceled);
    this->setArrivalDelay(arrivalDelay);
    this->setScheduledArrivalTime(scheduledArrivalTime);
    this->setArrivalCanceled(arrivalCanceled);
    this->setArrived(arrived);
    this->setLeft(left);
    this->setOccupancy(occupancy);
    this->setIsExtraStop(isExtraStop);
    this->setArrivalDirection(arrivalDirection);
    this->setDepartureDirection(departureDirection);
    this->setWalking(walking);

    qDebug() << "Arrival platform:" << arrivalPlatform;
    qDebug() << "Departure platform:" << departurePlatform;
    qDebug() << "Arrival direction:" << arrivalDirection;
    qDebug() << "Departure direction:" << departureDirection;
}

QString StopVia::arrivalPlatform() const
{
    return m_arrivalPlatform;
}

void StopVia::setArrivalPlatform(const QString &arrivalPlatform)
{
    m_arrivalPlatform = arrivalPlatform;
}

bool StopVia::isDefaultArrivalPlatform() const
{
    return m_isDefaultArrivalPlatform;
}

void StopVia::setIsDefaultArrivalPlatform(bool isDefaultArrivalPlatform)
{
    m_isDefaultArrivalPlatform = isDefaultArrivalPlatform;
}

QString StopVia::departurePlatform() const
{
    return m_departurePlatform;
}

void StopVia::setDeparturePlatform(const QString &departurePlatform)
{
    m_departurePlatform = departurePlatform;
}

bool StopVia::isDefaultDeparturePlatform() const
{
    return m_isDefaultDeparturePlatform;
}

void StopVia::setIsDefaultDeparturePlatform(bool isDefaultDeparturePlatform)
{
    m_isDefaultDeparturePlatform = isDefaultDeparturePlatform;
}

QString StopVia::arrivalDirection() const
{
    return m_arrivalDirection;
}

void StopVia::setArrivalDirection(const QString &arrivalDirection)
{
    m_arrivalDirection = arrivalDirection;
}

QString StopVia::departureDirection() const
{
    return m_departureDirection;
}

void StopVia::setDepartureDirection(const QString &departureDirection)
{
    m_departureDirection = departureDirection;
}

bool StopVia::arrived() const
{
    return m_arrived;
}

void StopVia::setArrived(bool arrived)
{
    m_arrived = arrived;
}

bool StopVia::left() const
{
    return m_left;
}

void StopVia::setLeft(bool left)
{
    m_left = left;
}
