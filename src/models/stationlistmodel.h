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

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Station *> m_stationList;
};

#endif // STATIONLISTMODEL_H
