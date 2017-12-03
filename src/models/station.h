#ifndef STATION_H
#define STATION_H

#include <QtCore/QObject>
#include <QtCore/QString>
#include <QtCore/QList>
#include <QtCore/QPair>
#include <QtPositioning/QGeoCoordinate>

class Station: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QGeoCoordinate location READ location WRITE setLocation NOTIFY locationChanged)

public:
    explicit Station(QString id, QString name, QGeoCoordinate location);
    explicit Station();

    QString id() const;
    void setId(const QString &id);
    QString name() const;
    void setName(const QString &name);
    QGeoCoordinate location() const;
    void setLocation(const QGeoCoordinate &location);

signals:
    void idChanged();
    void nameChanged();
    void locationChanged();

private:
    QString m_id;
    QString m_name;
    QGeoCoordinate m_location;
};

#endif // STATION_H
