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
#ifndef CONNECTION_H
#define CONNECTION_H

#include <QtCore/QObject>
#include <QtCore/QList>
#include <QtCore/QString>
#include "stop.h"
#include "disturbances.h"
#include "remarks.h"
#include "vialistmodel.h"

class Connection: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(Stop* from READ from WRITE setFrom NOTIFY fromChanged)
    Q_PROPERTY(Stop* to READ to WRITE setTo NOTIFY toChanged)
    Q_PROPERTY(Disturbances* alerts READ alerts WRITE setAlerts NOTIFY alertsChanged)
    Q_PROPERTY(Remarks* remarks READ remarks WRITE setRemarks NOTIFY remarksChanged)
    Q_PROPERTY(IRail::Occupancy occupancy READ occupancy WRITE setOccupancy NOTIFY occupancyChanged)
    Q_PROPERTY(int duration READ duration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(ViaListModel* vias READ vias WRITE setVias NOTIFY viasChanged)
    Q_PROPERTY(QDateTime timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)

public:
    explicit Connection(int id,
                        Stop* fromStation,
                        Stop* toStation,
                        QString fromVehicleId,
                        QString toVehicleId,
                        Disturbances* alerts,
                        Remarks* remarks,
                        IRail::Occupancy occupancy,
                        int duration,
                        ViaListModel* vias,
                        QDateTime timestamp
                        );
    int id() const;
    void setId(const int &id);
    IRail::Occupancy occupancy() const;
    void setOccupancy(const IRail::Occupancy &occupancy);
    int duration() const;
    void setDuration(int duration);
    int numberOfVias() const;
    void setNumberOfVias(int numberOfVias);
    Stop *from() const;
    void setFrom(Stop *from);
    Stop *to() const;
    void setTo(Stop *to);
    QString fromVehicleId() const;
    void setFromVehicleId(const QString &fromVehicleId);
    QString toVehicleId() const;
    void setToVehicleId(const QString &toVehicleId);
    Disturbances *alerts() const;
    void setAlerts(Disturbances *alerts);
    Remarks *remarks() const;
    void setRemarks(Remarks *remarks);
    ViaListModel *vias() const;
    void setVias(ViaListModel *vias);
    QDateTime timestamp() const;
    void setTimestamp(const QDateTime &value);

signals:
    void idChanged();
    void fromChanged();
    void toChanged();
    void alertsChanged();
    void remarksChanged();
    void occupancyChanged();
    void durationChanged();
    void numberOfViasChanged();
    void viasChanged();
    void timestampChanged();

private:
    int m_id;
    Stop* m_from;
    Stop* m_to;
    QString m_fromVehicleId;
    QString m_toVehicleId;
    Disturbances* m_alerts;
    Remarks* m_remarks;
    IRail::Occupancy m_occupancy;
    int m_duration;
    ViaListModel* m_vias;
    QDateTime m_timestamp;
};

#endif // CONNECTION_H
