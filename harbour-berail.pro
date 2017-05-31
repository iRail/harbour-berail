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

SOURCES += src/harbour-berail.cpp

OTHER_FILES += qml/harbour-berail.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-berail.spec \
    rpm/harbour-berail.yaml \
    translations/*.ts \
    harbour-berail.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-berail-de.ts

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
    qml/backend/__init__.py \
    qml/backend/app.py \
    qml/backend/lib/i486/requests-2.13.0-py3.4.egg-info/top_level.txt \
    qml/backend/lib/i486/requests-2.13.0-py3.4.egg-info/SOURCES.txt \
    qml/backend/lib/i486/requests-2.13.0-py3.4.egg-info/requires.txt \
    qml/backend/lib/i486/requests-2.13.0-py3.4.egg-info/PKG-INFO \
    qml/backend/lib/i486/requests-2.13.0-py3.4.egg-info/not-zip-safe \
    qml/backend/lib/i486/requests-2.13.0-py3.4.egg-info/installed-files.txt \
    qml/backend/lib/i486/requests-2.13.0-py3.4.egg-info/dependency_links.txt \
    qml/backend/lib/armv7l/requests-2.13.0-py3.4.egg-info/top_level.txt \
    qml/backend/lib/armv7l/requests-2.13.0-py3.4.egg-info/SOURCES.txt \
    qml/backend/lib/armv7l/requests-2.13.0-py3.4.egg-info/requires.txt \
    qml/backend/lib/armv7l/requests-2.13.0-py3.4.egg-info/PKG-INFO \
    qml/backend/lib/armv7l/requests-2.13.0-py3.4.egg-info/not-zip-safe \
    qml/backend/lib/armv7l/requests-2.13.0-py3.4.egg-info/installed-files.txt \
    qml/backend/lib/armv7l/requests-2.13.0-py3.4.egg-info/dependency_links.txt \
    qml/backend/lib/armv7l/requests/cacert.pem \
    qml/backend/lib/armv7l/requests/utils.py \
    qml/backend/lib/armv7l/requests/structures.py \
    qml/backend/lib/armv7l/requests/status_codes.py \
    qml/backend/lib/armv7l/requests/sessions.py \
    qml/backend/lib/armv7l/requests/models.py \
    qml/backend/lib/armv7l/requests/_internal_utils.py \
    qml/backend/lib/armv7l/requests/__init__.py \
    qml/backend/lib/armv7l/requests/hooks.py \
    qml/backend/lib/armv7l/requests/exceptions.py \
    qml/backend/lib/armv7l/requests/cookies.py \
    qml/backend/lib/armv7l/requests/compat.py \
    qml/backend/lib/armv7l/requests/certs.py \
    qml/backend/lib/armv7l/requests/auth.py \
    qml/backend/lib/armv7l/requests/api.py \
    qml/backend/lib/armv7l/requests/adapters.py \
    qml/backend/lib/armv7l/requests/packages/__init__.py \
    qml/backend/berail/__pycache__/__init__.cpython-34.pyc \
    qml/backend/berail/__pycache__/constants.cpython-34.pyc \
    qml/backend/berail/__pycache__/filemanager.cpython-34.pyc \
    qml/backend/berail/__pycache__/logger.cpython-34.pyc \
    qml/backend/berail/__pycache__/network.cpython-34.pyc \
    qml/backend/berail/__pycache__/sfos.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/_internal_utils.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/adapters.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/api.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/auth.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/certs.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/compat.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/cookies.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/exceptions.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/hooks.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/models.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/sessions.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/status_codes.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/structures.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/__pycache__/utils.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/big5freq.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/big5prober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/chardetect.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/chardistribution.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/charsetgroupprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/charsetprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/codingstatemachine.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/compat.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/constants.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/cp949prober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/escprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/escsm.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/eucjpprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/euckrfreq.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/euckrprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/euctwfreq.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/euctwprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/gb2312freq.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/gb2312prober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/hebrewprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/jisfreq.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/jpcntx.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/langbulgarianmodel.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/langcyrillicmodel.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/langgreekmodel.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/langhebrewmodel.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/langhungarianmodel.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/langthaimodel.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/latin1prober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/mbcharsetprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/mbcsgroupprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/mbcssm.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/sbcharsetprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/sbcsgroupprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/sjisprober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/universaldetector.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/chardet/__pycache__/utf8prober.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/idna/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/idna/__pycache__/codec.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/idna/__pycache__/compat.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/idna/__pycache__/core.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/idna/__pycache__/idnadata.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/idna/__pycache__/intranges.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/idna/__pycache__/uts46data.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/__pycache__/_collections.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/__pycache__/connection.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/__pycache__/connectionpool.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/__pycache__/exceptions.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/__pycache__/fields.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/__pycache__/filepost.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/__pycache__/poolmanager.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/__pycache__/request.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/__pycache__/response.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/contrib/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/contrib/__pycache__/appengine.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/contrib/__pycache__/ntlmpool.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/contrib/__pycache__/pyopenssl.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/contrib/__pycache__/socks.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/__pycache__/ordered_dict.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/__pycache__/six.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/backports/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/ssl_match_hostname/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/ssl_match_hostname/__pycache__/_implementation.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__pycache__/connection.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__pycache__/request.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__pycache__/response.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__pycache__/retry.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__pycache__/selectors.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__pycache__/ssl_.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__pycache__/timeout.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__pycache__/url.cpython-34.pyc \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__pycache__/wait.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/_internal_utils.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/adapters.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/api.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/auth.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/certs.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/compat.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/cookies.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/exceptions.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/hooks.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/models.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/sessions.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/status_codes.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/structures.cpython-34.pyc \
    qml/backend/lib/i486/requests/__pycache__/utils.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/big5freq.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/big5prober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/chardetect.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/chardistribution.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/charsetgroupprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/charsetprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/codingstatemachine.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/compat.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/constants.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/cp949prober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/escprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/escsm.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/eucjpprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/euckrfreq.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/euckrprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/euctwfreq.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/euctwprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/gb2312freq.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/gb2312prober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/hebrewprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/jisfreq.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/jpcntx.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/langbulgarianmodel.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/langcyrillicmodel.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/langgreekmodel.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/langhebrewmodel.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/langhungarianmodel.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/langthaimodel.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/latin1prober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/mbcharsetprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/mbcsgroupprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/mbcssm.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/sbcharsetprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/sbcsgroupprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/sjisprober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/universaldetector.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/chardet/__pycache__/utf8prober.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/idna/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/idna/__pycache__/codec.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/idna/__pycache__/compat.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/idna/__pycache__/core.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/idna/__pycache__/idnadata.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/idna/__pycache__/intranges.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/idna/__pycache__/uts46data.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/__pycache__/_collections.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/__pycache__/connection.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/__pycache__/connectionpool.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/__pycache__/exceptions.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/__pycache__/fields.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/__pycache__/filepost.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/__pycache__/poolmanager.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/__pycache__/request.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/__pycache__/response.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/contrib/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/contrib/__pycache__/appengine.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/contrib/__pycache__/ntlmpool.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/contrib/__pycache__/pyopenssl.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/contrib/__pycache__/socks.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/packages/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/packages/__pycache__/ordered_dict.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/packages/__pycache__/six.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/packages/backports/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/packages/ssl_match_hostname/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/packages/ssl_match_hostname/__pycache__/_implementation.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/util/__pycache__/__init__.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/util/__pycache__/connection.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/util/__pycache__/request.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/util/__pycache__/response.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/util/__pycache__/retry.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/util/__pycache__/selectors.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/util/__pycache__/ssl_.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/util/__pycache__/timeout.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/util/__pycache__/url.cpython-34.pyc \
    qml/backend/lib/i486/requests/packages/urllib3/util/__pycache__/wait.cpython-34.pyc \
    qml/backend/lib/i486/requests/cacert.pem \
    qml/backend/berail/__init__.py \
    qml/backend/berail/constants.py \
    qml/backend/berail/filemanager.py \
    qml/backend/berail/logger.py \
    qml/backend/berail/network.py \
    qml/backend/berail/sfos.py \
    qml/backend/lib/armv7l/requests/packages/chardet/__init__.py \
    qml/backend/lib/armv7l/requests/packages/chardet/big5freq.py \
    qml/backend/lib/armv7l/requests/packages/chardet/big5prober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/chardetect.py \
    qml/backend/lib/armv7l/requests/packages/chardet/chardistribution.py \
    qml/backend/lib/armv7l/requests/packages/chardet/charsetgroupprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/charsetprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/codingstatemachine.py \
    qml/backend/lib/armv7l/requests/packages/chardet/compat.py \
    qml/backend/lib/armv7l/requests/packages/chardet/constants.py \
    qml/backend/lib/armv7l/requests/packages/chardet/cp949prober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/escprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/escsm.py \
    qml/backend/lib/armv7l/requests/packages/chardet/eucjpprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/euckrfreq.py \
    qml/backend/lib/armv7l/requests/packages/chardet/euckrprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/euctwfreq.py \
    qml/backend/lib/armv7l/requests/packages/chardet/euctwprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/gb2312freq.py \
    qml/backend/lib/armv7l/requests/packages/chardet/gb2312prober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/hebrewprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/jisfreq.py \
    qml/backend/lib/armv7l/requests/packages/chardet/jpcntx.py \
    qml/backend/lib/armv7l/requests/packages/chardet/langbulgarianmodel.py \
    qml/backend/lib/armv7l/requests/packages/chardet/langcyrillicmodel.py \
    qml/backend/lib/armv7l/requests/packages/chardet/langgreekmodel.py \
    qml/backend/lib/armv7l/requests/packages/chardet/langhebrewmodel.py \
    qml/backend/lib/armv7l/requests/packages/chardet/langhungarianmodel.py \
    qml/backend/lib/armv7l/requests/packages/chardet/langthaimodel.py \
    qml/backend/lib/armv7l/requests/packages/chardet/latin1prober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/mbcharsetprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/mbcsgroupprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/mbcssm.py \
    qml/backend/lib/armv7l/requests/packages/chardet/sbcharsetprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/sbcsgroupprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/sjisprober.py \
    qml/backend/lib/armv7l/requests/packages/chardet/universaldetector.py \
    qml/backend/lib/armv7l/requests/packages/chardet/utf8prober.py \
    qml/backend/lib/armv7l/requests/packages/idna/__init__.py \
    qml/backend/lib/armv7l/requests/packages/idna/codec.py \
    qml/backend/lib/armv7l/requests/packages/idna/compat.py \
    qml/backend/lib/armv7l/requests/packages/idna/core.py \
    qml/backend/lib/armv7l/requests/packages/idna/idnadata.py \
    qml/backend/lib/armv7l/requests/packages/idna/intranges.py \
    qml/backend/lib/armv7l/requests/packages/idna/uts46data.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/contrib/__init__.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/contrib/appengine.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/contrib/ntlmpool.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/contrib/pyopenssl.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/contrib/socks.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/backports/__init__.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/ssl_match_hostname/__init__.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/ssl_match_hostname/_implementation.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/__init__.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/ordered_dict.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/packages/six.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/__init__.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/connection.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/request.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/response.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/retry.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/selectors.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/ssl_.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/timeout.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/url.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/util/wait.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/__init__.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/_collections.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/connection.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/connectionpool.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/exceptions.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/fields.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/filepost.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/poolmanager.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/request.py \
    qml/backend/lib/armv7l/requests/packages/urllib3/response.py \
    qml/backend/lib/i486/requests/packages/chardet/__init__.py \
    qml/backend/lib/i486/requests/packages/chardet/big5freq.py \
    qml/backend/lib/i486/requests/packages/chardet/big5prober.py \
    qml/backend/lib/i486/requests/packages/chardet/chardetect.py \
    qml/backend/lib/i486/requests/packages/chardet/chardistribution.py \
    qml/backend/lib/i486/requests/packages/chardet/charsetgroupprober.py \
    qml/backend/lib/i486/requests/packages/chardet/charsetprober.py \
    qml/backend/lib/i486/requests/packages/chardet/codingstatemachine.py \
    qml/backend/lib/i486/requests/packages/chardet/compat.py \
    qml/backend/lib/i486/requests/packages/chardet/constants.py \
    qml/backend/lib/i486/requests/packages/chardet/cp949prober.py \
    qml/backend/lib/i486/requests/packages/chardet/escprober.py \
    qml/backend/lib/i486/requests/packages/chardet/escsm.py \
    qml/backend/lib/i486/requests/packages/chardet/eucjpprober.py \
    qml/backend/lib/i486/requests/packages/chardet/euckrfreq.py \
    qml/backend/lib/i486/requests/packages/chardet/euckrprober.py \
    qml/backend/lib/i486/requests/packages/chardet/euctwfreq.py \
    qml/backend/lib/i486/requests/packages/chardet/euctwprober.py \
    qml/backend/lib/i486/requests/packages/chardet/gb2312freq.py \
    qml/backend/lib/i486/requests/packages/chardet/gb2312prober.py \
    qml/backend/lib/i486/requests/packages/chardet/hebrewprober.py \
    qml/backend/lib/i486/requests/packages/chardet/jisfreq.py \
    qml/backend/lib/i486/requests/packages/chardet/jpcntx.py \
    qml/backend/lib/i486/requests/packages/chardet/langbulgarianmodel.py \
    qml/backend/lib/i486/requests/packages/chardet/langcyrillicmodel.py \
    qml/backend/lib/i486/requests/packages/chardet/langgreekmodel.py \
    qml/backend/lib/i486/requests/packages/chardet/langhebrewmodel.py \
    qml/backend/lib/i486/requests/packages/chardet/langhungarianmodel.py \
    qml/backend/lib/i486/requests/packages/chardet/langthaimodel.py \
    qml/backend/lib/i486/requests/packages/chardet/latin1prober.py \
    qml/backend/lib/i486/requests/packages/chardet/mbcharsetprober.py \
    qml/backend/lib/i486/requests/packages/chardet/mbcsgroupprober.py \
    qml/backend/lib/i486/requests/packages/chardet/mbcssm.py \
    qml/backend/lib/i486/requests/packages/chardet/sbcharsetprober.py \
    qml/backend/lib/i486/requests/packages/chardet/sbcsgroupprober.py \
    qml/backend/lib/i486/requests/packages/chardet/sjisprober.py \
    qml/backend/lib/i486/requests/packages/chardet/universaldetector.py \
    qml/backend/lib/i486/requests/packages/chardet/utf8prober.py \
    qml/backend/lib/i486/requests/packages/idna/__init__.py \
    qml/backend/lib/i486/requests/packages/idna/codec.py \
    qml/backend/lib/i486/requests/packages/idna/compat.py \
    qml/backend/lib/i486/requests/packages/idna/core.py \
    qml/backend/lib/i486/requests/packages/idna/idnadata.py \
    qml/backend/lib/i486/requests/packages/idna/intranges.py \
    qml/backend/lib/i486/requests/packages/idna/uts46data.py \
    qml/backend/lib/i486/requests/packages/urllib3/contrib/__init__.py \
    qml/backend/lib/i486/requests/packages/urllib3/contrib/appengine.py \
    qml/backend/lib/i486/requests/packages/urllib3/contrib/ntlmpool.py \
    qml/backend/lib/i486/requests/packages/urllib3/contrib/pyopenssl.py \
    qml/backend/lib/i486/requests/packages/urllib3/contrib/socks.py \
    qml/backend/lib/i486/requests/packages/urllib3/packages/backports/__init__.py \
    qml/backend/lib/i486/requests/packages/urllib3/packages/ssl_match_hostname/__init__.py \
    qml/backend/lib/i486/requests/packages/urllib3/packages/ssl_match_hostname/_implementation.py \
    qml/backend/lib/i486/requests/packages/urllib3/packages/__init__.py \
    qml/backend/lib/i486/requests/packages/urllib3/packages/ordered_dict.py \
    qml/backend/lib/i486/requests/packages/urllib3/packages/six.py \
    qml/backend/lib/i486/requests/packages/urllib3/util/__init__.py \
    qml/backend/lib/i486/requests/packages/urllib3/util/connection.py \
    qml/backend/lib/i486/requests/packages/urllib3/util/request.py \
    qml/backend/lib/i486/requests/packages/urllib3/util/response.py \
    qml/backend/lib/i486/requests/packages/urllib3/util/retry.py \
    qml/backend/lib/i486/requests/packages/urllib3/util/selectors.py \
    qml/backend/lib/i486/requests/packages/urllib3/util/ssl_.py \
    qml/backend/lib/i486/requests/packages/urllib3/util/timeout.py \
    qml/backend/lib/i486/requests/packages/urllib3/util/url.py \
    qml/backend/lib/i486/requests/packages/urllib3/util/wait.py \
    qml/backend/lib/i486/requests/packages/urllib3/__init__.py \
    qml/backend/lib/i486/requests/packages/urllib3/_collections.py \
    qml/backend/lib/i486/requests/packages/urllib3/connection.py \
    qml/backend/lib/i486/requests/packages/urllib3/connectionpool.py \
    qml/backend/lib/i486/requests/packages/urllib3/exceptions.py \
    qml/backend/lib/i486/requests/packages/urllib3/fields.py \
    qml/backend/lib/i486/requests/packages/urllib3/filepost.py \
    qml/backend/lib/i486/requests/packages/urllib3/poolmanager.py \
    qml/backend/lib/i486/requests/packages/urllib3/request.py \
    qml/backend/lib/i486/requests/packages/urllib3/response.py \
    qml/backend/lib/i486/requests/packages/__init__.py \
    qml/backend/lib/i486/requests/__init__.py \
    qml/backend/lib/i486/requests/_internal_utils.py \
    qml/backend/lib/i486/requests/adapters.py \
    qml/backend/lib/i486/requests/api.py \
    qml/backend/lib/i486/requests/auth.py \
    qml/backend/lib/i486/requests/certs.py \
    qml/backend/lib/i486/requests/compat.py \
    qml/backend/lib/i486/requests/cookies.py \
    qml/backend/lib/i486/requests/exceptions.py \
    qml/backend/lib/i486/requests/hooks.py \
    qml/backend/lib/i486/requests/models.py \
    qml/backend/lib/i486/requests/sessions.py \
    qml/backend/lib/i486/requests/status_codes.py \
    qml/backend/lib/i486/requests/structures.py \
    qml/backend/lib/i486/requests/utils.py \
    qml/pages/components/LoadIndicator.qml \
    qml/pages/LiveboardPage.qml \
    rpm/harbour-berail.changes \
    qml/pages/js/disturbances.js \
    qml/pages/components/DisturbancesView.qml \
    translations/harbour-berail-nl.ts \
    qml/pages/DisturbancesPage.qml \
    qml/pages/SettingsPage.qml

RESOURCES += \
    qml/resources/resources.qrc
