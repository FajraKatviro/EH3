import QtQuick 2.5
import eh3 1.0

BalancedComponent {
    property string stat
    property string title
    readonly property HeroStat heroStat:hero ? hero.findStat(stat) : null
    readonly property int usedPower:parentBalancedComponent.usedPower*(importance/parentBalancedComponent.childrenImportanceBalance)
    readonly property int points:heroStat ? usedPower/heroStat.finalCost : 0
    property var value
}

