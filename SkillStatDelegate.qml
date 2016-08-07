import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Item {
    property var stat
    property bool showValue: true
    property alias statTitle:txtTitle.text
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
            anchors.margins: 4
            spacing: 0
            Text{
                id:txtTitle
                Layout.fillHeight: true
                Layout.preferredWidth: 100
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: stat.title
                verticalAlignment: Text.AlignVCenter
            }
            Slider{
                Layout.fillHeight: true
                Layout.fillWidth: true
                minimumValue: 0.0
                maximumValue: 1.0
                value: stat.importance
                onValueChanged: stat.importance=value
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
                //visible: showValue
                Layout.fillHeight: true
                Layout.preferredWidth: 50
                text: showValue ? stat.value.toFixed(2) : "н/д"
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
