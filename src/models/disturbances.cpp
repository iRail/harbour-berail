#include "disturbances.h"

/**
 * @class Disturbances
 * @brief Disturbances empty contructor
 */
Disturbances::Disturbances()
{

}

/**
 * @class Disturbances
 * @brief Disturbances constructor
 * @param alerts
 * @param timestamp
 */
Disturbances::Disturbances(QList<Alert*> alerts, QDateTime timestamp)
{
    this->setAlerts(alerts);
    this->setTimestamp(timestamp);
}

/**
 * @class Disturbances
 * @brief Disturbances destructor.
 * @details Marks all the allocated Alerts in the QList for deletion before it deletes itself.
 */
Disturbances::~Disturbances()
{
    if(!alerts().isEmpty()) {
        foreach(Alert* item, alerts()) {
            item->deleteLater();
        }
    }
}

/*********************
 * Getters & Setters *
 *********************/

QList<Alert*> Disturbances::alerts() const
{
    return m_alerts;
}

void Disturbances::setAlerts(const QList<Alert*> &alerts)
{
    m_alerts = alerts;
    this->setAlertListModel(new AlertListModel(alerts)); // connect QList<Alerts *> to AlertsListModel
    emit this->alertsChanged();
}

QDateTime Disturbances::timestamp() const
{
    return m_timestamp;
}

void Disturbances::setTimestamp(const QDateTime &timestamp)
{
    m_timestamp = timestamp;
    emit this->timestampChanged();
}

AlertListModel *Disturbances::alertListModel() const
{
    return m_alertListModel;
}

void Disturbances::setAlertListModel(AlertListModel *alertListModel)
{
    m_alertListModel = alertListModel;
    emit this->alertListModelChanged();
}

