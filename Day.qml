import QtQuick
import QtQuick.Window
import QtQuick.Controls

Page {
    id: root
    property alias pageText: pgText.text
    property alias buttonText: pgButton.text
    signal buttonClicked();

    Image{
        id: background
        width: parent.width
        height: parent.height
        opacity: 0.5
        fillMode: Image.PreserveAspectCrop
        source: "pics/background/winter.jpeg"
    }

    Button {
        id: pgButton
        anchors.left: parent.left
        anchors.top: parent.top

        onClicked: {
            root.buttonClicked();
        }
    }

    Text {
        id: pgText
        text: "Погода"
        anchors.top: pgButton.bottom
    }
}
