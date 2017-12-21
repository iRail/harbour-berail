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
        LinkRole = Qt::UserRole + 5
    };

    explicit AlertListModel(QList<Alert *> alertList);
    explicit AlertListModel();

    virtual int rowCount(const QModelIndex&) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    QList<Alert *> alertList() const;
    void setAlertList(const QList<Alert *> &alertList);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Alert *> m_alertList;
};

#endif // ALERTLISTMODEL_H
