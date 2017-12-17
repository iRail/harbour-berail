#include "stop.h"

Stop::Stop(int id, Station *station, QString platform, bool isDefaultPlatform, int departureDelay, QDateTime scheduledDepartureTime, bool departureCanceled, int arrivalDelay, QDateTime scheduledArrivalTime, bool arrivalCanceled, bool left, Occupancy occupancy)
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

    // Autogenerate other fields if not specified
    // Second constructor might be needed: 1 without direction, 1 with direction, 1 with extraStop, 1 without
}

Stop::Stop(int id, Station *station, QString platform, bool isDefaultPlatform, int departureDelay, QDateTime scheduledDepartureTime, bool departureCanceled, int arrivalDelay, QDateTime scheduledArrivalTime, bool arrivalCanceled, bool left, Occupancy occupancy, bool isExtraStop, QString direction, bool walking)
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

int Stop::id() const
{
    return m_id;
}

void Stop::setId(int id)
{
    m_id = id;
    emit this->idChanged();
}

Station *Stop::station() const
{
    return m_station;
}

void Stop::setStation(Station *station)
{
    m_station = station;
    emit this->stationChanged();
}

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

int Stop::departureDelay() const
{
    return m_departureDelay;
}

void Stop::setDepartureDelay(int departureDelay)
{
    m_departureDelay = departureDelay;
    emit this->departureDelayChanged();
}

QDateTime Stop::scheduledDepartureTime() const
{
    return m_scheduledDepartureTime;
}

void Stop::setScheduledDepartureTime(const QDateTime &scheduledDepartureTime)
{
    m_scheduledDepartureTime = scheduledDepartureTime;
    emit this->scheduledDepartureTimeChanged();
}

bool Stop::departureCanceled() const
{
    return m_departureCanceled;
}

void Stop::setDepartureCanceled(bool departureCanceled)
{
    m_departureCanceled = departureCanceled;
    emit this->departureCanceledChanged();
}

int Stop::arrivalDelay() const
{
    return m_arrivalDelay;
}

void Stop::setArrivalDelay(int arrivalDelay)
{
    m_arrivalDelay = arrivalDelay;
    emit this->arrivalDelayChanged();
}

QDateTime Stop::scheduledArrivalTime() const
{
    return m_scheduledArrivalTime;
}

void Stop::setScheduledArrivalTime(const QDateTime &scheduledArrivalTime)
{
    m_scheduledArrivalTime = scheduledArrivalTime;
    emit this->scheduledArrivalTimeChanged();
}

bool Stop::arrivalCanceled() const
{
    return m_arrivalCanceled;
}

void Stop::setArrivalCanceled(bool arrivalCanceled)
{
    m_arrivalCanceled = arrivalCanceled;
    emit this->arrivalCanceledChanged();
}

bool Stop::left() const
{
    return m_left;
}

void Stop::setLeft(bool left)
{
    m_left = left;
    emit this->leftChanged();
}

Occupancy Stop::occupancy() const
{
    return m_occupancy;
}

void Stop::setOccupancy(const Occupancy &occupancy)
{
    m_occupancy = occupancy;
    emit this->occupancyChanged();
}

bool Stop::isExtraStop() const
{
    return m_isExtraStop;
}

void Stop::setIsExtraStop(bool isExtraStop)
{
    m_isExtraStop = isExtraStop;
    emit this->isExtraStopChanged();
}

QString Stop::direction() const
{
    return m_direction;
}

void Stop::setDirection(const QString &direction)
{
    m_direction = direction;
    emit this->directionChanged();
}

bool Stop::walking() const
{
    return m_walking;
}

void Stop::setWalking(bool walking)
{
    m_walking = walking;
    emit this->walkingChanged();
}
