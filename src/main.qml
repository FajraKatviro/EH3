import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

import eh3 1.0
import "uiComponents"
import "coreComponents"
import "heroes"

QtObject{
    id:eh3game

    //add children property and overwork existing qml bug
    property list<QtObject> children
    default property alias childrenProperty:children

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



        Component{
            id:heroHall
            HeroHall{}
        }

        Component.onCompleted: showFullScreen()
    }

    property Player player:Player{
        heroList: [
            FajraVirkato{},
            Henrietta{}
        ]
    }

}

