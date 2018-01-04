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
#ifndef LIVEBOARD_H
#define LIVEBOARD_H

#include <QtCore/QObject>
#include <QtCore/QDateTime>
#include <QtCore/QList>

#include "station.h"
#include "vehicle.h"
#include "disturbances.h"
#include "enum.h"
#include "alertlistmodel.h"
#include "vehiclelistmodel.h"

class Liveboard: public QObject
{
    Q_OBJECT
    Q_PROPERTY(Station* station READ station WRITE setStation NOTIFY stationChanged)
    Q_PROPERTY(QList<Vehicle*> vehicles READ vehicles WRITE setVehicles NOTIFY vehiclesChanged)
    Q_PROPERTY(IRail::ArrDep arrdep READ arrdep WRITE setArrdep NOTIFY arrdepChanged)
    Q_PROPERTY(Disturbances* disturbances READ disturbances WRITE setDisturbances NOTIFY disturbancesChanged)
    Q_PROPERTY(QDateTime timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)
    Q_PROPERTY(AlertListModel* alertListModel READ alertListModel WRITE setAlertListModel NOTIFY alertListModelChanged)
    Q_PROPERTY(VehicleListModel* vehicleListModel READ vehicleListModel WRITE setVehicleListModel NOTIFY vehicleListModelChanged)

public:
    explicit Liveboard(Station* station, QList<Vehicle*> vehicles, QDateTime time, IRail::ArrDep arrdep, Disturbances* disturbances);
    explicit Liveboard();
    ~Liveboard();

    Station *station() const;
    void setStation(Station *station);
    QList<Vehicle*> vehicles() const;
    void setVehicles(const QList<Vehicle*> &vehicles);
    IRail::ArrDep arrdep() const;
    void setArrdep(const IRail::ArrDep &arrdep);
    Disturbances *disturbances() const;
    void setDisturbances(Disturbances *disturbances);
    QDateTime timestamp() const;
    void setTimestamp(const QDateTime &timestamp);
    AlertListModel *alertListModel() const;
    void setAlertListModel(AlertListModel *alertListModel);
    VehicleListModel *vehicleListModel() const;
    void setVehicleListModel(VehicleListModel *vehicleListModel);

signals:
    void stationChanged();
    void vehiclesChanged();
    void arrdepChanged();
    void disturbancesChanged();
    void timestampChanged();
    void alertListModelChanged();
    void vehicleListModelChanged();

private:
    Station* m_station;
    QList<Vehicle*> m_vehicles;
    IRail::ArrDep m_arrdep;
    Disturbances* m_disturbances;
    QDateTime m_timestamp;
    AlertListModel* m_alertListModel;
    VehicleListModel* m_vehicleListModel;
};

#endif // LIVEBOARD_H
