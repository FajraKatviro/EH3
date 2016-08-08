import QtQuick 2.5

SkillStat {
    property string damageType
    readonly property alias damage:primaryEffect

    readonly property alias specialEffect:secondaryEffect

    title:"Источник урона"
    SkillStat{
        id:primaryEffect
        stat:damageType
        title:"Повреждения"
        value:points
    }
    SkillStat{
        id:secondaryEffect
        stat:damageType
        title:heroStat ? heroStat.specialEffectTitle : ""
        value:points
    }
}
