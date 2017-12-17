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

