import QtQuick 2.5
import QtQuick.Controls 1.4

Item{
    property var actualEmission
    property real subshift:24
    signal removeRequested
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
            stat:actualEmission
            statTitle:stat.title + " " + (index+1)
            showValue: false
            Button{
                anchors{
                    top:parent.top
                    right:parent.right
                    bottom:parent.bottom
                    margins: 2
                }
                //width:40
                text:"Удалить"
                onClicked: removeRequested()
            }
        }
        SkillStatDelegate{
            anchors.leftMargin: subshift
            stat:actualEmission.walkSpeed
        }
        SkillStatDelegate{
            anchors.leftMargin: subshift
            stat:actualEmission.velocity
        }
        SkillStatDelegate{
            anchors.leftMargin: subshift
            stat:actualEmission.penetrationChance
        }
        DamageGroupDelegate{
            anchors.leftMargin: subshift
            actualGroup:actualEmission.hitDamage
        }
        DamageOverTimeGroupDelegate{
            anchors.leftMargin: subshift
            actualGroup:actualEmission.hitDamageOverTime
        }
        DamageOverTimeGroupDelegate{
            anchors.leftMargin: subshift
            actualGroup:actualEmission.pathDamage
        }
        ImpactDelegate{
            anchors.leftMargin: subshift-4
            actualImpact:actualEmission.endImpact
        }
        ImpactDelegate{
            anchors.leftMargin: subshift-4
            actualImpact:actualEmission.hitImpact
        }
    }
}

