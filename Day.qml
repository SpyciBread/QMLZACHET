import QtQuick

Item{
    id: testDay
    property alias dataTest: dataText.text
    width: 180; height: 130
    Text{
        id: dataText
        text: "12"

    }
}

