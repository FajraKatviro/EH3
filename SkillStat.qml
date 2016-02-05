import QtQuick 2.5
import eh3 1.0

BalancedComponent {
    property string stat
    property string title
    readonly property HeroStat heroStat: findStat(stat)
    readonly property int usedPower:parentBalancedComponent*(importance/parentBalancedComponent.childrenImportanceBalance)
    readonly property int points:heroStat ? usedPower/heroStat.finalCost
}

