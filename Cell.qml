import QtQuick

Item{
    id: container
    property alias cellColor: rectangle.color
    property alias cellText: txt.text
    property alias cellImage: image.source

    signal clicked()

    width: 180; height: 130


    Rectangle {
        id: rectangle
        border.color: "black"
        anchors.fill: parent

        Image {
            id: image
            source: ""
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalTop
        }

        Text {
            id: txt
            text: "asdf"
            font.family: "Helvetica"
            color: "black"
            font.pointSize: 7
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            container.clicked();
        }
    }
}
