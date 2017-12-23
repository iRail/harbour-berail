#include "announcements.h"

/**
 * @class Announcements
 * @brief Announcements empty contructor
 */
Announcements::Announcements()
{

}

/**
 * @class Announcements
 * @brief Announcements constructor
 * @param alerts
 * @param timestamp
 */
Announcements::Announcements(QList<Alert*> alerts, QDateTime timestamp)
{
    this->setAlerts(alerts);
    this->setTimestamp(timestamp);
}

/**
 * @class Announcements
 * @brief Announcements destructor.
 * @details Marks all the allocated Alerts in the QList for deletion before it deletes itself.
 */
Announcements::~Announcements()
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

QList<Alert*> Announcements::alerts() const
{
    return m_alerts;
}

void Announcements::setAlerts(const QList<Alert*> &alerts)
{
    m_alerts = alerts;
    this->setAlertListModel(new AlertListModel(alerts)); // connect QList<Alerts *> to AlertsListModel
    emit this->alertsChanged();
}

QDateTime Announcements::timestamp() const
{
    return m_timestamp;
}

void Announcements::setTimestamp(const QDateTime &timestamp)
{
    m_timestamp = timestamp;
    emit this->timestampChanged();
}

AlertListModel *Announcements::alertListModel() const
{
    return m_alertListModel;
}

void Announcements::setAlertListModel(AlertListModel *alertListModel)
{
    m_alertListModel = alertListModel;
    emit this->alertListModelChanged();
}

