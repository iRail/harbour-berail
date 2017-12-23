#include "alertlistmodel.h"

AlertListModel::AlertListModel(QList<Alert*> alertList)
{
    this->setAlertList(alertList);
}

int AlertListModel::rowCount(const QModelIndex &) const
{
    return this->alertList().length();
}

QHash<int, QByteArray> AlertListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[TitleRole] = "title";
    roles[TextRole] = "text";
    roles[TimestampRole] = "timestamp";
    roles[LinkRole] = "link";
    roles[HasLinkRole] = "hasLink";
    return roles;
}

QVariant AlertListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) {
        return QVariant();
    }
    // Break not needed since return makes the rest unreachable.
    switch(role) {
    case IdRole:
        return QVariant(this->alertList().at(index.row())->id());
    case TitleRole:
        return QVariant(this->alertList().at(index.row())->title());
    case TextRole:
        return QVariant(this->alertList().at(index.row())->text());
    case TimestampRole:
        return QVariant(this->alertList().at(index.row())->timestamp());
    case LinkRole:
        return QVariant(this->alertList().at(index.row())->link());
    case HasLinkRole:
        return QVariant(this->alertList().at(index.row())->hasLink());
    default:
        return QVariant();
    }
}

/*********************
 * Getters & Setters *
 *********************/

QList<Alert *> AlertListModel::alertList() const
{
    return m_alertList;
}

void AlertListModel::setAlertList(const QList<Alert *> &alertList)
{
    m_alertList = alertList;
}
