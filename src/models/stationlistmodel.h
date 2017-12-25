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
#ifndef STATIONLISTMODEL_H
#define STATIONLISTMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QList>

#include "station.h"

class StationListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole = Qt::UserRole + 2,
        LocationRole = Qt::UserRole + 3
    };

    explicit StationListModel(QList<Station *> stationList);
    explicit StationListModel();

    virtual int rowCount(const QModelIndex&) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    QList<Station *> stationList() const;
    void setStationList(const QList<Station *> &stationList);

signals:
    void stationListFilterChanged();

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Station *> m_stationList;
};

#endif // STATIONLISTMODEL_H
