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
