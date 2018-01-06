/*
*   This file is part of BeRail.
*
*   BeRail is free software: you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation, either version 3 of the License, or
*   (at your option) any later version.
*
*   BeRail is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with BeRail.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2
import Sailfish.Silica 1.0
import Harbour.BeRail.SFOS 1.0
import "../components"

Page {
    SFOS {
        id: sfos
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingMedium

            //% "About %0 V%1"
            PageHeader { title: qsTrId("berail-version").arg(sfos.appNamePretty).arg(sfos.appVersion) }

            //% "What's %0 ?"
            SectionHeader { text: qsTrId("berail-what-is").arg(sfos.appNamePretty) }

            TextLabel {
                //% "%0 is an opensource application to plan your NMBS/SNCB railway journeys on your Sailfish OS smartphone!"
                text: qsTrId("berail-what-is-text").arg(sfos.appNamePretty)
            }

            //% "Privacy & licensing"
            SectionHeader { text: qsTrId("berail-privacy-licensing") }

            TextLabel {
                //% "%0 will never collect any personal information about the user, but this can't be guaranteed from any third-party company used in %0. This application is released under GPLv3. The source code and the license is available in the Github repo of %0."
                text: qsTrId("berail-privacy-licensing-text").arg(sfos.appNamePretty)
            }

            //% "Developer & source code"
            SectionHeader { text: qsTrId("berail-developer-source") }

            GlassButton {
                link: "https://github.com/dylanvanassche"
                source: "qrc:///icons/icon-github.png"
                text: "Dylan Van Assche"
            }

            GlassButton {
                link: "https://paypal.me/minitreintje"
                source: "qrc:///icons/icon-paypal.png"
                //% "Donate with %0"
                text: qsTrId("berail-donate-with").arg("PayPal")
            }

            GlassButton {
                link: "https://github.com/iRail/harbour-berail"
                source: "qrc:///icons/icon-code.png"
                //% "Source code"
                text: qsTrId("berail-source")
            }

            //% "Translations"
            SectionHeader { text: qsTrId("berail-translations") }

            TextLabel {
                //% "%0 can be translated into your language but for that we need your help! You can translate this app on %1"
                text: qsTrId("berail-translations-text").arg(sfos.appNamePretty).arg("Transifex:")
            }

            GlassButton {
                link: "https://www.transifex.com/dylanvanassche/harbour-berail"
                source: "qrc:///icons/icon-translate.png"
                //% "%0 project"
                text: qsTrId("berail-translations-project").arg("Transifex")
            }

            //% "Powered by"
            SectionHeader { text: qsTrId("berail-powered-by") }

            GlassButton {
                link: "https://irail.be/"
                source: "qrc:///icons/icon-irail.png"
                text: "iRail"
            }

            GlassButton {
                link: "https://fontawesome.io/"
                source: "qrc:///icons/icon-fontawesome.png"
                text: "FontAwesome icons"
            }

            GlassButton {
                link: "https://twitter.com/eLtMosen"
                source: "qrc:///icons/icon-twitter.png"
                //% "%0 icon by %1"
                text: qsTrId("berail-powered-by-icon").arg(sfos.appNamePretty).arg("Timo Könnecke")
            }
        }
    }
}
