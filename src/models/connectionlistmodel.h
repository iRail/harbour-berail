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
        AlertsRole = Qt::UserRole + 4,
        RemarksRole = Qt::UserRole + 5,
        OccupancyRole = Qt::UserRole + 6,
        DurationRole = Qt::UserRole + 7,
        ViasRole = Qt::UserRole + 8,
        TimestampRole = Qt::UserRole + 9
    };

    explicit ConnectionListModel(QList<Connection *> connectionList);
    explicit ConnectionListModel();

    virtual int rowCount(const QModelIndex&) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    QList<Connection *> connectionList() const;
    void setConnectionList(const QList<Connection *> &connectionList);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Connection *> m_connectionList;
};

#endif // CONNECTIONLISTMODEL_H
