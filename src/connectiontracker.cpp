#include <QDebug>

#include "connectiontracker.h"

#include "models/vialistmodel.h"
#include "api.h"
#include "os.h"

ConnectionTracker::ConnectionTracker(QObject *parent)
    : QObject(parent), m_connections()
{

}


void ConnectionTracker::toggleTracked(int i) {
    auto connection = m_api->connections()->connectionList()[i];

    auto uuid = connection->uuid();
    qDebug() << "toggle tracking of" << connection->from()->station()->name() << " to " << connection->to()->station()->name()
             << "with uuid" << uuid;

    if(m_connections.contains(uuid)) {
        m_connections.remove(uuid);
        emit connectionUntracked(uuid);
    } else {
        m_connections.insert(uuid, connection);

        auto raw = connection.data();
        QQmlEngine::setObjectOwnership(raw, QQmlEngine::ObjectOwnership::CppOwnership);

        emit connectionTracked(uuid, raw);
    }
}
