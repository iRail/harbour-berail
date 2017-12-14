#ifndef ENUM_H
#define ENUM_H

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

#endif // ENUM_H
