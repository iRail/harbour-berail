import QtQuick 2.2
import Sailfish.Silica 1.0
import "./components"

Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: aboutColumn.height

        VerticalScrollDecorator {}

        Column {
            id: aboutColumn
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader { title: qsTr("About") }

            SectionHeader { text: qsTr("What's") + " BeRail?" }
            TextLabel { labelText: "BeRail " + qsTr("is an opensource application to plan your NMBS/SNCB railway journeys on your Sailfish OS smartphone!") }

            SectionHeader { text: qsTr("Privacy & licensing") }
            TextLabel { labelText: "BeRail " + qsTr("will never collect any personal information about the user, but this can't be guaranteed from any third-party company used in") + " BeRail." }
            TextLabel { labelText: qsTr("This application is released under GPLv3. The source code and the license is available in the Github repo of") +  " BeRail." }

            SectionHeader { text: qsTr("Developer & source code") }
            GlassButton { link: "https://github.com/modulebaan"; iconSource: "qrc:///icons/icon-github.png"; iconText: "Dylan Van Assche"; itemScale: 0.75 }
            GlassButton { link: "https://paypal.me/minitreintje"; iconSource: "qrc:///icons/icon-paypal.png"; iconText: qsTr("Donate with Paypal"); itemScale: 0.75 }
            GlassButton { link: "https://github.com/iRail/harbour-berail"; iconSource: "qrc:///icons/icon-code.png"; iconText: qsTr("Source code"); itemScale: 0.75 }
            TextLabel { labelText: "BeRail " + qsTr("can be translated into your language but for that we need your help! You can translate this app on") + " Transifex:" }
            GlassButton { link: "https://www.transifex.com/dylanvanassche/harbour-berail"; iconSource: "qrc:///icons/icon-translate.png"; iconText: "Transifex " + qsTr("project"); itemScale: 0.75 }

            SectionHeader { text: qsTr("Powered by") }
            GlassButton { link: "http://fontawesome.io/"; iconSource: "qrc:///icons/icon-fontawesome.png"; iconText: "FontAwesome icons"; itemScale: 0.75 }
            GlassButton { link: "http://irail.be/"; iconSource: "qrc:///icons/icon-irail.png"; iconText: "iRail"; itemScale: 0.75 }
        }
    }
}
