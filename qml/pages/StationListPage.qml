/*
  This file is part of BeRail.

  It's a modified version of the Jolla searchPage example included in the Sailfish SDK.
  The examples are released under the following license:

  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.
  You may use this file under the terms of BSD license as follows:
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: searchPage
    property string searchString
    property bool keepSearchFieldFocus
    signal finished(string station)
    onFinished: pageStack.pop()

    onSearchStringChanged: listModel.update()
    Component.onCompleted: listModel.update()

    Loader {
        anchors.fill: parent
        sourceComponent: listViewComponent
    }

    Column {
        id: headerContainer
        width: searchPage.width

        PageHeader { title: qsTr("Stations") }

        SearchField {
            id: searchField
            width: parent.width

            Binding {
                target: searchPage
                property: "searchString"
                value: searchField.text.toLowerCase().trim()
            }
        }
    }

    Component {
        id: listViewComponent
        SilicaListView {
            model: listModel
            anchors.fill: parent
            currentIndex: -1 // otherwise currentItem will steal focus
            header:  Item {
                id: header
                width: headerContainer.width
                height: headerContainer.height
                Component.onCompleted: headerContainer.parent = header
            }

            delegate: BackgroundItem {
                id: backgroundItem
                onClicked: finished(model.name)

                ListView.onAdd: AddAnimation {
                    target: backgroundItem
                }
                ListView.onRemove: RemoveAnimation {
                    target: backgroundItem
                }

                Label {
                    x: searchField.textLeftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: searchString.length > 0 ? (highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor)
                                                   : (highlighted ? Theme.highlightColor : Theme.primaryColor)
                    textFormat: Text.StyledText
                    text: Theme.highlightText(model.name, searchString, Theme.highlightColor)
                }
            }

            VerticalScrollDecorator {}

            Component.onCompleted: {
                if (keepSearchFieldFocus) {
                    searchField.forceActiveFocus()
                }
                keepSearchFieldFocus = false
            }
        }
    }

    ListModel {
        id: listModel

        // Localisation needs to be done
        // Static is needed to avoid load times
        property var stations: ['Aachen Hbf', 'Aalst', 'Aalst-Kerrebroek', 'Aalter', 'Aarschot', 'Aarsele', 'Acren', 'Agde', 'Aime-la-Plagne', 'Aiseau', 'Aix-en-Provence TGV', 'Albertville', 'Alken', 'Amay', 'Ampsin', 'Amsterdam CS', 'Andenne', 'Angleur', 'Annappes', 'Ans', 'Anseremme', 'Antibes', 'Antoing', 'Antwerp-Berchem', 'Antwerp-Central', 'Antwerp-East', 'Antwerp-Haven', 'Antwerp-Luchtbal', 'Antwerp-Noorderdokken', 'Antwerp-South', 'Anzegem', 'Appelterre', 'Arcaden/Arcades', 'Archennes', 'Arlon', 'Ascq', 'Asse', 'Assesse', 'Ath', 'Athus', 'Aubange', 'Auvelais', 'Avignon TGV', 'Aye', 'Aywaille', 'Aéroport Charles-de-Gaulle TGV', 'Baasrode-Zuid', 'Baisieux', 'Balegem-Dorp', 'Balegem-Zuid', 'Balen', 'Bambrugge', 'Barvaux', 'Bas-Oha', 'Basel', 'Basse-Wavre', 'Bastogne-Nord', 'Bastogne-Sud', 'Beauraing', 'Beernem', 'Beersel', 'Beervelde', 'Begijnendijk', 'Beignée', 'Bellem', 'Belsele', 'Beringen', 'Berlaar', 'Bertrange Strassen', 'Bertrix', 'Berzée', 'Beuzet', 'Beveren', 'Beverlo', 'Bierges-Walibi', 'Bierset-Awans', 'Bilzen', 'Binche', 'Bissegem', 'Blankenberge', 'Blanmont', 'Blaton', 'Bleret', 'Bockstael', 'Boechout', 'Bokrijk', 'Bomal', 'Booischot', 'Boom', 'Boondaal/Boondael', 'Boortmeerbeek', 'Bordet', 'Bornem', 'Bosvoorde/Boitsfort', 'Bourg-Saint-Maurice', 'Boussu', 'Bouwel', 'Bracquegnies', "Braine-l'Alleud", 'Braine-le-Comte', 'Bressoux', 'Brugelette', 'Brugge', 'Brugge-Sint-Pieters', 'Brussels Airport - Zaventem', 'Brussels-Central', 'Brussels-Chapelle/Brussels-Kapellekerk', 'Brussels-Congres', 'Brussels-Luxemburg/Brussels-Luxembourg', 'Brussels-North', 'Brussels-Schuman', 'Brussels-South/Brussels-Midi', 'Brussels-West', 'Buda', 'Buggenhout', 'Buizingen', 'Burst', 'Béziers', 'Callenelle', 'Cambron-Casteau', 'Cannes', 'Capellen', 'Carlsbourg', 'Carnieres', 'Ceroux-Mousty', 'Chambéry-Challes-les-Eaux', 'Chapelle-Dieu', 'Chapois', 'Charleroi-Ouest', 'Charleroi-Sud', 'Chastre', 'Château-de-Seilles', 'Châtelet', 'Chênée', 'Ciney', 'Clervaux', 'Colmar', 'Comblain-la-Tour', 'Comines', 'Coo', 'Couillet', 'Cour-sur-Heure', 'Courcelles-Motte', 'Courrière', 'Court-Saint-Étienne', 'Couvin', 'Croix Wasquehal', "Croix l'Allumette", 'Dave-Saint-Martin', 'De Hoek', 'De Panne', 'De Pinte', 'Deinze', 'Delta', 'Den Haag HS', 'Denderleeuw', 'Dendermonde', 'Diegem', 'Diepenbeek', "Diesdelle/Vivier d'Oie", 'Diest', 'Diksmuide', 'Dilbeek', 'Dinant', 'Dolhain-Gileppe', 'Dordrecht', 'Dortmund Hbf', 'Drauffelt', 'Drongen', 'Duffel', 'Duinbergen', 'Duisburg Hbf', 'Düsseldorf Flughafen Hbf', 'Düsseldorf Hbf', 'Ebbsfleet International', 'Ede', 'Eeklo', 'Eichem', 'Eijsden', 'Eine', 'Eke-Nazareth', 'Ekeren', 'Enghien', 'Engis', 'Eppegem', 'Erbisoeul', 'Erembodegem', 'Ernage', 'Erpe-Mere', 'Erps-Kwerps', 'Erquelinnes', 'Erquelinnes-Village', 'Esneux', 'Essen', 'Essen Hbf', 'Essene-Lombeek', 'Ettelbréck', 'Etterbeek', 'Eupen', 'Evere', 'Evergem', 'Ezemaal', 'Familleureux', 'Farciennes', 'Faux', 'Fexhe-le-Haut-Clocher', 'Flawinne', 'Flemalle-Grande', 'Flemalle-Haute', 'Fleurus', 'Floreffe', 'Florenville', 'Florival', 'Florée', 'Fontaine-Valmont', 'Forchies', 'Forrières', 'Fraipont', 'Frameries', 'Franchimont', 'Franière', 'Frankfurt am Main Airport', 'Frankfurt am Main Hbf', 'Froyennes', 'Galmaarden', 'Gastuche', 'Gavere-Asper', 'Gedinne', 'Geel', 'Gembloux', 'Gendron-Celles', 'Genk', 'Genly', 'Gentbrugge', 'Genval', 'Geraardsbergen', 'Ghent-Dampoort', 'Ghent-Sint-Pieters', 'Ghlin', 'Glons', 'Godarville', 'Godinne', 'Gontrode', 'Gouvy', 'Gouy-lez-Pieton', 'Graide', 'Groenendaal', 'Groot-Bijgaarden', 'Grupont', 'Haacht', 'Haaltert', 'Habay', 'Hainin', 'Halanzy', 'Halle', 'Ham-sur-Heure', 'Ham-sur-Sambre', 'Hambos', 'Hamoir', 'Hamont', 'Hansbeke', 'Harchies', 'Harelbeke', 'Haren', 'Haren-Sud/Haren-Zuid', 'Hasselt', 'Haute-Flône', 'Haute-Picardie TGV', 'Haversin', 'Havre', 'Heide', 'Heist', 'Heist-op-den-Berg', 'Heizijde', 'Hellemmes', 'Hemiksem', 'Hennuyères', 'Herent', 'Herentals', 'Hergenrath', 'Herne', 'Herseaux', 'Herstal', 'Herzele', 'Heusden', 'Hever', 'Heverlee', 'Hillegem', 'Hoboken-Polder', 'Hoeilaart', 'Hofstade', 'Holleken', 'Hony', 'Houraing', 'Hourpes', 'Houyet', 'Hove', 'Huizingen', 'Huy', 'Iddergem', 'Idegem', 'Ieper', 'Ingelmunster', 'Izegem', 'Jambes', 'Jambes-Est', 'Jamioulx', 'Jemappes', 'Jemelle', 'Jemeppe-sur-Meuse', 'Jemeppe-sur-Sambre', 'Jette', 'Jurbeke', 'Juslenville', 'Kalmthout', 'Kapelle-op-den-Bos', 'Kapellen', 'Kautebaach', 'Kessel', 'Kiewit', 'Kijkuit', 'Klengbetten', 'Knokke', 'Koksijde', 'Kontich', 'Kortemark', 'Kortenberg', 'Kortrijk', 'Kwatrecht', 'Köln Hbf', 'La Hulpe', 'La Louvière-Centre', 'La Louvière-Sud', 'La Roche (Brabant)', 'Labuissière', 'Landegem', 'Landelies', 'Landen', 'Landry', 'Landskouter', 'Langdorp', 'Le Campinaire', 'Lebbeke', 'Lede', 'Leignon', 'Leman', 'Lembeek', 'Lens', 'Leopoldsburg', 'Les Arcs - Draguignan', 'Lessines', 'Leuven', 'Leuze', 'Leval', 'Lezennes', 'Libramont', 'Lichtervelde', 'Liedekerke', 'Lier', 'Lierde', 'Liers', 'Ligny', 'Lille Europe', 'Lille Flandres', 'Lillois', 'Limal', 'Limburg Süd', 'Linkebeek', 'Lissewege', 'Liège-Guillemins', 'Liège-Jonfosse', 'Liège-Palais', 'Lobbes', 'Lodelinsart', 'Lokeren', 'Lommel', 'Londerzeel', 'London Saint Pancras International', 'Lonzée', 'Lot', 'Louvain-la-Neuve-Université', 'Lustin', 'Luttre', 'Lyon Part Dieu TGV', 'Lyon-Perrache TGV', 'Lyon-Saint Exupéry TGV', 'Lëtzebuerg', 'Maastricht', 'Maastricht Randwyck', 'Maffle', 'Malderen', 'Mamer', 'Mamer-Lycée', 'Manage', 'Marbehan', 'Marche-en-Famenne', 'Marche-les-Dames', 'Marche-lez-Écaussinnes', 'Marchienne-Zone', 'Marchienne-au-Pont', 'Maria-Aalter', 'Mariembourg', 'Marloie', 'Marne-la-Vallée - Chessy', 'Marseille-Saint-Charles', 'Masnuy-Saint-Pierre', 'Maubray', 'Mazy', 'Mechelen', 'Mechelen-Nekkerspoel', 'Meiser', 'Melkouwen', 'Melle', 'Melreux-Hotton', 'Melsele', 'Menen', 'Merchtem', 'Merelbeke', 'Merode', 'Mersch', 'Messancy', 'Metz', 'Mevergnies-Attre', 'Michelau', 'Milmort', 'Moensberg', 'Mol', 'Mollem', 'Momalle', 'Mons', 'Mont-Saint-Guibert', 'Montpellier', 'Moortsele', 'Morlanwelz', 'Mortsel', 'Mortsel-Deurnesteenweg', 'Mortsel-Liersesteenweg', 'Mortsel-Oude God', 'Mouscron', 'Moustier', 'Mouterij', 'Moûtiers-Salins-Brides-les-Bai', 'Muizen', 'Mulhouse', 'Munkzwalm', 'Méry', 'Namur', 'Namêche', 'Naninne', 'Narbonne', 'Natoye', 'Neerpelt', 'Neerwinden', 'Nessonvaux', 'Neufchâteau', 'Neufvilles', 'Nice Ville', 'Niel', 'Nieuwkerken-Waas', 'Nijlen', 'Nimy', 'Ninove', 'Nivelles', 'Noorderkempen', 'Nossegem', 'Nîmes', 'Obaix-Buzet', 'Obourg', 'Okegem', 'Olen', 'Oostende', 'Oostkamp', 'Opwijk', 'Ottignies', 'Oud-Heverlee', 'Oudegem', 'Oudenaarde', 'Overpelt', 'Paliseul', 'Papignies', 'Paris Nord', 'Pepinster', 'Pepinster-Cité', 'Perpignan', 'Philippeville', 'Piéton', 'Poix-Saint-Hubert', 'Pont de Bois', 'Pont-de-Seraing', 'Pont-à-Celles', 'Poperinge', 'Poulseur', 'Profondsart', 'Pry', 'Puurs', 'Pécrot', 'Péruwelz', 'Quaregnon', 'Quevy', 'Quievrain', 'Rebaix', 'Remicourt', 'Rhisnes', 'Rivage', 'Rixensart', 'Rodange', 'Roeselare', 'Ronet', 'Ronse', 'Roosendaal', 'Rotterdam CS', 'Roubaix', 'Roux', 'Ruisbroek', 'Ruisbroek-Sauvegarde', 'Saint-Denis-Bovesse', 'Saint-Ghislain', 'Saint-Louis-Haut-Rhin', 'Saint-Raphaël-Valescure', 'Sart-Bernard', 'Saverne', 'Schaarbeek/Schaerbeek', 'Scheldewindeke', 'Schelle', 'Schellebelle', 'Schendelbeke', 'Schiphol', 'Schoonaarde', 'Schulen', 'Sclaigneaux', 'Sclessin', 'Selestat', 'Serskamp', 'Siegburg', 'Silly', 'Simonis', 'Sinaai', 'Sint-Agatha-Berchem/Berchem-Sainte-Agathe', 'Sint-Denijs-Boekel', 'Sint-Genesius-Rode', 'Sint-Gillis-Dendermonde', 'Sint-Job', 'Sint-Joris-Weert', 'Sint-Katelijne-Waver', 'Sint-Mariaburg', 'Sint-Martens-Bodegem', 'Sint-Niklaas', 'Sint-Truiden', 'Sleidinge', 'Soignies', 'Solre-sur-Sambre', 'Spa', 'Spa-Géronstère', 'Statte', 'Stockem', 'Strasbourg', 'Sy', 'Sète', 'Tamines', 'Temse', 'Terhagen', 'Ternat', 'Testelt', 'Theux', 'Thieu', 'Thionville', 'Thuin', 'Thulin', 'Thurn en Taxis', 'Tielen', 'Tielt', 'Tienen', 'Tilff', 'Tilly', 'Tollembeek', 'Tongeren', 'Torhout', 'Toulon', 'Tourcoing', 'Tournai', 'Trois-Ponts', 'Troisvierges', 'Trooz', 'Tubize', 'Turnhout', 'Ukkel-Kalevoet/Uccle-Calevoet', 'Ukkel-Stalle/Uccle-Stalle', 'Valence TGV', 'Veltem', 'Vertrijk', 'Verviers-Central', 'Verviers-Palais', 'Veurne', 'Viane-Moerbeke', 'Vichte', 'Vielsalm', 'Vijfhuizen', 'Ville-Pommerœul', 'Villers-la-Ville', 'Vilvoorde', 'Virton', 'Visé', 'Viville', 'Voroux', 'Vorst-Oost/Forest-Est', 'Vorst-Zuid/Forest-Midi', 'Waarschoot', 'Walcourt', 'Waregem', 'Waremme', 'Waterloo', 'Watermaal/Watermael', 'Wavre', 'Weerde', 'Welkenraedt', 'Welle', 'Wervik', 'Wespelaar-Tildonk', 'Wetteren', 'Wevelgem', 'Wezemaal', 'Wichelen', 'Wijgmaal', 'Wildert', 'Willebroek', 'Wilwerwiltz', 'Wolfstee', 'Wondelgem', 'Yves-Gomezée', 'Yvoir', 'Zandbergen', 'Zaventem', 'Zedelgem', 'Zeebrugge-Dorp', 'Zeebrugge-Strand', 'Zele', 'Zellik', 'Zichem', 'Zingem', 'Zolder', 'Zonhoven', 'Zottegem', 'Zwankendamme', 'Zwijndrecht', 'Ecaussinnes']


        function update() {
            var filteredStations = stations.filter(function (station) { return station.toLowerCase().indexOf(searchString) !== -1 })

            var station
            var found
            var i

            // helper objects that can be quickly accessed
            var filteredStationObject = new Object
            for (i = 0; i < filteredStations.length; ++i) {
                filteredStationObject[filteredStations[i]] = true
            }
            var existingStationObject = new Object
            for (i = 0; i < count; ++i) {
                station = get(i).name
                existingStationObject[station] = true
            }

            // remove items no longer in filtered set
            i = 0
            while (i < count) {
                station = get(i).name
                found = filteredStationObject.hasOwnProperty(station)
                if (!found) {
                    remove(i)
                } else {
                    i++
                }
            }

            // add new items
            for (i = 0; i < filteredStations.length; ++i) {
                station = filteredStations[i]
                found = existingStationObject.hasOwnProperty(station)
                if (!found) {
                    // for simplicity, just adding to end instead of corresponding position in original list
                    append({ "name": station})
                }
            }
        }
    }
}
