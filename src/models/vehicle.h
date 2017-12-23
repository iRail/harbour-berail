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
#ifndef VEHICLE_H
#define VEHICLE_H

#include <QtCore/QObject>
#include <QtCore/QString>
#include <QtCore/QDateTime>
#include <QtCore/QList>
#include <QtPositioning/QGeoCoordinate>

#include "disturbances.h"
#include "stop.h"
#include "stoplistmodel.h"
#include "enum.h"

// Add time() for easy extraction in QML
class Vehicle: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QDate date READ date WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(QList<Stop *> stops READ stops WRITE setStops NOTIFY stopsChanged)
    Q_PROPERTY(QGeoCoordinate location READ location WRITE setLocation NOTIFY locationChanged)
    Q_PROPERTY(bool canceled READ canceled WRITE setCanceled NOTIFY canceledChanged)
    Q_PROPERTY(IRail::Occupancy occupancy READ occupancy WRITE setOccupancy NOTIFY occupancyChanged)
    Q_PROPERTY(Disturbances* disturbances READ disturbances WRITE setDisturbances NOTIFY disturbancesChanged)
    Q_PROPERTY(QDateTime timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)
    Q_PROPERTY(StopListModel* stopListModel READ stopListModel WRITE setStopListModel NOTIFY stopListModelChanged)
    Q_PROPERTY(AlertListModel* alertListModel READ alertListModel WRITE setAlertListModel NOTIFY alertListModelChanged)

public:
    explicit Vehicle(QString id, QDate date, QList<Stop*> stops, QGeoCoordinate location, bool canceled, IRail::Occupancy occupancy, Disturbances* disturbances, QDateTime timestamp);
    QString id() const;
    void setId(const QString &id);
    QDate date() const;
    void setDate(const QDate &date);
    QList<Stop *> stops() const;
    void setStops(const QList<Stop *> &stops);
    QGeoCoordinate location() const;
    void setLocation(const QGeoCoordinate &location);
    bool canceled() const;
    void setCanceled(bool cancelled);
    IRail::Occupancy occupancy() const;
    void setOccupancy(const IRail::Occupancy &occupancy);
    Disturbances *disturbances() const;
    void setDisturbances(Disturbances *disturbances);
    QDateTime timestamp() const;
    void setTimestamp(const QDateTime &timestamp);
    StopListModel *stopListModel() const;
    void setStopListModel(StopListModel *stopListModel);
    AlertListModel *alertListModel() const;
    void setAlertListModel(AlertListModel *alertListModel);

signals:
    void idChanged();
    void dateChanged();
    void stopsChanged();
    void locationChanged();
    void canceledChanged();
    void occupancyChanged();
    void disturbancesChanged();
    void timestampChanged();
    void stopListModelChanged();
    void alertListModelChanged();

private:
    QString m_id;
    QDate m_date;
    QList<Stop*> m_stops;
    QGeoCoordinate m_location;
    bool m_canceled;
    IRail::Occupancy m_occupancy;
    Disturbances* m_disturbances;
    QDateTime m_timestamp;
    StopListModel* m_stopListModel;
    AlertListModel* m_alertListModel;
};

#endif // VEHICLE_H
