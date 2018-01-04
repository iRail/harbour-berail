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

int AlertListModel::count() const
{
    return this->alertList().length();
}
