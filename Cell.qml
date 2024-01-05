import QtQuick

Item{
    id: container
    property alias cellColor: rectangle.color
    signal clicked(cellColor: color)

    width: 160; height: 100

    Rectangle {
        id: rectangle
        border.color: "black"
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: container.clicked(container.cellColor)
    }
}