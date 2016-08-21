import QtQuick 2.2

SpriteSequence {

    property int directionX:0
    property int directionY:0

    readonly property int direction:{
        if(directionX>0){
            if(directionY>0){
                return 1
            }else if(directionY<0){
                return 3
            }else{
                return 2
            }
        }else if(directionX<0){
            if(directionY>0){
                return 7
            }else if(directionY<0){
                return 5
            }else{
                return 6
            }
        }else{
            if(directionY>0){
                return 0
            }else if(directionY<0){
                return 4
            }else{
                return 0
            }
        }
    }

    Sprite{
        name:"idle"
        source:"qrc:///sprites/archer_idle.png"
        frameWidth:100
        frameHeight:80
        frameX:0
        frameY:frameHeight*direction
    }

    Sprite{
        name:"attack1"
        source:"qrc:///sprites/archer_attack1.png"
        frameWidth:100
        frameHeight:80
        frameX:0
        frameY:frameHeight*direction
    }

    Sprite{
        name:"attack2"
        source:"qrc:///sprites/archer_attack1.png"
        frameWidth:100
        frameHeight:80
        frameX:0
        frameY:frameHeight*direction
    }

    Sprite{
        name:"walk"
        source:"qrc:///sprites/archer_walk.png"
        frameWidth:100
        frameHeight:80
        frameX:0
        frameY:frameHeight*direction
    }

    Sprite{
        name:"run"
        source:"qrc:///sprites/archer_run.png"
        frameWidth:100
        frameHeight:80
        frameX:0
        frameY:frameHeight*direction
    }

    Sprite{
        name:"die"
        source:"qrc:///sprites/archer_death.png"
        frameWidth:100
        frameHeight:80
        frameX:0
        frameY:frameHeight*direction
    }

}
