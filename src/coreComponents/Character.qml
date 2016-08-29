import QtQuick 2.0
import QtQml.StateMachine 1.0 as SM

import "../behaviour"

QtObject {
    id:character

    property alias sprite:charDelegate.source
    property real speed: 1000

    property string currentAnimation: "idle"

    property point pos:Qt.point(100,100)
    property point direction:Qt.point(1,0)

    property CharacterBehaviour behaviour: ManualOrderHandler{
        running: true
    }

    property Loader spriteLoader: Loader{
        id:charDelegate
        parent: hall
    }

}

