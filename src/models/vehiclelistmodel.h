#ifndef VEHICLELISTMODEL_H
#define VEHICLELISTMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QList>

#include "vehicle.h"
#include "disturbances.h"
#include "enum.h"

class VehicleListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        DateRole = Qt::UserRole + 2,
        StopsRole = Qt::UserRole + 3,
        LocationRole = Qt::UserRole + 4,
        CanceledRole = Qt::UserRole + 5,
        OccupancyRole = Qt::UserRole + 6,
        DisturbancesRole = Qt::UserRole + 7,
        TimestampRole = Qt::UserRole + 8
    };
    explicit VehicleListModel();
    explicit VehicleListModel(QList<Vehicle*> vehicleList);

    virtual int rowCount(const QModelIndex&) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    QList<Vehicle *> vehicleList() const;
    void setVehicleList(const QList<Vehicle *> &vehicleList);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Vehicle*> m_vehicleList;
};

#endif // VEHICLELISTMODEL_H
