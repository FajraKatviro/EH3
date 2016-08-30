import QtQuick 2.0

import "../behaviour"

QtObject {
    id:character

    property alias sprite:charDelegate.source
    property real speed: 500

    property string currentAnimation: "idle"

    property point pos:Qt.point(100,200)
    property point direction:Qt.point(1,0)

    property CharacterBehaviour behaviour: ManualOrderHandler{
        running: true
    }

    property Loader spriteLoader: Loader{
        id:charDelegate
        parent: hall
    }

}

