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
    roles[IdRole] = "id";
    roles[StationRole] = "station";

    roles[PlatformRole] = "platform";
    roles[IsDefaultPlatformRole] = "isDefaultPlatform";
    roles[DepartureDelayRole] = "departureDelay";
    roles[ScheduledDepartureTimeRole] = "scheduledDepartureTime";
    roles[DepartureCanceledRole] = "departureCanceled";
    roles[ArrivalDelayRole] = "arrivalDelay";
    roles[ScheduledArrivalTimeRole] = "scheduledArrivalTime";
    roles[ArrivalCanceledRole] = "arrivalCanceled";
    roles[LeftRole] = "left";
    roles[OccupancyRole] = "occupancy";
    roles[IsExtraStopRole] = "isExtraStop";
    roles[DirectionRole] = "direction";
    roles[WalkingRole] = "walking";
    return roles;
}

QVariant StopListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) {
        return QVariant();
    }

    // Break not needed since return makes the rest unreachable.
    switch(role) {
    case IdRole:
        return QVariant(this->stopList().at(index.row())->id());
    case StationRole:
        return QVariant::fromValue(this->stopList().at(index.row())->station());
    case PlatformRole:
        return QVariant(this->stopList().at(index.row())->platform());
    case IsDefaultPlatformRole:
        return QVariant(this->stopList().at(index.row())->isDefaultPlatform());
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
    case LeftRole:
        return QVariant(this->stopList().at(index.row())->left());
    case OccupancyRole:
        return QVariant(QVariant::fromValue(this->stopList().at(index.row())->occupancy()));
    case IsExtraStopRole:
        return QVariant(this->stopList().at(index.row())->isExtraStop());
    case DirectionRole:
        return QVariant(this->stopList().at(index.row())->direction());
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


