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

    // TESTING
    /*API api;
    api.getDisturbances();
    api.getStations();
    api.getVehicle("BE.NMBS.S11769", QDateTime::currentDateTime());
    api.getLiveboard("Vilvoorde", QDateTime::currentDateTime(), ArrDep::Departure);
    api.getConnections("Vilvoorde", "Brugge", ArrDep::Departure, QDateTime::currentDateTime(), Transport::All);*/

    // Register custom QML modules
    qmlRegisterType<Liveboard>("Harbour.BeRail.Liveboard", 1, 0, "Liveboard");
    qmlRegisterType<IRail>("Harbour.BeRail.IRail", 1, 0, "IRail");
    qmlRegisterType<API>("Harbour.BeRail.API", 1, 0, "API");
    qmlRegisterType<OS>("Harbour.BeRail.SFOS", 1, 0, "SFOS");

    // Start the application.
    view->setSource(SailfishApp::pathTo("qml/harbour-berail.qml"));
    view->show();

    return app->exec();
}
