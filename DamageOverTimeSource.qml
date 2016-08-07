
DamageSource {
    readonly property alias duration:durationStat

    SkillStat{
        id:durationStat
        stat:damageType
        title:"Длительность"
        value:points
    }
}
