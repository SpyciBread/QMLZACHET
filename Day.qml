import QtQuick
import QtQuick.Controls
import QtQuick.Window

Window {
    id: anotherWindow
    signal signalExit
    width:480
    height:320

    Button {
        text: qsTr("Главное окно")
        width: 180
        height: 50
        anchors.centerIn: parent
        onClicked: {
            anotherWindow.signalExit()
        }
    }
}