#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QtCore/QScopedPointer>
#include <QtCore/QString>
#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>
#include <QtQml/QQmlEngine>

#include "logger.h"
#include "os.h"
#include "api.h"
#include "models/station.h"

// Add toString() method to all custom method

int main(int argc, char *argv[])
{
    // Set up qml engine.
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    qApp->setApplicationVersion(QString(APP_VERSION));

    // Set application version and enable logging
    enableLogger(false);

    // Register custom QML modules
    qmlRegisterUncreatableType<Liveboard>("Harbour.BeRail.Models", 1, 0, "Liveboard", "read only");
    qmlRegisterUncreatableType<Vehicle>("Harbour.BeRail.Models", 1, 0, "Vehicle", "read only");
    qmlRegisterUncreatableType<Connection>("Harbour.BeRail.Models", 1, 0, "Connection", "read only");
    qmlRegisterUncreatableType<Station>("Harbour.BeRail.Models", 1, 0, "Station", "read only");
    qmlRegisterUncreatableType<Stop>("Harbour.BeRail.Models", 1, 0, "Stop", "read only");
    qmlRegisterUncreatableType<Via>("Harbour.BeRail.Models", 1, 0, "Via", "read only");
    qmlRegisterUncreatableType<Disturbances>("Harbour.BeRail.Models", 1, 0, "Disturbances", "read only");
    qmlRegisterUncreatableType<Alert>("Harbour.BeRail.Models", 1, 0, "Alert", "read only");
    qmlRegisterUncreatableType<IRail>("Harbour.BeRail.Models", 1, 0, "IRail", "read only");
    qmlRegisterType<API>("Harbour.BeRail.API", 1, 0, "API");
    qmlRegisterType<OS>("Harbour.BeRail.SFOS", 1, 0, "SFOS");

    // Start the application.
    view->setSource(SailfishApp::pathTo("qml/harbour-berail.qml"));
    view->show();

    return app->exec();
}
