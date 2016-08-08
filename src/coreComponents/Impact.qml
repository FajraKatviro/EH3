import QtQuick 2.5

SkillStat {
    readonly property alias area:areaStat
    readonly property alias hitDamage:primaryDamage
    readonly property alias hitDamageOverTime:dot
    readonly property alias pathDamage:pathDamageGroup
    readonly property alias subEmissions:subemissions

    SkillStat{
        id:areaStat
        value:points
        stat:"concentration"
        title:"Область взрыва"
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
    EmissionGroup{
        id:subemissions
    }
}
