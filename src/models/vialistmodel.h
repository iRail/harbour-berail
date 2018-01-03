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
#ifndef VIALISTMODEL_H
#define VIALISTMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QList>

#include "via.h"

class ViaListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        ArrivalRole = Qt::UserRole + 2,
        DepartureRole = Qt::UserRole + 3,
        StationRole = Qt::UserRole + 4,
        TimeBetweenRole = Qt::UserRole + 5,
        VehicleIdRole = Qt::UserRole + 6,
        DisturbancesRole = Qt::UserRole + 7
    };

    explicit ViaListModel(QList<Via *> alertList);
    explicit ViaListModel();
    ~ViaListModel();

    virtual int rowCount(const QModelIndex&) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    QList<Via *> viaList() const;
    void setViaList(const QList<Via *> &viaList);
    Q_INVOKABLE int count() const;

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Via *> m_viaList;
};

#endif // VIALISTMODEL_H
