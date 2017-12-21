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


