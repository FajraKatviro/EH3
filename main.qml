import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

import eh3 1.0

Window {
    visible: true
    width:1280
    height:1024

    Item{
        id:root
        anchors.fill: parent

        Image{
            id:bg
            anchors.fill: parent
            source: "images/MainMenu.jpg"
        }

        WorldLocationButton{
            id:hall
            x:50
            y:525
            text:"Зал героев"
            onClicked: currentScreen.sourceComponent=heroHall
        }

        WorldLocationButton{
            id:cursedWell
            x:325
            y:800
            text:"Бездонный колодец"
        }
//        MouseArea{
//            anchors.fill: parent
//            onClicked: console.log(mouseX,mouseY)
//        }

        Loader{
            id:currentScreen
            anchors.fill: parent
        }

        Button{
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            text:currentScreen.status===Loader.Ready ? "Назад на карту" : "Выход"
            //visible: currentScreen.status===Loader.Ready
            onClicked: currentScreen.status===Loader.Ready ? currentScreen.sourceComponent=undefined : Qt.quit()
        }
    }

    property Player player:Player{
        heroList: [
            Hero{
                name:"Fajra virkato"
                image:""
                skills:FireLine{}
            },
            Hero{
                name:"Henrietta"
                image:""
                skills:WaterBlast{}
            }
        ]
        function createHero(){
            var heroSource=Qt.createComponent("DefaultHero.qml")
            var newHero=heroSource.createObject(this)
            addHero(newHero)
        }
    }

    Component{
        id:heroHall
        HeroHall{}
    }

    Component.onCompleted: showFullScreen()
}

