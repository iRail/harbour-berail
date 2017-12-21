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
