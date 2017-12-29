#
#   This file is part of BeRail.
#
#   BeRail is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   BeRail is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with BeRail.  If not, see <http://www.gnu.org/licenses/>.
#

# The name of your application
TARGET = harbour-berail

CONFIG += sailfishapp

QT += core \
    network \
    positioning

# OS module notification support
PKGCONFIG += nemonotifications-qt5
QT += dbus

# Disable debug and warning messages while releasing for security reasons
CONFIG(release, debug|release):DEFINES += QT_NO_DEBUG_OUTPUT \
QT_NO_WARNING_OUTPUT

# APP_VERSION retrieved from .spec file
DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# Enable translations
CONFIG += sailfishapp_i18n \
    sailfishapp_i18n_idbased \
    sailfishapp_i18n_unfinished

TRANSLATIONS += translations/harbour-berail.ts \
translations/harbour-berail-de.ts \
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
    qml/pages/components/TripItem.qml \
    qml/pages/js/trip.js \
    qml/pages/components/LiveBoardItem.qml \
    qml/pages/components/CancelOverlay.qml \
    qml/pages/js/liveboard.js \
    qml/pages/components/LoadIndicator.qml \
    qml/pages/LiveboardPage.qml \
    rpm/harbour-berail.changes \
    qml/pages/js/disturbances.js \
    qml/pages/components/DisturbancesView.qml \
    qml/pages/DisturbancesPage.qml \
    qml/pages/SettingsPage.qml \
    translations/harbour-berail-en.ts

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
    src/models/via.h \
    src/models/alertlistmodel.h \
    src/models/stoplistmodel.h \
    src/models/vehiclelistmodel.h \
    src/models/stationlistmodel.h \
    src/models/connectionlistmodel.h \
    src/models/vialistmodel.h \
    src/models/announcements.h \
    src/models/remarks.h \
    src/models/stationlistmodelfilter.h

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
    src/models/via.cpp \
    src/models/enum.cpp \
    src/models/alertlistmodel.cpp \
    src/models/stoplistmodel.cpp \
    src/models/vehiclelistmodel.cpp \
    src/models/stationlistmodel.cpp \
    src/models/connectionlistmodel.cpp \
    src/models/vialistmodel.cpp \
    src/models/announcements.cpp \
    src/models/remarks.cpp \
    src/models/stationlistmodelfilter.cpp

OTHER_FILES += qml/harbour-berail.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-berail.spec \
    rpm/harbour-berail.yaml \
    translations/*.ts \
    harbour-berail.desktop
