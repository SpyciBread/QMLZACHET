import QtQuick
import QtQuick.Window
import QtQuick.Controls
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ListModel { id: dataModel }

    Column {

        spacing: 10
         ListView {
             width: 15

             height: 150
             model: dataModel
             //Column{
                 //spacing: 10
                 delegate: Day {
                        dataT: "123"
                 }
             //}


         }
         Text {
             id: addButton
             text: "Add item"
             MouseArea {
                 anchors.fill: parent
                 onClicked: dataModel.append({  })
             }
         }
    }

}
