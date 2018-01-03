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
#include "stoplistmodel.h"

StopListModel::StopListModel(QList<Stop *> stopList)
{
    this->setStopList(stopList);
}

int StopListModel::rowCount(const QModelIndex &) const
{
    return this->stopList().length();
}

QHash<int, QByteArray> StopListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[PlatformRole] = "platform";
    roles[IsDefaultPlatformRole] = "isDefaultPlatform";
    roles[LeftRole] = "left";
    return roles;
}

QVariant StopListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) {
        return QVariant();
    }

    // Break not needed since return makes the rest unreachable.
    switch(role) {
    case PlatformRole:
        return QVariant(this->stopList().at(index.row())->platform());
    case IsDefaultPlatformRole:
        return QVariant(this->stopList().at(index.row())->isDefaultPlatform());
    case LeftRole:
        return QVariant(this->stopList().at(index.row())->left());
    case IdRole:
        return QVariant(this->stopList().at(index.row())->id());
    case StationRole:
        return QVariant::fromValue(this->stopList().at(index.row())->station());
    case DepartureDelayRole:
        return QVariant(this->stopList().at(index.row())->departureDelay());
    case ScheduledDepartureTimeRole:
        return QVariant(this->stopList().at(index.row())->scheduledDepartureTime());
    case DepartureCanceledRole:
        return QVariant(this->stopList().at(index.row())->departureCanceled());
    case ArrivalDelayRole:
        return QVariant(this->stopList().at(index.row())->arrivalDelay());
    case ScheduledArrivalTimeRole:
        return QVariant(this->stopList().at(index.row())->scheduledArrivalTime());
    case ArrivalCanceledRole:
        return QVariant(this->stopList().at(index.row())->arrivalCanceled());
    case OccupancyRole:
        return QVariant(QVariant::fromValue(this->stopList().at(index.row())->occupancy()));
    case IsExtraStopRole:
        return QVariant(this->stopList().at(index.row())->isExtraStop());
    case WalkingRole:
        return QVariant(this->stopList().at(index.row())->walking());
    default:
        return QVariant();
    }
}

/*********************
 * Getters & Setters *
 *********************/

QList<Stop *> StopListModel::stopList() const
{
    return m_stopList;
}

void StopListModel::setStopList(const QList<Stop *> &stopList)
{
    m_stopList = stopList;
}


