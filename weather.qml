import QtQuick
import QtQuick.Window
import QtQuick.Controls

//Poka
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
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

    function requestUser() {
        var xhr = new XMLHttpRequest();
        xhr.responseType = 'json';
        xhr.onreadystatechange = function() {
            answer.text = xhr.responseText
        }
        xhr.open("GET", "https://api.openweathermap.org/data/2.5/weather?lat=57.6299&lon=39.8737&appid=a78f421c8e7e9499067a9981dce4da3a");
        //xhr.setRequestHeader('Content-Type', 'X-Gismeteo-Token: 56b30cb255.3443075');
        //var body = encodeURIComponent("lat=57.6299&lon=39.8737&appid=a78f421c8e7e9499067a9981dce4da3a");
        xhr.send();
    }
}