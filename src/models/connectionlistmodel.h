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
#ifndef CONNECTIONLISTMODEL_H
#define CONNECTIONLISTMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QList>

#include "connection.h"

class ConnectionListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        FromRole = Qt::UserRole + 2,
        ToRole = Qt::UserRole + 3,
        FromVehicleRole = Qt::UserRole + 4,
        ToVehicleRole = Qt::UserRole + 5,
        AlertsRole = Qt::UserRole + 6,
        RemarksRole = Qt::UserRole + 7,
        OccupancyRole = Qt::UserRole + 8,
        DurationRole = Qt::UserRole + 9,
        ViasRole = Qt::UserRole + 10,
        TimestampRole = Qt::UserRole + 11
    };

    explicit ConnectionListModel(QList<Connection *> connectionList);
    explicit ConnectionListModel();
    ~ConnectionListModel();

    virtual int rowCount(const QModelIndex&) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    QList<Connection *> connectionList() const;
    void setConnectionList(const QList<Connection *> &connectionList);

    Station *from() const;
    void setFrom(Station *from);
    Station *to() const;
    void setTo(Station *to);
    QDateTime time() const;
    void setTime(const QDateTime &time);
    IRail::Transport transportType() const;
    void setTransportType(const IRail::Transport &transportType);
    IRail::ArrDep arrdep() const;
    void setArrdep(const IRail::ArrDep &arrdep);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Connection *> m_connectionList;
    Station* m_from;
    Station* m_to;
    QDateTime m_time;
    IRail::Transport m_transportType;
    IRail::ArrDep m_arrdep;
};

#endif // CONNECTIONLISTMODEL_H
