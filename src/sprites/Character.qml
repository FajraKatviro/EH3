import QtQuick 2.2

AnimatedSprite {

    id:character

    property int directionX:0
    property int directionY:0

    onDirectionXChanged: refreshDirection()
    onDirectionYChanged: refreshDirection()

    property SpriteSetting idleAnimationSetting
    property SpriteSetting attack1AnimationSetting
    property SpriteSetting attack2AnimationSetting
    property SpriteSetting walkAnimationSetting
    property SpriteSetting runAnimationSetting
    property SpriteSetting dieAnimationSetting

    property SpriteSetting setting
    property int spriteDirection:0

    state:"walk"
    states:[
        State{
            name:"idle"
            PropertyChanges{target: character; setting:idleAnimationSetting}
        },
        State{
            name:"attack1"
            PropertyChanges{target: character; setting:attack1AnimationSetting}
        },
        State{
            name:"attack2"
            PropertyChanges{target: character; setting:attack2AnimationSetting}
        },
        State{
            name:"walk"
            PropertyChanges{target: character; setting:walkAnimationSetting}
        },
        State{
            name:"run"
            PropertyChanges{target: character; setting:runAnimationSetting}
        },
        State{
            name:"die"
            PropertyChanges{target: character; setting:dieAnimationSetting}
        }
    ]

    frameX: setting.startFrame*frameWidth
    frameY: spriteDirection*frameHeight

    source:       setting.source
    frameWidth:   setting.frameWidth
    frameHeight:  setting.frameHeight
    frameRate:    setting.frameRate
    frameCount:   setting.frameCount

    function refreshDirection(){
        if(directionX>0){
            if(directionY>0){
                spriteDirection=1
            }else if(directionY<0){
                spriteDirection=3
            }else{
                spriteDirection=2
            }
        }else if(directionX<0){
            if(directionY>0){
                spriteDirection=7
            }else if(directionY<0){
                spriteDirection=5
            }else{
                spriteDirection=6
            }
        }else{
            if(directionY>0){
                spriteDirection=0
            }else if(directionY<0){
                spriteDirection=4
            }else{
                //do not change spriteDirection
            }
        }
    }

}
