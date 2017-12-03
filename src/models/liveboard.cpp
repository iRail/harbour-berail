#include "liveboard.h"


Liveboard::Liveboard(Station* station, QDateTime time, ArrDep arrdep, Disturbances* disturbances)
{
    setStation(station);
    setTime(time);
    setArrdep(arrdep);
    setDisturbances(disturbances);
}

Liveboard::Liveboard()
{

}

/*********************
 * Getters & Setters *
 *********************/

Station *Liveboard::station() const
{
    return m_station;
}

void Liveboard::setStation(Station *station)
{
    m_station = station;
}

QList<Vehicle *> Liveboard::vehicles() const
{
    return m_vehicles;
}

void Liveboard::setVehicles(const QList<Vehicle *> &vehicles)
{
    m_vehicles = vehicles;
}

QDateTime Liveboard::time() const
{
    return m_time;
}

void Liveboard::setTime(const QDateTime &time)
{
    m_time = time;
}

ArrDep Liveboard::arrdep() const
{
    return m_arrdep;
}

void Liveboard::setArrdep(const ArrDep &arrdep)
{
    m_arrdep = arrdep;
}

Disturbances *Liveboard::disturbances() const
{
    return m_disturbances;
}

void Liveboard::setDisturbances(Disturbances *disturbances)
{
    m_disturbances = disturbances;
}

QDateTime Liveboard::timestamp() const
{
    return m_timestamp;
}

void Liveboard::setTimestamp(const QDateTime &timestamp)
{
    m_timestamp = timestamp;
}
