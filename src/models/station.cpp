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
#include "station.h"

Station::Station() {

}

Station::Station(QString id, QString name, QGeoCoordinate location) {
    setId(id);
    setName(name);
    setLocation(location);
}

/*********************
 * Getters & Setters *
 *********************/

QString Station::id() const
{
    return m_id;
}

void Station::setId(const QString &id)
{
    m_id = id;
    emit this->idChanged();
}

QString Station::name() const
{
    return m_name;
}

void Station::setName(const QString &name)
{
    m_name = name;
    emit this->nameChanged();
}

QGeoCoordinate Station::location() const
{
    return m_location;
}

void Station::setLocation(const QGeoCoordinate &location)
{
    m_location = location;
    emit this->locationChanged();
}
