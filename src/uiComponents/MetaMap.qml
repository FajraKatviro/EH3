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
        x:50
        y:525
        text:"Зал героев"
        onClicked: game.screenRequested("HeroHall")
    }

    WorldLocationButton{
        id:cursedWell
        x:325
        y:800
        text:"Бездонный колодец"
    }

}
