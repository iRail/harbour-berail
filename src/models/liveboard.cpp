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
#include "liveboard.h"

Liveboard::Liveboard(Station* station, QList<Vehicle*> vehicles, QDateTime time, IRail::ArrDep arrdep, Disturbances* disturbances)
{
    this->setStation(station);
    this->setVehicles(vehicles);
    this->setArrdep(arrdep);
    this->setDisturbances(disturbances);
    this->setTimestamp(time);
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
    emit this->stationChanged();
}

QList<Vehicle *> Liveboard::vehicles() const
{
    return m_vehicles;
}

void Liveboard::setVehicles(const QList<Vehicle *> &vehicles)
{
    m_vehicles = vehicles;
    this->setVehicleListModel(new VehicleListModel(vehicles));
    emit this->vehiclesChanged();
}

IRail::ArrDep Liveboard::arrdep() const
{
    return m_arrdep;
}

void Liveboard::setArrdep(const IRail::ArrDep &arrdep)
{
    m_arrdep = arrdep;
    emit this->arrdepChanged();
}

Disturbances *Liveboard::disturbances() const
{
    return m_disturbances;
}

void Liveboard::setDisturbances(Disturbances *disturbances)
{
    m_disturbances = disturbances;
    this->setAlertListModel(new AlertListModel(disturbances->alerts()));
    emit this->disturbancesChanged();
}

QDateTime Liveboard::timestamp() const
{
    return m_timestamp;
}

void Liveboard::setTimestamp(const QDateTime &timestamp)
{
    m_timestamp = timestamp;
    emit this->timestampChanged();
}

AlertListModel *Liveboard::alertListModel() const
{
    return m_alertListModel;
}

void Liveboard::setAlertListModel(AlertListModel *alertListModel)
{
    m_alertListModel = alertListModel;
}

VehicleListModel *Liveboard::vehicleListModel() const
{
    return m_vehicleListModel;
}

void Liveboard::setVehicleListModel(VehicleListModel *vehicleListModel)
{
    m_vehicleListModel = vehicleListModel;
}


