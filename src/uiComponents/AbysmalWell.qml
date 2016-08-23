import QtQuick 2.5
import QtQuick.Layouts 1.1

import eh3 1.0

import "../coreComponents"
import "../sprites"

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

   /*Loader{
        id:heroDelegate
        property real speed: 100
        source: "qrc:///sprites/" + player.heroList[player.currentHero].characterSprite
    }

    Binding{
        target: heroDelegate.item
        property:"directionX"
        value:1
    }*/

    Character{
        id:heroDelegate
        speed: 250
        sprite:"qrc:///sprites/ArcherSprite.qml"
        order: "idle"
    }

    /*ArcherSprite{
        id:heroDelegate
        width:100
        height:100
        property real speed: 100

        directionX: 1

    }*/

    MouseArea{
        anchors.fill: parent
        onClicked: heroDelegate.move(mouseX, mouseY)
    }

}

