#ifndef STOPVIA_H
#define STOPVIA_H

#include "stopabstract.h"

class StopVia : public StopAbstract
{
    Q_OBJECT
    Q_PROPERTY(QString arrivalPlatform READ arrivalPlatform WRITE setArrivalPlatform NOTIFY arrivalPlatformChanged)
    Q_PROPERTY(bool isDefaultArrivalPlatform READ isDefaultArrivalPlatform WRITE setIsDefaultArrivalPlatform NOTIFY isDefaultArrivalPlatformChanged)
    Q_PROPERTY(QString departurePlatform READ departurePlatform WRITE setDeparturePlatform NOTIFY departurePlatformChanged)
    Q_PROPERTY(bool isDefaultDeparturePlatform READ isDefaultDeparturePlatform WRITE setIsDefaultDeparturePlatform NOTIFY isDefaultDeparturePlatformChanged)
    Q_PROPERTY(QString arrivalDirection READ arrivalDirection WRITE setArrivalDirection NOTIFY arrivalDirectionChanged)
    Q_PROPERTY(QString departureDirection READ departureDirection WRITE setDepartureDirection NOTIFY departureDirectionChanged)
    Q_PROPERTY(bool arrived READ arrived WRITE setArrived NOTIFY arrivedChanged)
    Q_PROPERTY(bool left READ left WRITE setLeft NOTIFY leftChanged)

public:
    explicit StopVia(int id,
                     Station* station,
                     QString arrivalPlatform,
                     bool isDefaultArrivalPlatform,
                     QString departurePlatform,
                     bool isDefaultDeparturePlatform,
                     int departureDelay,
                     QDateTime scheduledDepartureTime,
                     bool departureCanceled,
                     int arrivalDelay,
                     QDateTime scheduledArrivalTime,
                     bool arrivalCanceled,
                     bool arrived,
                     bool left,
                     IRail::Occupancy occupancy
                     );
    explicit StopVia(int id,
                     Station* station,
                     QString arrivalPlatform,
                     bool isDefaultArrivalPlatform,
                     QString departurePlatform,
                     bool isDefaultDeparturePlatform,
                     int departureDelay,
                     QDateTime scheduledDepartureTime,
                     bool departureCanceled,
                     int arrivalDelay,
                     QDateTime scheduledArrivalTime,
                     bool arrivalCanceled,
                     bool arrived,
                     bool left,
                     IRail::Occupancy occupancy,
                     bool isExtraStop,
                     QString arrivalDirection,
                     QString departureDirection,
                     bool walking
                     );

    QString arrivalPlatform() const;
    void setArrivalPlatform(const QString &arrivalPlatform);
    bool isDefaultArrivalPlatform() const;
    void setIsDefaultArrivalPlatform(bool isDefaultArrivalPlatform);
    QString departurePlatform() const;
    void setDeparturePlatform(const QString &departurePlatform);
    bool isDefaultDeparturePlatform() const;
    void setIsDefaultDeparturePlatform(bool isDefaultDeparturePlatform);
    QString arrivalDirection() const;
    void setArrivalDirection(const QString &arrivalDirection);
    QString departureDirection() const;
    void setDepartureDirection(const QString &departureDirection);
    bool arrived() const;
    void setArrived(bool arrived);
    bool left() const;
    void setLeft(bool left);

signals:
    void arrivalPlatformChanged();
    void isDefaultArrivalPlatformChanged();
    void departurePlatformChanged();
    void isDefaultDeparturePlatformChanged();
    void arrivalDirectionChanged();
    void departureDirectionChanged();
    void arrivedChanged();
    void leftChanged();

private:
    QString m_arrivalPlatform;
    bool m_isDefaultArrivalPlatform;
    QString m_departurePlatform;
    bool m_isDefaultDeparturePlatform;
    QString m_arrivalDirection;
    QString m_departureDirection;
    bool m_arrived;
    bool m_left;
};

#endif // STOPVIA_H
