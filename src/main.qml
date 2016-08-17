import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

import QtMultimedia 5.7

import eh3 1.0
import "uiComponents"
import "coreComponents"
import "heroes"

import "debugComponents"

QtObject{
    id:eh3game

    readonly property var game: eh3game
    signal screenRequested(var screenName)

    signal evalRequested(var src)
    signal evalActivated(var target)

    function activateEvaluator(target){
        evalActivated(target)
    }

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

            TextArea{
                id: evalCode
                anchors.right: parent.right
                anchors.top: parent.top
                height: 200
                width: 400
            }

            Button{
                id: evalBtn
                anchors.right: parent.right
                anchors.bottom: evalCode.bottom
                text:"Eval"
                onClicked: {
                    if(evalCode.text===""){
                        activateEvaluator("root")
                    }else{
                        evalRequested(evalCode.text)
                    }
                }
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

    property Evaluator evaluator: Evaluator{
        objectName: "root"
        active: true
    }

    property var music:Audio{
        autoPlay: true
        source: "qrc:///music/mainMenu.mp3"
        loops: Audio.Infinite
    }

}

