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
