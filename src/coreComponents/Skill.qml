import eh3 1.0

BalancedComponent {
    property string name:"Новое заклинание"
    property string icon
    importance: 1.0
    readonly property int usedPower:hero ? hero.heroPower : 0
    property var hero

    readonly property alias castTime:cast
    readonly property alias recastTime:recast
    property EmissionGroup emissions
    onEmissionsChanged:if(emissions)addBalancedChild(emissions)

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
