import QtQuick 2.5

SkillStat {
    title:"Снаряд"
    property bool createdDynamically:false

    readonly property alias walkSpeed:speed
    readonly property alias velocity:distance
    readonly property alias penetrationChance:penetration
    readonly property alias hitDamage:primaryDamage
    readonly property alias hitDamageOverTime:dot
    readonly property alias pathDamage:pathDamageGroup
    readonly property alias hitImpact:hitImpactStat
    readonly property alias endImpact:endImpactStat

    SkillStat{
        id:speed
        value:600+points*10
        stat:"castDistance"
        title:"Скорость перемещения"
    }
    SkillStat{
        id:distance
        value:200+points*25
        stat:"castDistance"
        title:"Дальность перемещения"
    }
    SkillStat{
        id:penetration
        value:1-1/(1+points*0.1)
        stat:"concentration"
        title:"Пробивная способность"
    }
    DamageGroup{
        id:primaryDamage
        title:"Прямой урон"
    }
    DamageOverTimeGroup{
        id:dot
        title:"Постепенный урон"
    }
    DamageOverTimeGroup{
        id:pathDamageGroup
        title:"Урон от следа"
    }
    Impact{
        id:hitImpactStat
        title:"Реакция на столкновение"
    }
    Impact{
        id:endImpactStat
        title:"Действие по окончанию"
    }
}

