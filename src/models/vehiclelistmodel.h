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
#ifndef VEHICLELISTMODEL_H
#define VEHICLELISTMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QList>

#include "vehicle.h"
#include "disturbances.h"
#include "enum.h"

class VehicleListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        DateRole = Qt::UserRole + 2,
        StopsRole = Qt::UserRole + 3,
        LiveboardRole = Qt::UserRole + 4,
        HasDelayRole = Qt::UserRole + 5,
        LocationRole = Qt::UserRole + 6,
        CanceledRole = Qt::UserRole + 7,
        OccupancyRole = Qt::UserRole + 8,
        DisturbancesRole = Qt::UserRole + 9,
        TimestampRole = Qt::UserRole + 10
    };
    explicit VehicleListModel();
    explicit VehicleListModel(QList<Vehicle*> vehicleList);

    virtual int rowCount(const QModelIndex&) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    QList<Vehicle *> vehicleList() const;
    void setVehicleList(const QList<Vehicle *> &vehicleList);
    bool hasDelay() const;
    void setHasDelay(bool hasDelay);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Vehicle*> m_vehicleList;
    bool m_hasDelay;
};

#endif // VEHICLELISTMODEL_H
