#ifndef CONNECTIONTRACKER_H
#define CONNECTIONTRACKER_H

#include <QObject>
#include <QUuid>
#include <QMap>

#include "models/connection.h"
#include "models/vialistmodel.h"

#include "os.h"
#include "api.h"

class ConnectionTracker: public QObject {
    Q_OBJECT
    Q_PROPERTY(API *api MEMBER m_api)
public:
    ConnectionTracker(QObject *parent = nullptr);
    Q_INVOKABLE void toggleTracked(int i);

    void setApi(API *api) { this->m_api = api; }
    API *api() { return this->m_api; }

signals:
    // Raw pointer is needed for exposure in Qml
    void connectionTracked(QUuid uuid, Connection *connection);
    void connectionUntracked(QUuid uuid);

private:
    QMap<QUuid, QSharedPointer<Connection>> m_connections;
    API *m_api;
    OS sfos;
};

#endif // CONNECTIONTRACKER_H
