import QtQuick 2.2

AnimatedSprite {

    id:character

    width:200
    height:200

    property point direction:Qt.point(0,0)

    onDirectionChanged: refreshDirection()

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
