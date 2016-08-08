import QtQuick 2.5
import QtQuick.Controls 1.4

Item{
    property var actualGroup
    property alias damageSourceDelegate:damageSoursesView.delegate
    anchors{
        right:parent.right
        left:parent.left
    }
    height: groupStat.height+groupStat.anchors.margins*2+damageSourses.height
    SkillStatDelegate {
        id:groupStat
        anchors.top: parent.top
        anchors.margins:0
        anchors.rightMargin:4
        stat:actualGroup
        showValue: false
    }
    Item{
        id:damageSourses
        anchors{
            top:groupStat.bottom
            left: parent.left
            right: parent.right
            leftMargin: 16
        }
        height: addDamageSourceButton.height+damageSoursesView.height
        ListView{
            id:damageSoursesView
            anchors{
                top:parent.top
                left: parent.left
                right: parent.right
            }
            height: childrenRect.height
            interactive: false
            model:actualGroup.childBalancedComponents
            delegate: DamageSourceDelegate{
                actualSource: modelData
                onRemoveRequested: actualGroup.removeDamageSource(index)
            }
        }
        Button{
            id:addDamageSourceButton
            anchors{
                top:damageSoursesView.bottom
                left: parent.left
                right: parent.right
                leftMargin:4
                rightMargin:4
            }
            text:"Добавить источник урона"
            onClicked: actualGroup.addDamageSource()
        }
    }
}

