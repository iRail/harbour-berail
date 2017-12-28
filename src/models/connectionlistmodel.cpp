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
#include "connectionlistmodel.h"

ConnectionListModel::ConnectionListModel(QList<Connection *> connectionList)
{
    this->setConnectionList(connectionList);
}

int ConnectionListModel::rowCount(const QModelIndex &) const
{
    return this->connectionList().length();
}

QHash<int, QByteArray> ConnectionListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[FromRole] = "from";
    roles[ToRole] = "to";
    roles[FromVehicleRole] = "fromVehicleId";
    roles[ToVehicleRole] = "toVehicleId";
    roles[AlertsRole] = "alerts";
    roles[RemarksRole] = "remarks";
    roles[OccupancyRole] = "occupancy";
    roles[DurationRole] = "duration";
    roles[ViasRole] = "vias";
    roles[TimestampRole] = "timestamp";
    return roles;
}

QVariant ConnectionListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) {
        return QVariant();
    }
    // Break not needed since return makes the rest unreachable.
    switch(role) {
    case IdRole:
        return QVariant(this->connectionList().at(index.row())->id());
    case FromRole:
        return QVariant(QVariant::fromValue(this->connectionList().at(index.row())->from()));
    case ToRole:
        return QVariant(QVariant::fromValue(this->connectionList().at(index.row())->to()));
    case FromVehicleRole:
        return QVariant(this->connectionList().at(index.row())->fromVehicleId());
    case ToVehicleRole:
        return QVariant(this->connectionList().at(index.row())->toVehicleId());
    case AlertsRole:
        return QVariant(QVariant::fromValue(this->connectionList().at(index.row())->alerts()));
    case RemarksRole:
        return QVariant(QVariant::fromValue(this->connectionList().at(index.row())->remarks()));
    case OccupancyRole:
        return QVariant(QVariant::fromValue(this->connectionList().at(index.row())->occupancy()));
    case DurationRole:
        return QVariant(this->connectionList().at(index.row())->duration());
    case ViasRole:
        return QVariant(QVariant::fromValue(this->connectionList().at(index.row())->vias()));
    case TimestampRole:
        return QVariant(this->connectionList().at(index.row())->timestamp());
    default:
        return QVariant();
    }
}

QList<Connection *> ConnectionListModel::connectionList() const
{
    return m_connectionList;
}

void ConnectionListModel::setConnectionList(const QList<Connection *> &connectionList)
{
    m_connectionList = connectionList;
}


