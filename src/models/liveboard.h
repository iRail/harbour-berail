#ifndef LIVEBOARD_H
#define LIVEBOARD_H

#include <QtCore/QObject>
#include <QtCore/QDateTime>
#include <QtCore/QList>

#include "station.h"
#include "vehicle.h"
#include "disturbances.h"
#include "enum.h"

class Liveboard: public QObject
{
    Q_OBJECT
    Q_PROPERTY(Station* station READ station WRITE setStation NOTIFY stationChanged)
    Q_PROPERTY(QList<Vehicle*> vehicles READ vehicles WRITE setVehicles NOTIFY vehiclesChanged)
    Q_PROPERTY(ArrDep arrdep READ arrdep WRITE setArrdep NOTIFY arrdepChanged)
    Q_PROPERTY(Disturbances* disturbances READ disturbances WRITE setDisturbances NOTIFY disturbancesChanged)
    Q_PROPERTY(QDateTime timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)

public:
    explicit Liveboard(Station* station, QList<Vehicle*> vehicles, QDateTime time, ArrDep arrdep, Disturbances* disturbances);
    explicit Liveboard();
    Station *station() const;
    void setStation(Station *station);
    QList<Vehicle*> vehicles() const;
    void setVehicles(const QList<Vehicle*> &vehicles);
    ArrDep arrdep() const;
    void setArrdep(const ArrDep &arrdep);
    Disturbances *disturbances() const;
    void setDisturbances(Disturbances *disturbances);
    QDateTime timestamp() const;
    void setTimestamp(const QDateTime &timestamp);

signals:
    void stationChanged();
    void vehiclesChanged();
    void arrdepChanged();
    void disturbancesChanged();
    void timestampChanged();

private:
    Station* m_station;
    QList<Vehicle*> m_vehicles;
    ArrDep m_arrdep;
    Disturbances* m_disturbances;
    QDateTime m_timestamp;
};

#endif // LIVEBOARD_H
