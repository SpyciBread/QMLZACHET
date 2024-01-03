import QtQuick
import QtQuick.Window
import QtQuick.Controls

//Privet
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ScrollView {
        id: scrollView
        width: parent.width
        height: parent.height

        Column {
            spacing: 10
            Button {
                id: buttonUser
                text: "Запросить пользователей"
                onClicked: {
                    requestUser();
                }
            }

            Label {
                id: answer
                anchors.horizontalCenter: parent.horizontalCenter
                text: "a"
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
                "Дата: " + date + " " +
                "Перепад температур: min: " + minT + " max: " + maxT+ " " +
                "Направление ветра: " + directionWind + " " +
                "Скорость ветра: " + speedWind + "м/с " +
                "Влажность: " + vlaznost + "% " +
                "Давление: " + davlenie + "мм рт.ст. " +
                "Предупреждение: " + alert + "\n";
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
