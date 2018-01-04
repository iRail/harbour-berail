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

#ifndef STOP_H
#define STOP_H

#include <QtCore/QObject>
#include <QtCore/QDateTime>
#include <QtCore/QString>

#include "stopabstract.h"
#include "station.h"
#include "enum.h"

class Stop: public StopAbstract
{
    Q_OBJECT
    Q_PROPERTY(QString platform READ platform WRITE setPlatform NOTIFY platformChanged)
    Q_PROPERTY(bool isDefaultPlatform READ isDefaultPlatform WRITE setIsDefaultPlatform NOTIFY isDefaultPlatformChanged)
    Q_PROPERTY(bool left READ left WRITE setLeft NOTIFY leftChanged)
    Q_PROPERTY(QDateTime realArrivalTime READ realArrivalTime WRITE setRealArrivalTime NOTIFY realArrivalTimeChanged)
    Q_PROPERTY(QDateTime realDepartureTime READ realDepartureTime WRITE setRealDepartureTime NOTIFY realDepartureTimeChanged)

public:
    explicit Stop(int id,
                  Station* station,
                  QString platform,
                  bool isDefaultPlatform,
                  int departureDelay,
                  QDateTime scheduledDepartureTime,
                  bool departureCanceled,
                  int arrivalDelay,
                  QDateTime scheduledArrivalTime,
                  bool arrivalCanceled,
                  bool left,
                  IRail::Occupancy occupancy,
                  bool isExtraStop
                  );
    explicit Stop(int id,
                  Station* station,
                  QString platform,
                  bool isDefaultPlatform,
                  int departureDelay,
                  QDateTime scheduledDepartureTime,
                  bool departureCanceled,
                  int arrivalDelay,
                  QDateTime scheduledArrivalTime,
                  bool arrivalCanceled,
                  bool left,
                  IRail::Occupancy occupancy
                  );
    explicit Stop(int id,
                  Station* station,
                  QString platform,
                  bool isDefaultPlatform,
                  int departureDelay,
                  QDateTime scheduledDepartureTime,
                  bool departureCanceled,
                  int arrivalDelay,
                  QDateTime scheduledArrivalTime,
                  bool arrivalCanceled,
                  bool left,
                  IRail::Occupancy occupancy,
                  bool isExtraStop,
                  QString direction,
                  bool walking
                  );
    QString platform() const;
    void setPlatform(const QString &platform);
    bool isDefaultPlatform() const;
    void setIsDefaultPlatform(bool isDefaultPlatform);
    bool left() const;
    void setLeft(bool left);
    QDateTime realArrivalTime() const;
    void setRealArrivalTime(const QDateTime &realArrivalTime);
    QDateTime realDepartureTime() const;
    void setRealDepartureTime(const QDateTime &realDepartureTime);

signals:
    void platformChanged();
    void isDefaultPlatformChanged();
    void leftChanged();
    void realArrivalTimeChanged();
    void realDepartureTimeChanged();

private:
    QDateTime m_realArrivalTime;
    QDateTime m_realDepartureTime;
    QString m_platform;
    bool m_isDefaultPlatform;
    bool m_left;
};

#endif // STOP_H
