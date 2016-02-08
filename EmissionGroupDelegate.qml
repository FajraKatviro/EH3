import QtQuick 2.5
import QtQuick.Controls 1.4

Item{
    property alias stat: skillStat.stat
    anchors{
        left: parent.left
        right: parent.right
    }
    height:skillStat.height+emissions.height
    SkillStatDelegate {
        id:skillStat
        anchors.top: parent.top
        showValue: false
    }
    Rectangle{
        id:emissions
        border.width:2
        radius: 4
        color:"lightgreen"
        height: addEmissionButton.implicitHeight
        anchors{
            top:skillStat.bottom
            left: parent.left
            right: parent.right
            leftMargin: 4
        }
        Button{
            id:addEmissionButton
            anchors{
                top:parent.top
                left: parent.left
                right: parent.right
            }
            text:"Добавить снаряд"
        }
    }
}

