import QtQml.StateMachine 1.0

State{
    onEntered: game.nextFrame.connect(update)
    onExited: game.nextFrame.disconnect(update)

    function update(dt){

    }
}
