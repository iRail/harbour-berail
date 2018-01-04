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
#include <QtGlobal>
#include <QDebug>

Stop::Stop(int id, Station *station, QString platform, bool isDefaultPlatform, int departureDelay, QDateTime scheduledDepartureTime, bool departureCanceled, int arrivalDelay, QDateTime scheduledArrivalTime, bool arrivalCanceled, bool left, IRail::Occupancy occupancy, bool isExtraStop)
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
    QDateTime realArrivalTime(scheduledArrivalTime);
    realArrivalTime = realArrivalTime.addSecs((qint64)(arrivalDelay));
    QDateTime realDepartureTime(scheduledDepartureTime);
    realDepartureTime = realDepartureTime.addSecs((qint64)(departureDelay));
    this->setRealArrivalTime(realArrivalTime);
    this->setRealDepartureTime(realDepartureTime);
}

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
    QDateTime realArrivalTime = scheduledArrivalTime;
    realArrivalTime.addSecs(arrivalDelay);
    this->setRealArrivalTime(realArrivalTime);
    QDateTime realDepartureTime = scheduledDepartureTime;
    realDepartureTime.addSecs(departureDelay);
    this->setRealDepartureTime(realDepartureTime);
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
    QDateTime realArrivalTime = scheduledArrivalTime;
    realArrivalTime.addSecs(arrivalDelay);
    this->setRealArrivalTime(realArrivalTime);
    QDateTime realDepartureTime = scheduledDepartureTime;
    realDepartureTime.addSecs(departureDelay);
    this->setRealDepartureTime(realDepartureTime);
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

QDateTime Stop::realArrivalTime() const
{
    return m_realArrivalTime;
}

void Stop::setRealArrivalTime(const QDateTime &realArrivalTime)
{
    m_realArrivalTime = realArrivalTime;
}

QDateTime Stop::realDepartureTime() const
{
    return m_realDepartureTime;
}

void Stop::setRealDepartureTime(const QDateTime &realDepartureTime)
{
    m_realDepartureTime = realDepartureTime;
}
