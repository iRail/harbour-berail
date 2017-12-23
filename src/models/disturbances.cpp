#include "disturbances.h"

/**
 * @class Disturbances
 * @brief Disturbances default constructor overide
 */
Disturbances::Disturbances()
{

}

/**
 * @class Disturbances
 * @brief Disturbances constructor overide
 * @param alerts
 * @param timestamp
 */
Disturbances::Disturbances(QList<Alert*> alerts, QDateTime timestamp)
{
    this->setAlerts(alerts);
    this->setTimestamp(timestamp);
}
