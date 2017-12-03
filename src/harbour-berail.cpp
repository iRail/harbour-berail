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

int main(int argc, char *argv[])
{
    // Set up qml engine.
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    qApp->setApplicationVersion(QString(APP_VERSION));

    // Set application version and enable logging
    enableLogger(false);

    // TESTING
    API api;
    api.getDisturbances();
    api.getStations();
    api.getVehicle("IC123", QDateTime::currentDateTime());
    api.getLiveboard("Vilvoorde", QDateTime::currentDateTime(), ArrDep::Departure);

    // Register custom QML modules
    qmlRegisterType<API>("Harbour.BeRail.API", 1, 0, "API");
    qmlRegisterType<OS>("Harbour.BeRail.SFOS", 1, 0, "SFOS");

    // Start the application.
    view->setSource(SailfishApp::pathTo("qml/harbour-berail.qml"));
    view->show();

    return app->exec();
}
