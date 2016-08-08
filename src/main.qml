import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

import eh3 1.0
import "uiComponents"
import "coreComponents"
import "heroes"

QtObject{
    id:eh3game

    readonly property var game: eh3game
    signal screenRequested(var screenName)

    property string currentScreenName:"MetaMap"

    onScreenRequested: currentScreenName=screenName

    property Window window: Window {
        id:window
        visible: true
        width:1280
        height:1024

        Item{
            id:root
            anchors.fill: parent

            Rectangle{
                id:loadingScreen
                anchors.fill: parent
                Text{
                    anchors.centerIn: parent
                    text:"LOADING..."
                    font.pixelSize: 80
                    font.bold: true
                }
            }

            Loader{
                id:currentScreen
                anchors.fill: parent
                source: "uiComponents/" + currentScreenName + ".qml"
                visible: status===Loader.Ready
            }

            Button{
                id: backButton
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                text:currentScreenName!=="MetaMap" ? "Назад на карту" : "Выход"
                onClicked: currentScreenName!=="MetaMap" ? screenRequested("MetaMap") : Qt.quit()
            }
        }
    }

    property Player player:Player{
        heroList: [
            FajraVirkato{},
            Henrietta{}
        ]
    }

    function show(){
        window.showFullScreen()
    }

}

