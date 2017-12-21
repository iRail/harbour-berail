#ifndef DISTURBANCES_H
#define DISTURBANCES_H

#include <QtCore/QObject>
#include <QtCore/QList>
#include <QtCore/QDateTime>

#include "alert.h"
#include "alertlistmodel.h"

class Disturbances: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<Alert*> alerts READ alerts WRITE setAlerts NOTIFY alertsChanged)
    Q_PROPERTY(QDateTime timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)
    Q_PROPERTY(AlertListModel* alertsistModel READ alertListModel WRITE setAlertListModel NOTIFY alertListModelChanged)

public:
    explicit Disturbances(QList<Alert*> alerts, QDateTime timestamp);
    explicit Disturbances();
    virtual ~Disturbances();
    QList<Alert*> alerts() const;
    void setAlerts(const QList<Alert*> &alerts);
    QDateTime timestamp() const;
    void setTimestamp(const QDateTime &timestamp);
    AlertListModel *alertListModel() const;
    void setAlertListModel(AlertListModel *alertListModel);

signals:
    void alertsChanged();
    void timestampChanged();
    void alertListModelChanged();

private:
    QList<Alert*> m_alerts;
    QDateTime m_timestamp;
    AlertListModel* m_alertListModel;
};

#endif // DISTURBANCES_H
