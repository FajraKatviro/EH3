import QtQuick 2.0

Rectangle {
    id:btn
    width:100
    height:100
    color:"lightblue"

    property alias source:image.source
    property alias text:txt.text
    signal clicked

    Image{
        id:image
        anchors.fill: parent
        Text{
            id:txt
            anchors.fill: parent
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: btn.clicked()
    }
}

