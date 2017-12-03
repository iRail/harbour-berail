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
    Q_PROPERTY(Station station READ getStation WRITE setStation NOTIFY stationChanged)
    Q_PROPERTY(QList<Vehicle> vehicles READ getVehicles WRITE setVehicles NOTIFY vehiclesChanged)
    Q_PROPERTY(QDateTime time READ getTime WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(ArrDep arrdep READ getArrDep WRITE setArrDep NOTIFY arrdepChanged)
    Q_PROPERTY(Disturbances disturbances READ getDisturbances WRITE setDisturbances NOTIFY disturbancesChanged)
    Q_PROPERTY(QDateTime timestamp READ getTimestamp WRITE setTimestamp NOTIFY timestampChanged)

public:
    explicit Liveboard(Station station, QDateTime time, ArrDep arrdep, Disturbances disturbances);
    explicit Liveboard();
    Station getStation();
    QList<Vehicle> getVehicles();
    QDateTime getTime();
    ArrDep getArrDep();
    Disturbances getDisturbances();
    QDateTime getTimestamp();
    void setStation(Station station);
    void setVehicles(QList<Vehicle> vehicles);
    void setTime(QDateTime time);
    void setArrDep(ArrDep arrdep);
    void setDisturbances(Disturbances disturbances);
    void setTimestamp(QDateTime timestamp);
    virtual ~Liveboard();

signals:
    void stationChanged();
    void vehiclesChanged();
    void timeChanged();
    void arrdepChanged();
    void disturbancesChanged();
    void timestampChanged();

private:
    Station m_station;
    QList<Vehicle> m_vehicles;
    QDateTime m_time;
    ArrDep m_arrdep;
    Disturbances m_disturbances;
    QDateTime m_timestamp;
};

#endif // LIVEBOARD_H
