import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: mainWindow
    signal signalExit
    visible: true
    width: 640
    height: 480
    title: qsTr("weather app")

    Image{
        id: background
        width: parent.width
        height: parent.height
        opacity: 0.5
        fillMode: Image.PreserveAspectCrop
        source: "pics/background/winter.jpeg"
    }
    ScrollView {
        id: scrollView
        width: parent.width
        height: parent.height
        ListModel {
            id: dataModel

        }

        Column{
            spacing: 10

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter


            Row{
                id: titleRow
                spacing: 10

                Image{
                   source: "pics/icons/gerbYar.png"
                    width: 75
                    height: 110

                }

                Text {
                    id: cityState
                    anchors.verticalCenter: titleRow.verticalCenter
                    //verticalAlignment: cityState.AlignCenter
                    opacity: 1
                    text: "Ярославль Россия"
                    font.family: "Helvetica"
                    font.pointSize: 24
                    color: "black"

                    Component.onCompleted: {
                        requestUser();
                    }
                }
            }

            GridView {

                anchors.left: titleRow.horizontalCenter

                width: 760; height: 250

                id: grid

                cellWidth: 190
                cellHeight: 140

                model: dataModel
                delegate: Cell {
                    cellColor: "white"; cellText: model.text; cellImage: model.textIcon; onClicked: firstWindow.close()
                }
                flow: GridView.FlowLeftToRight
                snapMode: GridView.SnapToRow
                highlight: Rectangle { color: "lightblue"; radius: 5 }
            }

        }


    }

    onSignalExit: {
        mainWindow.close()
    }

    function decodeJson(jsonData) {
        var list = jsonData.forecasts;
        var decodedJson = "";
        var i = 0;

        list.forEach(function(item) {

            var date = item.date;
            var minT = item.parts.night_short.temp;
            var maxT = item.parts.day.temp_max;
            var directionWind = item.parts.day.wind_dir;
            if (directionWind === "nw") {
                directionWind = "Северо-западное"
            } else if (directionWind === "n") {
                directionWind = "Северное"
            } else if (directionWind === "ne") {
                directionWind = "Северо-восточное"
            } else if (directionWind === "e") {
                directionWind = "Восточное"
            } else if (directionWind === "se") {
                directionWind = "Юго-восточное"
            } else if (directionWind === "s") {
                directionWind = "Южное"
            } else if (directionWind === "sw") {
                directionWind = "Юго-западное"
            } else if (directionWind === "w") {
                directionWind = "Западное"
            } else {
                directionWind = "Штиль"
            }
            var speedWind = item.parts.day.wind_speed;
            var vlaznost = item.parts.day.humidity;
            var davlenie = item.parts.day.pressure_mm;
            var alert = item.parts.day.condition;

            decodedJson =
                "Дата: " + date + " \n" +
                "Перепад температур: min: " + minT + " max: " + maxT+ " \n" +
                "Направление ветра: " + directionWind + " \n" +
                "Скорость ветра: " + speedWind + "м/с \n" +
                "Влажность: " + vlaznost + "% \n" +
                "Давление: " + davlenie + "мм рт.ст. \n";
                //"Предупреждение: " + alert + "\n\n";

                if(typeof dataModel.get(6) === "undefined"){
                    dataModel.append({ text: decodedJson,
                    textIcon: "https://yastatic.net/weather/i/icons/funky/dark/" + item.parts.day.icon + ".svg" });
                }

            i++;
        });

        return decodedJson;
        //return JSON.stringify(list, null, 2);
    }

    function requestUser() {
        var xhr = new XMLHttpRequest();
        xhr.responseType = 'json';
        xhr.onreadystatechange = function() {
            var jsonResponse = JSON.parse(xhr.responseText);
            var jsonString = decodeJson(jsonResponse);
        }

        xhr.open("GET", "https://api.weather.yandex.ru/v2/forecast?lat=57.6299&lon=39.8737&lang=ru_RU&limit=7&hours=true");
        xhr.setRequestHeader("X-Yandex-API-Key", "b8dc3c68-10b0-4be5-ab3c-4513bd33a7b6");
        xhr.send();
    }
}
