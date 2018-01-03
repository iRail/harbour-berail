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
#include "vialistmodel.h"

ViaListModel::ViaListModel(QList<Via *> viaList)
{
    this->setViaList(viaList);
}

ViaListModel::~ViaListModel()
{
    if(!this->viaList().isEmpty()) {
        foreach(Via* item, this->viaList()) {
            item->deleteLater();
        }
    }
}

QHash<int, QByteArray> ViaListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[StopRole] = "stop";
    roles[StationRole] = "station";
    roles[ArrivalTimeRole] = "arrivalTime";
    roles[LeftTimeRole] = "leftTime";
    roles[TimeBetweenRole] = "timeBetween";
    roles[WillMissViaRole] = "willMissVia";
    roles[VehicleIdRole] = "vehicleId";
    roles[DisturbancesRole] = "disturbances";
    return roles;
}

int ViaListModel::rowCount(const QModelIndex &) const
{
    return this->viaList().length();
}

QVariant ViaListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) {
        return QVariant();
    }
    // Break not needed since return makes the rest unreachable.
    switch(role) {
    case IdRole:
        return QVariant(this->viaList().at(index.row())->id());
    case StopRole:
        return QVariant(QVariant::fromValue(this->viaList().at(index.row())->stop()));
    case StationRole:
        return QVariant(QVariant::fromValue(this->viaList().at(index.row())->stop()->station()));
    case ArrivalTimeRole:
        return QVariant(this->viaList().at(index.row())->arrivalTime());
    case LeftTimeRole:
        return QVariant(this->viaList().at(index.row())->leftTime());
    case TimeBetweenRole:
        return QVariant(this->viaList().at(index.row())->timeBetween());
    case WillMissViaRole:
        return QVariant(this->viaList().at(index.row())->willMissVia());
    case VehicleIdRole:
        return QVariant(this->viaList().at(index.row())->vehicleId());
    case DisturbancesRole:
        return QVariant(QVariant::fromValue(this->viaList().at(index.row())->disturbances()));
    default:
        return QVariant();
    }
}

/*********************
 * Getters & Setters *
 *********************/

QList<Via *> ViaListModel::viaList() const
{
    return m_viaList;
}

void ViaListModel::setViaList(const QList<Via *> &viaList)
{
    m_viaList = viaList;
}

int ViaListModel::count() const
{
    return this->viaList().length();
}
