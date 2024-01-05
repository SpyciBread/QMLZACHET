import QtQuick
import QtQuick.Window
import QtQuick.Controls

//Poka
Window {
    id: mainWindow
    visible: true
    width: 480
    height: 640
    title: qsTr("wether app")

    Image{
        id: background
        width: 480
        height: 640
        opacity: 0.5
        fillMode: Image.PreserveAspectCrop
        source: "pics/background/winter.jpeg"
    }

    ScrollView {
        id: scrollView
        width: parent.width
        height: parent.height

            Column{
                spacing: 10

                Text {
                    id: cityState
                    //anchors.horizontalCenter: parent.horizontalCenter
                    opacity: 1
                    text: "Ярославль Россия"
                    font.family: "Helvetica"
                    font.pointSize: 24
                    color: "black"
                }

                Button {
                    id: buttonUser
                    text: "Запросить пользователей"
                    onClicked: {
                        requestUser();
                    }
                }

                Cell { cellColor: "white"; onClicked: cityState.color = cellColor }

                Label {
                    id: answer
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: ""
                    font.family: "Helvetica"
                    font.pointSize: 10
                    color: "black"
                }
        }


    }

    function decodeJson(jsonData) {
        var list = jsonData.forecasts;
        var decodedJson = "";
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
            decodedJson = decodedJson +
                "Дата: " + date + " \n" +
                "Перепад температур: min: " + minT + " max: " + maxT+ " \n" +
                "Направление ветра: " + directionWind + " \n" +
                "Скорость ветра: " + speedWind + "м/с \n" +
                "Влажность: " + vlaznost + "% \n" +
                "Давление: " + davlenie + "мм рт.ст. \n" +
                "Предупреждение: " + alert + "\n\n";
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
            answer.text = jsonString;
        }

        xhr.open("GET", "https://api.weather.yandex.ru/v2/forecast?lat=57.6299&lon=39.8737&lang=ru_RU&limit=7&hours=true");
        xhr.setRequestHeader("X-Yandex-API-Key", "b8dc3c68-10b0-4be5-ab3c-4513bd33a7b6");
        xhr.send();
    }
}
