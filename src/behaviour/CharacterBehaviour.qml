import QtQml.StateMachine 1.0
import QtQuick 2.7 as QQ

import eh3 1.0

StateMachine{
    id:charBeh
    property point target:Qt.point(100,100)
    property point source:Qt.point(100,100)
    property var targetObj

    property alias moveTarget:pathFinder.nextPos
    property alias hasPath:pathFinder.hasSolution

    property point delta:Qt.point(target.x-pos.x,target.y-pos.y)
    property real distance:Math.abs(delta.x)+Math.abs(delta.y)

    QQ.Binding{
        target: character
        property: "direction"
        value: Qt.point(distance === 0 || Math.abs(delta.x/distance)<0.3 ? 0 : delta.x,
                        distance === 0 || Math.abs(delta.y/distance)<0.3 ? 0 : delta.y)
    }

    function alignToCells(val){
        return Math.round(val / cellSize) * cellSize
    }

    property PathFinder path:PathFinder{
        id:pathFinder
        target:charBeh.target
        pos:character.pos
        pathMap: locationPathMap
    }
}
