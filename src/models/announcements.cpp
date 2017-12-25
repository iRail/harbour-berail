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
    emit this->lengthChanged();
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

int Announcements::length() const
{
    return this->alerts().length();
}

