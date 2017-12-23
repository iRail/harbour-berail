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
#ifndef STOPLISTMODEL_H
#define STOPLISTMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QList>

#include "stop.h"
#include "station.h"

class StopListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        StationRole = Qt::UserRole + 2,
        PlatformRole = Qt::UserRole + 3,
        IsDefaultPlatformRole = Qt::UserRole + 4,
        DepartureDelayRole = Qt::UserRole + 5,
        ScheduledDepartureTimeRole = Qt::UserRole + 6,
        DepartureCanceledRole = Qt::UserRole + 7,
        ArrivalDelayRole = Qt::UserRole + 8,
        ScheduledArrivalTimeRole = Qt::UserRole + 9,
        ArrivalCanceledRole = Qt::UserRole + 10,
        LeftRole = Qt::UserRole + 11,
        OccupancyRole = Qt::UserRole + 12,
        IsExtraStopRole = Qt::UserRole + 13,
        DirectionRole = Qt::UserRole + 14,
        WalkingRole = Qt::UserRole + 15
    };

    explicit StopListModel(QList<Stop *> stopList);
    explicit StopListModel();

    virtual int rowCount(const QModelIndex&) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    QList<Stop *> stopList() const;
    void setStopList(const QList<Stop *> &stopList);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Stop*> m_stopList;
};
#endif // STOPLISTMODEL_H
