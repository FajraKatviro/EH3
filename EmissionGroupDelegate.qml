import QtQuick 2.5
import QtQuick.Controls 1.4

Item{
    id:emissionGroupDelegate
    property alias stat: skillStat.stat
    anchors{
        left: parent.left
        right: parent.right
    }
    height:skillStat.height+skillStat.anchors.margins*2+emissions.height
    SkillStatDelegate {
        id:skillStat
        anchors.top: parent.top
        showValue: false
    }
    Item{
        id:emissions
        anchors{
            top:skillStat.bottom
            left: parent.left
            right: parent.right
            leftMargin: 16
        }
        height: addEmissionButton.height+emissionGroupView.height
        ListView{
            id:emissionGroupView
            anchors{
                top:parent.top
                left: parent.left
                right: parent.right
            }
            height: childrenRect.height
            interactive: false
            model:stat.childBalancedComponents
            delegate: EmissionDelegate{
                actualEmission: modelData
                onRemoveRequested: emissionGroupDelegate.stat.removeEmission(index)
            }
        }
        Button{
            id:addEmissionButton
            anchors{
                top:emissionGroupView.bottom
                left: parent.left
                right: parent.right
                leftMargin:4
                rightMargin:4
            }
            text:"Добавить снаряд"
            onClicked: emissionGroupDelegate.stat.addEmission()
        }
    }
}

