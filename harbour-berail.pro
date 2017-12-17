# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-berail

CONFIG += sailfishapp

QT += core \
    network \
    positioning

SOURCES += src/harbour-berail.cpp \
    src/logger.cpp \
    src/os.cpp \
    src/api.cpp \
    src/models/station.cpp \
    src/models/alert.cpp \
    src/models/disturbances.cpp \
    src/models/liveboard.cpp \
    src/models/vehicle.cpp \
    src/models/stop.cpp \
    src/models/connection.cpp \
    src/models/via.cpp

OTHER_FILES += qml/harbour-berail.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-berail.spec \
    rpm/harbour-berail.yaml \
    translations/*.ts \
    harbour-berail.desktop

# OS module notification support
PKGCONFIG += nemonotifications-qt5
QT += dbus

# Disable debug and warning messages while releasing for security reasons
CONFIG(release, debug|release):DEFINES += QT_NO_DEBUG_OUTPUT \
QT_NO_WARNING_OUTPUT

# APP_VERSION retrieved from .spec file
DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-berail-de.ts \
translations/harbour-berail-nl.ts

DISTFILES += \
    qml/pages/AboutPage.qml \
    qml/pages/TextLabel.qml \
    qml/pages/GlassButton.qml \
    qml/resources/icons/icon-translate.png \
    qml/resources/icons/icon-paypal.png \
    qml/resources/icons/icon-github.png \
    qml/resources/icons/icon-fontawesome.png \
    qml/resources/icons/icon-code.png \
    qml/pages/components/TextLabel.qml \
    qml/pages/components/GlassButton.qml \
    qml/pages/js/station.js \
    qml/pages/StationListPage.qml \
    qml/pages/js/util.js \
    qml/pages/DatePickerPage.qml \
    qml/pages/TripPage.qml \
    qml/pages/components/TripItem.qml \
    qml/pages/js/trip.js \
    qml/pages/TripDetailPage.qml \
    qml/pages/components/LiveBoardItem.qml \
    qml/pages/components/CancelOverlay.qml \
    qml/pages/js/liveboard.js \
    qml/pages/components/LoadIndicator.qml \
    qml/pages/LiveboardPage.qml \
    rpm/harbour-berail.changes \
    qml/pages/js/disturbances.js \
    qml/pages/components/DisturbancesView.qml \
    qml/pages/DisturbancesPage.qml \
    qml/pages/SettingsPage.qml

RESOURCES += \
    qml/resources/resources.qrc

HEADERS += \
    src/logger.h \
    src/os.h \
    src/api.h \
    src/models/enum.h \
    src/models/station.h \
    src/models/alert.h \
    src/models/disturbances.h \
    src/models/liveboard.h \
    src/models/vehicle.h \
    src/models/stop.h \
    src/models/connection.h \
    src/models/via.h
