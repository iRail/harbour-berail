#include "stop.h"

Stop::Stop(int id, Station *station, QString platform, bool isDefaultPlatform, int departureDelay, QDateTime scheduledDepartureTime, bool departureCanceled, int arrivalDelay, QDateTime scheduledArrivalTime, bool arrivalCanceled, bool left, Occupancy occupancy)
{
    setId(id);
    setStation(station);
    setPlatform(platform);
    setIsDefaultPlatform(isDefaultPlatform);
    setDepartureDelay(departureDelay);
    setScheduledDepartureTime(scheduledDepartureTime);
    setDepartureCanceled(departureCanceled);
    setArrivalDelay(arrivalDelay);
    setScheduledArrivalTime(scheduledArrivalTime);
    setArrivalCanceled(arrivalCanceled);
    setLeft(left);
    setOccupancy(occupancy);
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
}

Station *Stop::station() const
{
    return m_station;
}

void Stop::setStation(Station *station)
{
    m_station = station;
}

QString Stop::platform() const
{
    return m_platform;
}

void Stop::setPlatform(const QString &platform)
{
    m_platform = platform;
}

bool Stop::isDefaultPlatform() const
{
    return m_isDefaultPlatform;
}

void Stop::setIsDefaultPlatform(bool isDefaultPlatform)
{
    m_isDefaultPlatform = isDefaultPlatform;
}

int Stop::departureDelay() const
{
    return m_departureDelay;
}

void Stop::setDepartureDelay(int departureDelay)
{
    m_departureDelay = departureDelay;
}

QDateTime Stop::scheduledDepartureTime() const
{
    return m_scheduledDepartureTime;
}

void Stop::setScheduledDepartureTime(const QDateTime &scheduledDepartureTime)
{
    m_scheduledDepartureTime = scheduledDepartureTime;
}

bool Stop::departureCanceled() const
{
    return m_departureCanceled;
}

void Stop::setDepartureCanceled(bool departureCanceled)
{
    m_departureCanceled = departureCanceled;
}

int Stop::arrivalDelay() const
{
    return m_arrivalDelay;
}

void Stop::setArrivalDelay(int arrivalDelay)
{
    m_arrivalDelay = arrivalDelay;
}

QDateTime Stop::scheduledArrivalTime() const
{
    return m_scheduledArrivalTime;
}

void Stop::setScheduledArrivalTime(const QDateTime &scheduledArrivalTime)
{
    m_scheduledArrivalTime = scheduledArrivalTime;
}

bool Stop::arrivalCanceled() const
{
    return m_arrivalCanceled;
}

void Stop::setArrivalCanceled(bool arrivalCanceled)
{
    m_arrivalCanceled = arrivalCanceled;
}

bool Stop::left() const
{
    return m_left;
}

void Stop::setLeft(bool left)
{
    m_left = left;
}

Occupancy Stop::occupancy() const
{
    return m_occupancy;
}

void Stop::setOccupancy(const Occupancy &occupancy)
{
    m_occupancy = occupancy;
}
