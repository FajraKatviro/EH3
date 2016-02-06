import QtQuick 2.0
import eh3 1.0

BalancedComponent {
    property string name:"Новое заклинание"
    property string icon
    importance: 1.0
    readonly property int usedPower:heroPower

    readonly property SkillStat castTime:cast
    readonly property SkillStat recastTime:recast
    property EmissionGroup emissions

    SkillStat{
        id:cast
        stat:"castSpeed"
        title:"Времени на произнесение"
        value:1/(1+points*0.1)
    }
    SkillStat{
        id:recast
        stat:"castSpeed"
        title:"Времени на поддержание"
        value:0.8/(1+points*0.1)
    }
}