import QtQml.StateMachine 1.0

State{
    initialState: moveBeh
    WalkBehaviour{
        id:moveBeh
        SignalTransition{
            targetState: idleBeh
            signal: nextFrame
            guard: distance < 1
        }
    }
    FinalState{
        id:idleBeh
    }
}
