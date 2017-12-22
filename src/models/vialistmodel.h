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

    virtual int rowCount(const QModelIndex&) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    QList<Via *> viaList() const;
    void setViaList(const QList<Via *> &viaList);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Via *> m_viaList;
};

#endif // VIALISTMODEL_H
