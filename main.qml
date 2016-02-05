import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

import eh3 1.0

Window {
    visible: true
    width:800
    height:600

    Item{
        id:root
        anchors.fill: parent

        Image{
            id:bg
            anchors.centerIn: parent
        }

        WorldLocationButton{
            id:hall
            x:80
            y:150
            text:"Зал героев"
            onClicked: currentScreen.sourceComponent=heroHall
        }

        WorldLocationButton{
            id:cursedWell
            x:400
            y:300
            text:"Бездонный колодец"
        }

        Loader{
            id:currentScreen
            anchors.fill: parent
        }

        Button{
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            text:"Назад на карту"
            visible: currentScreen.status===Loader.Ready
            onClicked: currentScreen.sourceComponent=undefined
        }
    }

    property Player player:Player{
        heroList: [
            Hero{
                name:"Fajra virkato"
                image:""
            },
            Hero{
                name:"Henrietta"
                image:""
            }
        ]
        function createHero(){
            var heroSource=Qt.createComponent("Hero.qml")
            var newHero=heroSource.createObject(this)
            addHero(newHero)
        }
    }

    Component{
        id:heroHall
        HeroHall{}
    }
}

