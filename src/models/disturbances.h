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
#ifndef DISTURBANCES_H
#define DISTURBANCES_H

#include <QtCore/QObject>
#include <QtCore/QList>
#include <QtCore/QDateTime>

#include "announcements.h"

class Disturbances: public Announcements
{
    Q_OBJECT
public:
    explicit Disturbances(QList<Alert*> alerts, QDateTime timestamp);
    explicit Disturbances();
};

#endif // DISTURBANCES_H
