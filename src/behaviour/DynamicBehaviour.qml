import QtQml.StateMachine 1.0

State{
    onEntered: hall.nextFrame.connect(update)
    onExited: hall.nextFrame.disconnect(update)

    function update(dt){

    }
}
