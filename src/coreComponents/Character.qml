import QtQuick 2.0

QtObject {
    id:character

    property alias sprite:charDelegate.source
    property real speed: 1000

    property string order: "idle"

    property point pos
    property point target

    property point delta:Qt.point(target.x-pos.x,target.y-pos.y)
    property real distance:Math.abs(delta.x)+Math.abs(delta.y)

    property Loader spriteLoader: Loader{
        id:charDelegate
        parent: hall
    }

    property list<Binding> bindings:[
        Binding{
            target: charDelegate.item
            property: "direction"
            value: Qt.point(distance === 0 || Math.abs(delta.x/distance)<0.3 ? 0 : delta.x,
                            distance === 0 || Math.abs(delta.y/distance)<0.3 ? 0 : delta.y)
        },
        Binding{
            target: charDelegate.item
            property:"x"
            value:character.pos.x-charDelegate.item.width/2
        },
        Binding{
            target: charDelegate.item
            property:"y"
            value:character.pos.y-charDelegate.item.height/2
        },
        Binding{
            target: charDelegate.item
            property:"state"
            value:order
        }
    ]

    property Connections updateConnection: Connections{
        target: hall
        onNextFrame: update(frameDuration)
    }

    function update(dt){
        switch(order){
        case "walk":
            if(distance === 0){
                order="idle"
                break
            }
            var x=0
            var y=0
            if(delta.x !== 0)
                x += Math.min(Math.abs(delta.x), Math.abs(speed * dt * 0.001 * delta.x / distance) ) * (delta.x > 0 ? 1 : -1)
            if(delta.y !== 0)
                y += Math.min(Math.abs(delta.y), Math.abs(speed * dt * 0.001 * delta.y / distance) ) * (delta.y > 0 ? 1 : -1)
            if(x!==0 || y!==0)
                pos=Qt.point(pos.x+x,pos.y+y)
            break
        }
    }

    function move(destX,destY){
        order="walk"
        target=Qt.point(destX,destY)
    }
}

