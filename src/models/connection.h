#ifndef CONNECTION_H
#define CONNECTION_H

#include <QtCore/QObject>
#include <QtCore/QList>
#include <QtCore/QString>
#include "stop.h"
#include "disturbances.h"
#include "via.h"

class Connection: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(Stop* from READ from WRITE setFrom NOTIFY fromChanged)
    Q_PROPERTY(Stop* to READ to WRITE setTo NOTIFY toChanged)
    Q_PROPERTY(Disturbances* alerts READ alerts WRITE setAlerts NOTIFY alertsChanged)
    Q_PROPERTY(Disturbances* remarks READ remarks WRITE setRemarks NOTIFY remarksChanged)
    Q_PROPERTY(Occupancy occupancy READ occupancy WRITE setOccupancy NOTIFY occupancyChanged)
    Q_PROPERTY(int duration READ duration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(QList<Via*> vias READ vias WRITE setVias NOTIFY viasChanged)
    Q_PROPERTY(QDateTime timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)

public:
    explicit Connection(int id, Stop* fromStation, Stop* toStation, Disturbances* alerts, Disturbances* remarks, Occupancy occupancy, int duration, QList<Via *> vias, QDateTime timestamp);
    int id() const;
    void setId(const int &id);
    Occupancy occupancy() const;
    void setOccupancy(const Occupancy &occupancy);
    int duration() const;
    void setDuration(int duration);
    int numberOfVias() const;
    void setNumberOfVias(int numberOfVias);
    Stop *from() const;
    void setFrom(Stop *from);
    Stop *to() const;
    void setTo(Stop *to);
    Disturbances *alerts() const;
    void setAlerts(Disturbances *alerts);
    Disturbances *remarks() const;
    void setRemarks(Disturbances *remarks);
    QList<Via *> vias() const;
    void setVias(const QList<Via *> &vias);
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
    Disturbances* m_alerts;
    Disturbances* m_remarks;
    Occupancy m_occupancy;
    int m_duration;
    QList<Via *> m_vias;
    QDateTime m_timestamp;
};

#endif // CONNECTION_H
