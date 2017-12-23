#ifndef REMARKS_H
#define REMARKS_H

#include <QtCore/QObject>
#include <QtCore/QList>
#include <QtCore/QDateTime>

#include "announcements.h"

class Remarks: public Announcements
{
    Q_OBJECT
public:
    explicit Remarks(QList<Alert*> alerts, QDateTime timestamp);
    explicit Remarks();
};

#endif // REMARKS_H
