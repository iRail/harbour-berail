#include "stationlistmodel.h"

StationListModel::StationListModel(QList<Station *> stationList)
{
    this->setStationList(stationList);
}

QHash<int, QByteArray> StationListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[LocationRole] = "location";
    return roles;
}

int StationListModel::rowCount(const QModelIndex &) const
{
    return this->stationList().length();
}

QVariant StationListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) {
        return QVariant();
    }
    // Break not needed since return makes the rest unreachable.
    switch(role) {
    case IdRole:
        return QVariant(this->stationList().at(index.row())->id());
    case NameRole:
        return QVariant(this->stationList().at(index.row())->name());
    case LocationRole:
        return QVariant(QVariant::fromValue(this->stationList().at(index.row())->location()));
    default:
        return QVariant();
    }
}

/*********************
 * Getters & Setters *
 *********************/

QList<Station *> StationListModel::stationList() const
{
    return m_stationList;
}

void StationListModel::setStationList(const QList<Station *> &stationList)
{
    m_stationList = stationList;
}


