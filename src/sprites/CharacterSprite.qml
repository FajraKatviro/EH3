import QtQuick 2.2

AnimatedSprite {

    id:characterSprite

    width:200
    height:200

    x:character.pos.x-width/2
    y:character.pos.y-height*0.9
    state:character.currentAnimation

    Connections{
        target: character
        onDirectionChanged: refreshDirection()
    }

    property SpriteSetting idleAnimationSetting
    property SpriteSetting attack1AnimationSetting
    property SpriteSetting attack2AnimationSetting
    property SpriteSetting walkAnimationSetting
    property SpriteSetting runAnimationSetting
    property SpriteSetting dieAnimationSetting

    property SpriteSetting setting
    property int spriteDirection:0

    states:[
        State{
            name:"idle"
            PropertyChanges{target: characterSprite; setting:idleAnimationSetting}
        },
        State{
            name:"attack1"
            PropertyChanges{target: characterSprite; setting:attack1AnimationSetting}
        },
        State{
            name:"attack2"
            PropertyChanges{target: characterSprite; setting:attack2AnimationSetting}
        },
        State{
            name:"walk"
            PropertyChanges{target: characterSprite; setting:walkAnimationSetting}
        },
        State{
            name:"run"
            PropertyChanges{target: characterSprite; setting:runAnimationSetting}
        },
        State{
            name:"die"
            PropertyChanges{target: characterSprite; setting:dieAnimationSetting}
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
        if(direction.x>0){
            if(direction.y>0){
                spriteDirection=1
            }else if(direction.y<0){
                spriteDirection=3
            }else{
                spriteDirection=2
            }
        }else if(direction.x<0){
            if(direction.y>0){
                spriteDirection=7
            }else if(direction.y<0){
                spriteDirection=5
            }else{
                spriteDirection=6
            }
        }else{
            if(direction.y>0){
                spriteDirection=0
            }else if(direction.y<0){
                spriteDirection=4
            }else{
                //do not change spriteDirection
            }
        }
    }

}
