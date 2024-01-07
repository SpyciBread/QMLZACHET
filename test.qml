import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: mainWindow
    signal signalExit
    visible: true
    width: 480
    height: 640
    title: qsTr("weather app")

    Column {
        spacing: 10

        ListModel {
            id: cellModel

            ListElement{
                cellColor: "white"
                cellText: ""
                cellImage: ""
            }
        }

        ListView {
            id: listView
            anchors.fill: parent
            model: cellModel
            delegate: Column {
                id: column
                Row {
                    id: row1
                    Cell { id: cell1; cellColor: model.cellColor; cellText: model.cellText; cellImage: model.cellImage; onClicked: firstWindow.show() }
                    Cell { cellColor: model.cellColor; cellText: model.cellText; cellImage: model.cellImage; onClicked: firstWindow.show() }
                    Cell { cellColor: model.cellColor; cellText: model.cellText; cellImage: model.cellImage; onClicked: firstWindow.show() }
                }
                Row {
                    id: row2
                    Cell { cellColor: model.cellColor; cellText: model.cellText; cellImage: model.cellImage; onClicked: firstWindow.show() }
                    Cell { cellColor: model.cellColor; cellText: model.cellText; cellImage: model.cellImage; onClicked: firstWindow.show() }
                    Cell { cellColor: model.cellColor; cellText: model.cellText; cellImage: model.cellImage; onClicked: firstWindow.show() }
                }
            }
        }

        Cell { cellColor: "white"; cellText: ""; cellImage: ""; onClicked: firstWindow.show() }

        Button {
            id: buttonUser
            text: "Тест"
            onClicked: {
               //listFunction();
               cellModel.append({});
            }
        }
    }


    function listFunction(){
        var str = "Hello1 \n\n Hello2 \n\n Hello3 \n\n Hello4 \n\n Hello5 \n\n Hello6";
        var list = str.split("\n\n");

        listView.column.row1.cell1cellText = list[0];

        cell1.cellText = list[0];
        cell2.cellText = list[1];
        cell3.cellText = list[2];
        cell4.cellText = list[3];
        cell5.cellText = list[4];
        cell6.cellText = list[5];
    }
}


