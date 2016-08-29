

DynamicBehaviour{
    onEntered: character.currentAnimation="walk"

    function update(dt){
        if(distance < 1){
            pos=target
            return
        }
        var x=0
        var y=0
        if(delta.x !== 0)
            x += Math.min(Math.abs(delta.x), Math.abs(speed * dt * 0.001 * delta.x / distance) ) * (delta.x > 0 ? 1 : -1)
        if(delta.y !== 0)
            y += Math.min(Math.abs(delta.y), Math.abs(speed * dt * 0.001 * delta.y / distance) ) * (delta.y > 0 ? 1 : -1)
        if(x!==0 || y!==0)
            pos=Qt.point(pos.x+x,pos.y+y)
    }
}
