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

#include "stop.h"

Stop::Stop(int id, Station *station, QString platform, bool isDefaultPlatform, int departureDelay, QDateTime scheduledDepartureTime, bool departureCanceled, int arrivalDelay, QDateTime scheduledArrivalTime, bool arrivalCanceled, bool left, IRail::Occupancy occupancy)
{
    this->setId(id);
    this->setStation(station);
    this->setPlatform(platform);
    this->setIsDefaultPlatform(isDefaultPlatform);
    this->setDepartureDelay(departureDelay);
    this->setScheduledDepartureTime(scheduledDepartureTime);
    this->setDepartureCanceled(departureCanceled);
    this->setArrivalDelay(arrivalDelay);
    this->setScheduledArrivalTime(scheduledArrivalTime);
    this->setArrivalCanceled(arrivalCanceled);
    this->setLeft(left);
    this->setOccupancy(occupancy);
}

Stop::Stop(int id, Station *station, QString platform, bool isDefaultPlatform, int departureDelay, QDateTime scheduledDepartureTime, bool departureCanceled, int arrivalDelay, QDateTime scheduledArrivalTime, bool arrivalCanceled, bool left, IRail::Occupancy occupancy, bool isExtraStop, QString direction, bool walking)
{
    this->setId(id);
    this->setStation(station);
    this->setPlatform(platform);
    this->setIsDefaultPlatform(isDefaultPlatform);
    this->setDepartureDelay(departureDelay);
    this->setScheduledDepartureTime(scheduledDepartureTime);
    this->setDepartureCanceled(departureCanceled);
    this->setArrivalDelay(arrivalDelay);
    this->setScheduledArrivalTime(scheduledArrivalTime);
    this->setArrivalCanceled(arrivalCanceled);
    this->setLeft(left);
    this->setOccupancy(occupancy);
    this->setIsExtraStop(isExtraStop);
    this->setDirection(direction);
    this->setWalking(walking);
}

/*********************
 * Getters & Setters *
 *********************/

QString Stop::platform() const
{
    return m_platform;
}

void Stop::setPlatform(const QString &platform)
{
    m_platform = platform;
    emit this->platformChanged();
}

bool Stop::isDefaultPlatform() const
{
    return m_isDefaultPlatform;
}

void Stop::setIsDefaultPlatform(bool isDefaultPlatform)
{
    m_isDefaultPlatform = isDefaultPlatform;
    emit this->isDefaultPlatformChanged();
}

bool Stop::left() const
{
    return m_left;
}

void Stop::setLeft(bool left)
{
    m_left = left;
}
