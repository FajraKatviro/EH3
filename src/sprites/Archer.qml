import QtQuick 2.2

Character {

    setting: walkAnimationSetting

    idleAnimationSetting: SpriteSetting{
        source:"qrc:///sprites/archer_idle.png"
        frameWidth:252
        frameHeight:268
        frameRate: 20
        frameCount: 13
    }

    attack1AnimationSetting: SpriteSetting{
        source:"qrc:///sprites/archer_attack1.png"
        frameWidth:252
        frameHeight:268
        frameRate: 14
        frameCount: 16
    }

    attack2AnimationSetting: attack1AnimationSetting

    walkAnimationSetting: SpriteSetting{
        source:"qrc:///sprites/archer_walk.png"
        frameWidth:252
        frameHeight:268
        frameRate: 20
        frameCount: 15
    }

    runAnimationSetting: SpriteSetting{
        source:"qrc:///sprites/archer_run.png"
        frameWidth:252
        frameHeight:268
        frameRate: 20
        frameCount: 12
    }

    dieAnimationSetting: SpriteSetting{
        source:"qrc:///sprites/archer_death.png"
        frameWidth:252
        frameHeight:268
        frameRate: 20
        frameCount: 13
    }

}
