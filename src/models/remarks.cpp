#include "remarks.h"

/**
 * @class Remarks
 * @brief Remarks default constructor overide
 */
Remarks::Remarks()
{

}

/**
 * @class Remarks
 * @brief Remarks constructor overide
 * @param alerts
 * @param timestamp
 */
Remarks::Remarks(QList<Alert*> alerts, QDateTime timestamp)
{
    this->setAlerts(alerts);
    this->setTimestamp(timestamp);
}
