import QtQuick 2.0

Item{
    property alias stat: skillStat.stat
    anchors{
        left: parent.left
        right: parent.right
    }
    height:skillStat.height
    Column{
        anchors.fill: parent
        spacing:0
        SkillStatDelegate {
            id:skillStat
            showValue: false
        }
        Rectangle{
            anchors{
                left: parent.left
                right: parent.right
                leftMargin: 4
            }
        }
    }
}

