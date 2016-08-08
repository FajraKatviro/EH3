import QtQuick 2.0

import "../coreComponents"

Rectangle {
    id:heroView
    property Hero hero
    property alias text:txt.text
    property alias image:img.source
    anchors{
        left:parent.left
        right:parent.right
    }
    height:100
    color:"orange"
    Image{
        id:img
        anchors.fill: parent
    }

    Text{
        id:txt
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea{
        anchors.fill: parent
        onClicked: heroView.ListView.view.currentIndex=index
    }
}

