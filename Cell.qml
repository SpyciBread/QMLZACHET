import QtQuick

Item{
    id: container
    property alias cellColor: rectangle.color
    signal clicked(cellColor: color)

    width: 155; height: 100

    Rectangle {
        id: rectangle
        border.color: "black"
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: firstWindow.show()
    }
}