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
