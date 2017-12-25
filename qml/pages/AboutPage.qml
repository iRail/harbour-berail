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
            spacing: Theme.paddingLarge

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
                //% "%0 will never collect any personal information about the user,"
                // "but this can't be guaranteed from any third-party company used in %0.\n"
                // "This application is released under GPLv3.
                // "The source code and the license is available in the Github repo of %0."
                text: qsTrId("berail-privacy-licensing-text").arg(sfos.appNamePretty)
            }

            //% "Developer & source code"
            SectionHeader { text: qsTrId("berail-developer-source") }

            GlassButton {
                link: "https://github.com/dylanvanassche"
                iconSource: "qrc:///icons/icon-github.png"
                iconText: "Dylan Van Assche"
            }

            GlassButton {
                link: "https://paypal.me/minitreintje"
                iconSource: "qrc:///icons/icon-paypal.png"
                //% "Donate with %1"
                iconText: qsTrId("berail-donate-with").arg("PayPal")
            }

            GlassButton {
                link: "https://github.com/iRail/harbour-berail"
                iconSource: "qrc:///icons/icon-code.png"
                //% "Source code"
                iconText: qsTrId("berail-source")
            }

            TextLabel {
                //% "%0 can be translated into your language but for that we need your help! You can translate this app on %1"
                text: qsTrId("berail-translations").arg(sfos.appNamePretty).arg("Transifex:")
            }

            GlassButton {
                link: "https://www.transifex.com/dylanvanassche/harbour-berail"
                iconSource: "qrc:///icons/icon-translate.png"
                //% "%0 project"
                iconText: qsTrId("berail-project").arg("Transifex")
            }

            //% "Powered by"
            SectionHeader { text: qsTrId("berail-powered-by") }

            GlassButton {
                link: "https://irail.be/"
                iconSource: "qrc:///icons/icon-irail.png"
                iconText: "iRail"
            }

            GlassButton {
                link: "https://fontawesome.io/"
                iconSource: "qrc:///icons/icon-fontawesome.png"
                iconText: "FontAwesome icons"
            }

            GlassButton {
                link: "https://twitter.com/eLtMosen"
                iconSource: "qrc:///icons/icon-twitter.png"
                //% "%0 icon by %1"
                iconText: qsTrId("berail-icon").arg(sfos.appNamePretty).arg("Timo Könnecke")
            }
        }
    }
}
