#include "vehiclelistmodel.h"

VehicleListModel::VehicleListModel()
{

}

VehicleListModel::VehicleListModel(QList<Vehicle *> vehicleList)
{
    this->setVehicleList(vehicleList);
}

QHash<int, QByteArray> VehicleListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[DateRole] = "date";
    roles[StopsRole] = "stops";
    roles[LocationRole] = "location";
    roles[CanceledRole] = "canceled";
    roles[OccupancyRole] = "occupancy";
    roles[DisturbancesRole] = "disturbances";
    roles[TimestampRole] = "timestamp";
    return roles;
}

int VehicleListModel::rowCount(const QModelIndex &) const
{
    return this->vehicleList().length();
}

QVariant VehicleListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) {
        return QVariant();
    }
    // Break not needed since return makes the rest unreachable.
    switch(role) {
    case IdRole:
        return QVariant(this->vehicleList().at(index.row())->id());
    case DateRole:
        return QVariant(this->vehicleList().at(index.row())->date());
    case StopsRole:
        return QVariant(QVariant::fromValue(this->vehicleList().at(index.row())->stopListModel()));
    case LocationRole:
        return QVariant(QVariant::fromValue(this->vehicleList().at(index.row())->location()));
    case CanceledRole:
        return QVariant(this->vehicleList().at(index.row())->canceled());
    case OccupancyRole:
        return QVariant(QVariant::fromValue(this->vehicleList().at(index.row())->occupancy()));
    case DisturbancesRole:
        return QVariant(QVariant::fromValue(this->vehicleList().at(index.row())->disturbances()));
    case TimestampRole:
        return QVariant(this->vehicleList().at(index.row())->timestamp());
    default:
        return QVariant();
    }
}

/*********************
 * Getters & Setters *
 *********************/

QList<Vehicle *> VehicleListModel::vehicleList() const
{
    return m_vehicleList;
}

void VehicleListModel::setVehicleList(const QList<Vehicle *> &vehicleList)
{
    m_vehicleList = vehicleList;
}
