import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: mainWindow
    signal signalExit
    visible: true
    width: 900
    height: 700
    title: qsTr("Weather app")

    ScrollView {
        id: scrollView
        anchors.fill: parent

        ListModel {
            id: dataModel

        }

        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: mainPage
        }

        Page {
        id: mainPage
        visible: true

            Image{
                id: background
                width: parent.width
                height: parent.height
                opacity: 0.5
                fillMode: Image.PreserveAspectCrop
                source: "pics/background/winter.jpeg"
            }

            Row{
                id: titleRow
                spacing: 10

                anchors.left: parent.left
                anchors.top: parent.top

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

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                width: 760; height: 250

                id: grid

                cellWidth: 190
                cellHeight: 140

                model: dataModel
                delegate: Cell {

                    cellColor: "white"; cellText: model.text; dayInf: model.hoursText; cellImage: model.textIcon; onClicked: {
                        stackView.push(pageDay);
                        pageDay.pageText = dayInf;
                    }

                }
                flow: GridView.FlowLeftToRight
                snapMode: GridView.SnapToRow
                highlight: Rectangle { color: "lightblue"; radius: 5 }
            }


        }

        Day {
            id: pageDay
            visible: false
            buttonText: "Назад"
            pageText: "Погода"
            onButtonClicked: {
                stackView.pop();
            }
        }
    }

    onSignalExit: {
        mainWindow.close()
    }

    function decodeJson(jsonData) {
        var list = jsonData.forecasts;
        var decodedJson = "";
        var hoursInfo = "";
        var i = 0;

        list.forEach(function(item) {

            var date = item.date;

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
            var tmpMax = -100;
            var tmpMin = 100;
            var maxT = tmpMax;
            var minT = tmpMin;

            item.hours.forEach(function(itemDay) {
                var directionWind2 = itemDay.wind_dir;
                if (directionWind2 === "nw") {
                    directionWind2 = "Северо-западное"
                } else if (directionWind2 === "n") {
                    directionWind2 = "Северное"
                } else if (directionWind2 === "ne") {
                    directionWind2 = "Северо-восточное"
                } else if (directionWind2 === "e") {
                    directionWind2 = "Восточное"
                } else if (directionWind2 === "se") {
                    directionWind2 = "Юго-восточное"
                } else if (directionWind2 === "s") {
                    directionWind2 = "Южное"
                } else if (directionWind2 === "sw") {
                    directionWind2 = "Юго-западное"
                } else if (directionWind2 === "w") {
                    directionWind2 = "Западное"
                } else {
                    directionWind2 = "Штиль"
                }

                hoursInfo = hoursInfo + "Час: " + itemDay.hour +
                    " | Температура: "+ itemDay.temp +" °C"+
                    " | Влажность: "+ itemDay.humidity + "%" +
                    " | Давление: "+ itemDay.pressure_mm + " мм рт. ст" +
                    " | Скорость ветра: "+ itemDay.wind_speed + " м/с" +
                    " | Направление ветра: "+ directionWind2 + " | <a><img src='https://yastatic.net/weather/i/icons/funky/dark/"+itemDay.icon+".svg'></a> <br/>";


                if(itemDay.temp <= tmpMin){
                    minT = itemDay.temp;
                    tmpMin = itemDay.temp;
                }

                if(itemDay.temp >= tmpMax){
                    maxT = itemDay.temp;
                    tmpMax = itemDay.temp;
                }

            });
            if(tmpMin === 100){
                if(item.parts.day.temp_min < item.parts.night.temp_min){
                    var minT = item.parts.day.temp_min;
                }
                else{
                    var minT = item.parts.night.temp_min;
                }
            }

            if(tmpMax === -100){
                if(item.parts.day.temp_max > item.parts.night.temp_max){
                    var maxT = item.parts.day.temp_max;
                }
                else{
                    var maxT = item.parts.night.temp_max;
                }
            }

            decodedJson =
                "Дата: " + date + " \n" +
                "Перепад температур: " + minT + "|" + maxT +" (°C)"+ " \n" +
                "Направление ветра: " + directionWind + " \n" +
                "Скорость ветра: " + speedWind + " м/с \n" +
                "Влажность: " + vlaznost + "% \n" +
                "Давление: " + davlenie + " мм рт.ст. \n";
                //"Предупреждение: " + alert + "\n\n";



                if(typeof dataModel.get(6) === "undefined"){
                    dataModel.append({ text: decodedJson,
                    textIcon: "https://yastatic.net/weather/i/icons/funky/dark/" + item.parts.day.icon + ".svg",
                    hoursText: hoursInfo
                     });
                    hoursInfo = "";
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

        xhr.open("GET", "https://api.weather.yandex.ru/v2/forecast?lat=57.6299&lon=39.8737&lang=ru_RU&limit=7");
        xhr.setRequestHeader("X-Yandex-API-Key", "b8dc3c68-10b0-4be5-ab3c-4513bd33a7b6");
        xhr.send();
    }
}




