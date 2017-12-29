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
#ifndef ALERTLISTMODEL_H
#define ALERTLISTMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QList>

#include "alert.h"

class AlertListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        TitleRole = Qt::UserRole + 2,
        TextRole = Qt::UserRole + 3,
        TimestampRole = Qt::UserRole + 4,
        LinkRole = Qt::UserRole + 5,
        HasLinkRole = Qt::UserRole + 6
    };

    explicit AlertListModel(QList<Alert *> alertList);
    explicit AlertListModel();

    virtual int rowCount(const QModelIndex&) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    QList<Alert *> alertList() const;
    void setAlertList(const QList<Alert *> &alertList);

    Q_INVOKABLE int count() const;

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Alert *> m_alertList;
};

#endif // ALERTLISTMODEL_H
