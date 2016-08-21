import QtQuick 2.7

Item{
    id:metaMap

    Image{
        id:bg
        anchors.fill: parent
        source: "qrc:///images/mainMenu.png"
    }

    WorldLocationButton{
        id:hall
        x:parent.width * (50.0 / baseWidth)
        y:parent.height * (525.0 / baseHeight)
        text:"Зал героев"
        onClicked: game.screenRequested("HeroHall")
    }

    WorldLocationButton{
        id:cursedWell
        x:parent.width * (325.0 / baseWidth)
        y:parent.height * (800.0 / baseHeight)
        text:"Бездонный колодец"
        onClicked: game.screenRequested("AbysmalWell")
    }

}
