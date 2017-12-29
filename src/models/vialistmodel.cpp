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

QHash<int, QByteArray> ViaListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[ArrivalRole] = "arrival";
    roles[DepartureRole] = "departure";
    roles[StationRole] = "station";
    roles[TimeBetweenRole] = "timeBetween";
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
    case ArrivalRole:
        return QVariant(QVariant::fromValue(this->viaList().at(index.row())->arrival()));
    case DepartureRole:
        return QVariant(QVariant::fromValue(this->viaList().at(index.row())->departure()));
    case StationRole:
        return QVariant(QVariant::fromValue(this->viaList().at(index.row())->station()));
    case TimeBetweenRole:
        return QVariant(this->viaList().at(index.row())->timeBetween());
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
