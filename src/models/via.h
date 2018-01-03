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
#ifndef VIA_H
#define VIA_H

#include <QtCore/QObject>
#include <QtCore/QString>

#include "stopvia.h"
#include "disturbances.h"

class Via: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(StopVia* stop READ stop WRITE setStop NOTIFY stopChanged)
    Q_PROPERTY(QDateTime arrivalTime READ arrivalTime WRITE setArrivalTime NOTIFY arrivalTimeChanged)
    Q_PROPERTY(QDateTime leftTime READ leftTime WRITE setLeftTime NOTIFY leftTimeChanged)
    Q_PROPERTY(int timeBetween READ timeBetween WRITE setTimeBetween NOTIFY timeBetweenChanged)
    Q_PROPERTY(bool willMissVia READ willMissVia WRITE setWillMissVia NOTIFY willMissViaChanged)
    Q_PROPERTY(QString vehicleId READ vehicleId WRITE setVehicleId NOTIFY vehicleIdChanged)
    Q_PROPERTY(Disturbances* disturbances READ disturbances WRITE setDisturbances NOTIFY disturbancesChanged)

public:
    explicit Via(StopVia* stop, QString vehicleId, Disturbances* disturbances);
    int id() const;
    void setId(int id);
    int timeBetween() const;
    void setTimeBetween(int timeBetween);
    QString vehicleId() const;
    void setVehicleId(const QString &vehicleId);
    Disturbances *disturbances() const;
    void setDisturbances(Disturbances *disturbances);
    StopVia *stop() const;
    void setStop(StopVia *stop);
    QDateTime arrivalTime() const;
    void setArrivalTime(const QDateTime &arrivalTime);
    QDateTime leftTime() const;
    void setLeftTime(const QDateTime &leftTime);
    bool willMissVia() const;
    void setWillMissVia(bool willMissVia);

signals:
    void idChanged();
    void stopChanged();
    void arrivalTimeChanged();
    void leftTimeChanged();
    void timeBetweenChanged();
    void willMissViaChanged();
    void vehicleIdChanged();
    void disturbancesChanged();

private:
    int m_id;
    StopVia* m_stop;
    QDateTime m_arrivalTime;
    QDateTime m_leftTime;
    int m_timeBetween;
    bool m_willMissVia;
    QString m_vehicleId;
    Disturbances* m_disturbances;
};

#endif // VIA_H
