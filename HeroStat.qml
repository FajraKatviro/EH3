import QtQuick 2.5

QtObject {
    property string name
    property string title:name
    property string icon
    property int basicCost:100
    property int battlePoints:0
    property real education:0.000001
    property real basicMult:1.0

    readonly property real mult: 1/(basicMult+battlePoints*education)
    readonly property int totalCost:basicCost*mult
}
