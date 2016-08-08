import QtQuick 2.5

Item{
    property var actualImpact
    property real subshift:24
    anchors{
        left: parent.left
        right: parent.right
    }
    height:statColumn.implicitHeight
    Column{
        id:statColumn
        anchors.fill: parent
        spacing:0
        SkillStatDelegate {
            id:skillStat
            stat:actualImpact
            showValue: false
        }
        SkillStatDelegate{
            anchors.leftMargin: subshift
            stat:actualImpact.area
        }
        DamageGroupDelegate{
            anchors.leftMargin: subshift
            actualGroup:actualImpact.hitDamage
        }
        DamageOverTimeGroupDelegate{
            anchors.leftMargin: subshift
            actualGroup:actualImpact.hitDamageOverTime
        }
        DamageOverTimeGroupDelegate{
            anchors.leftMargin: subshift
            actualGroup:actualImpact.pathDamage
        }
        Loader{
            id:subEmissionsDelegate
            source: "EmissionGroupDelegate.qml"
            anchors{
                left:parent.left
                right:parent.right
                leftMargin: subshift-4
            }
        }
        Binding{
            target: subEmissionsDelegate.item
            property: "stat"
            value: actualImpact.subEmissions
            when:subEmissionsDelegate.status===Loader.Ready
        }
//        Binding{
//            target: subEmissionsDelegate
//            property: "height"
//            value: subEmissionsDelegate.item.height
//            when:subEmissionsDelegate.status===Loader.Ready
//        }
    }
}
