import QtQuick 2.5
import QtQuick.Layouts 1.1

import eh3 1.0

Rectangle {
    id:hall
    color:"darkgreen"

    readonly property real frameDuration: 10

    property real lastFrame: new Date().getTime()

    Timer{
        id:updater
        running: true
        repeat: true
        interval: 10
        triggeredOnStart: false
        onTriggered:{
            var dt = new Date().getTime() - lastFrame
            while(dt >= frameDuration){
                dt-=frameDuration
                lastFrame+=frameDuration
                nextFrame()
            }
        }
    }

    signal nextFrame

    /*Rectangle{
        id:heroDelegate
        x:150
        y:200
        width: 100
        height: 100
        color: "black"
        property real speed: 1000
        Connections{
            target: hall
            onNextFrame:{
                heroDelegate.x+=(heroDelegate.speed*frameDuration*0.001)
            }
        }
    }*/

    SpriteSequence{

        id:heroDelegate
        width:100
        height:100
        property real speed: 100


        Sprite{
            //name: "blue"
            source: "qrc:///sprites/archer_walk.png"
            frameX: 0
            frameY: 412
            frameCount: 15
            frameWidth: 185
            frameHeight: 206
            frameRate: 14

        }
    }

    Connections{
        target: hall
        onNextFrame:{
            heroDelegate.x+=(heroDelegate.speed*frameDuration*0.001)
        }
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            heroDelegate.y = mouseY
            heroDelegate.x = mouseX
        }
    }

}

