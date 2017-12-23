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
#ifndef ENUM_H
#define ENUM_H

#include <QtCore/QObject>
#include <QtCore/QMetaType>

class IRail
{
    // Enums can use the lightweight Q_GADGET type instead of Q_OBJECT
    Q_GADGET

public:
    explicit IRail();

    enum class Format {
        XML = 0,
        JSON = 1,
        JSONP = 2
    };

    enum class ArrDep {
        Arrival = 0,
        Departure = 1
    };

    enum class Transport {
        All = 0,
        Trains = 1,
        NoInternationalTrains = 2
    };

    enum class Occupancy {
        Unknown = 0,
        Low = 1,
        Medium = 2,
        High = 3
    };

    Q_ENUMS(Format)
    Q_ENUMS(ArrDep)
    Q_ENUMS(Transport)
    Q_ENUMS(Occupancy)

};

Q_DECLARE_METATYPE(IRail::Format)
Q_DECLARE_METATYPE(IRail::ArrDep)
Q_DECLARE_METATYPE(IRail::Transport)
Q_DECLARE_METATYPE(IRail::Occupancy)


#endif // ENUM_H
