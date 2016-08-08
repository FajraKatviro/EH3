import QtQuick 2.5
import QtQuick.Layouts 1.1

Rectangle{
    property var sourceSkill
    border.width: 2
    id:skillSettingsView
    Layout.fillHeight: true
    Layout.fillWidth: true
    Column{
        anchors.fill: parent
        Text{
            anchors{
                left:parent.left
                right:parent.right
            }
            height: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text:sourceSkill.name
        }
        SkillStatDelegate{
            stat:sourceSkill.castTime
        }
        SkillStatDelegate{
            stat:sourceSkill.recastTime
        }
        EmissionGroupDelegate{
            stat:sourceSkill.emissions
        }
    }
}
