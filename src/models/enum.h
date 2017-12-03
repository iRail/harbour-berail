#ifndef ENUM_H
#define ENUM_H

enum class Format {
    XML,
    JSON,
    JSONP
};

enum class ArrDep {
    Arrival,
    Departure
};

enum class Transport {
    All,
    Trains,
    NoInternationalTrains
};

enum class Occupancy {
    Unknown,
    Low,
    Medium,
    High
};

#endif // ENUM_H
