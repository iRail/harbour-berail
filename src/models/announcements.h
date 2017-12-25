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
#ifndef ANNOUNCEMENTS_H
#define ANNOUNCEMENTS_H

#include <QtCore/QObject>
#include <QtCore/QList>
#include <QtCore/QDateTime>

#include "alert.h"
#include "alertlistmodel.h"

class Announcements: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<Alert*> alerts READ alerts WRITE setAlerts NOTIFY alertsChanged)
    Q_PROPERTY(QDateTime timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)
    Q_PROPERTY(AlertListModel* alertListModel READ alertListModel WRITE setAlertListModel NOTIFY alertListModelChanged)
    Q_PROPERTY(int length READ length NOTIFY lengthChanged)

public:
    explicit Announcements(QList<Alert*> alerts, QDateTime timestamp);
    explicit Announcements();
    virtual ~Announcements();
    QList<Alert*> alerts() const;
    void setAlerts(const QList<Alert*> &alerts);
    QDateTime timestamp() const;
    void setTimestamp(const QDateTime &timestamp);
    AlertListModel *alertListModel() const;
    void setAlertListModel(AlertListModel *alertListModel);
    int length() const;

signals:
    void alertsChanged();
    void timestampChanged();
    void alertListModelChanged();
    void lengthChanged();

private:
    QList<Alert*> m_alerts;
    QDateTime m_timestamp;
    AlertListModel* m_alertListModel;
};

#endif // ANNOUNCEMENTS_H
