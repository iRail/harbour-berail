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

#include "via.h"
#include <QtGlobal>
#include <QDebug>

Via::Via(StopVia* stop, QString vehicleId, Disturbances* disturbances)
{
    this->setStop(stop);
    this->setVehicleId(vehicleId);
    this->setDisturbances(disturbances);

    // Use our own 'timeBetween' instead of the provided one from the iRail API
    // The iRail API ignores the delays from the arrival or departure times
    QDateTime arrivalTime = stop->scheduledArrivalTime();
    arrivalTime = arrivalTime.addSecs((qint64)(stop->arrivalDelay()));
    QDateTime leftTime = stop->scheduledDepartureTime();
    leftTime = leftTime.addSecs((qint64)(stop->departureDelay()));
    this->setTimeBetween((int)(arrivalTime.secsTo(leftTime)));
    this->setWillMissVia(this->timeBetween() < 0);
    this->setArrivalTime(arrivalTime);
    this->setLeftTime(leftTime);
}

/*********************
 * Getters & Setters *
 *********************/

int Via::id() const
{
    return m_id;
}

void Via::setId(int id)
{
    m_id = id;
    emit this->idChanged();
}

StopVia *Via::stop() const
{
    return m_stop;
}

void Via::setStop(StopVia *stop)
{
    m_stop = stop;
    emit this->stopChanged();
}

int Via::timeBetween() const
{
    return m_timeBetween;
}

QDateTime Via::arrivalTime() const
{
    return m_arrivalTime;
}

void Via::setArrivalTime(const QDateTime &arrivalTime)
{
    m_arrivalTime = arrivalTime;
    emit this->arrivalTimeChanged();
}

QDateTime Via::leftTime() const
{
    return m_leftTime;
}

void Via::setLeftTime(const QDateTime &leftTime)
{
    m_leftTime = leftTime;
    emit this->leftTimeChanged();
}

bool Via::willMissVia() const
{
    return m_willMissVia;
}

void Via::setWillMissVia(bool willMissVia)
{
    m_willMissVia = willMissVia;
    emit this->willMissViaChanged();
}

void Via::setTimeBetween(int timeBetween)
{
    m_timeBetween = timeBetween;
    emit this->timeBetweenChanged();
}

QString Via::vehicleId() const
{
    return m_vehicleId;
}

void Via::setVehicleId(const QString &vehicleId)
{
    m_vehicleId = vehicleId;
    emit this->vehicleIdChanged();
}

Disturbances *Via::disturbances() const
{
    return m_disturbances;
}

void Via::setDisturbances(Disturbances *disturbances)
{
    m_disturbances = disturbances;
}
