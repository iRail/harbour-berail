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

#ifndef STOPABSTRACT_H
#define STOPABSTRACT_H

#include <QtCore/QObject>
#include <QtCore/QDateTime>
#include <QtCore/QString>

#include "station.h"
#include "enum.h"

class StopAbstract: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(Station *station READ station WRITE setStation NOTIFY stationChanged)
    Q_PROPERTY(int departureDelay READ departureDelay WRITE setDepartureDelay NOTIFY departureDelayChanged)
    Q_PROPERTY(bool departureCanceled READ departureCanceled WRITE setDepartureCanceled NOTIFY departureCanceledChanged)
    Q_PROPERTY(QDateTime scheduledDepartureTime READ scheduledDepartureTime WRITE setScheduledDepartureTime NOTIFY scheduledDepartureTimeChanged)
    Q_PROPERTY(int arrivalDelay READ arrivalDelay WRITE setArrivalDelay NOTIFY arrivalDelayChanged)
    Q_PROPERTY(bool arrivalCanceled READ arrivalCanceled WRITE setArrivalCanceled NOTIFY arrivalCanceledChanged)
    Q_PROPERTY(QDateTime scheduledArrivalTime READ scheduledArrivalTime WRITE setScheduledArrivalTime NOTIFY scheduledArrivalTimeChanged)
    Q_PROPERTY(IRail::Occupancy occupancy READ occupancy WRITE setOccupancy NOTIFY occupancyChanged)
    Q_PROPERTY(bool isExtraStop READ isExtraStop WRITE setIsExtraStop NOTIFY isExtraStopChanged)
    Q_PROPERTY(QString direction READ direction WRITE setDirection NOTIFY directionChanged)
    Q_PROPERTY(bool walking READ walking WRITE setWalking NOTIFY walkingChanged)

public:
    explicit StopAbstract();
    int id() const;
    void setId(int id);
    Station* station() const;
    void setStation(Station* station);
    int departureDelay() const;
    void setDepartureDelay(int departureDelay);
    QDateTime scheduledDepartureTime() const;
    void setScheduledDepartureTime(const QDateTime &scheduledDepartureTime);
    bool departureCanceled() const;
    void setDepartureCanceled(bool departureCanceled);
    int arrivalDelay() const;
    void setArrivalDelay(int arrivalDelay);
    QDateTime scheduledArrivalTime() const;
    void setScheduledArrivalTime(const QDateTime &scheduledArrivalTime);
    bool arrivalCanceled() const;
    void setArrivalCanceled(bool arrivalCanceled);
    IRail::Occupancy occupancy() const;
    void setOccupancy(const IRail::Occupancy &occupancy);
    bool isExtraStop() const;
    void setIsExtraStop(bool isExtraStop);
    QString direction() const;
    void setDirection(const QString &direction);
    bool walking() const;
    void setWalking(bool walking);

signals:
    void idChanged();
    void stationChanged();
    void departureDelayChanged();
    void departureCanceledChanged();
    void scheduledDepartureTimeChanged();
    void arrivalDelayChanged();
    void arrivalCanceledChanged();
    void scheduledArrivalTimeChanged();
    void occupancyChanged();
    void isExtraStopChanged();
    void directionChanged();
    void walkingChanged();

private:
    int m_id;
    Station* m_station;
    int m_departureDelay;
    QDateTime m_scheduledDepartureTime;
    bool m_departureCanceled;
    int m_arrivalDelay;
    QDateTime m_scheduledArrivalTime;
    bool m_arrivalCanceled;
    IRail::Occupancy m_occupancy;
    bool m_isExtraStop;
    QString m_direction;
    bool m_walking;
};

#endif // STOPABSTRACT_H
