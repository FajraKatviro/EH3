import QtQuick 2.5
import QtQuick.Layouts 1.1

Item {
    property var stat
    anchors{
        left: parent.left
        right: parent.right
        margins: 4
    }
    height: 40
    Rectangle{
        anchors.fill: parent
        radius: 4
        border.width: 2
        color:"lightgrey"
        RowLayout{
            anchors.fill: parent
            spacing: 0
            Text{
                Layout.fillHeight: true
                Layout.preferredWidth: 100
                Layout.fillWidth: true
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: stat.title
                verticalAlignment: Text.AlignVCenter
            }
            Text{
                Layout.fillHeight: true
                Layout.preferredWidth: 50
                text: stat.importance.toFixed(2)
                verticalAlignment: Text.AlignVCenter
            }
            Text{
                Layout.fillHeight: true
                Layout.preferredWidth: 50
                text: stat.usedPower
                verticalAlignment: Text.AlignVCenter
            }
            Text{
                Layout.fillHeight: true
                Layout.preferredWidth: 50
                text: stat.value.toFixed(2)
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
