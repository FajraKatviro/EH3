import QtQml.StateMachine 1.0

CharacterBehaviour{
    property var orders: []
    property string currentOrder: "idle"
    initialState: noOrder
    MoveToPointOrder{
        id:moveToPoint
        SignalTransition{
            targetState: noOrder
            signal: moveToPoint.finished
        }
    }
    IdleBehaviour{
        id:noOrder
        SignalTransition{
            signal:currentOrderChanged
            targetState:moveToPoint
            guard:currentOrder === "move"
        }
        function update(){
            if(orders.length>0){
                var order = orders.shift()
                order()
            }
        }
        onEntered:currentOrder="idle"
    }
    function enqueueOrder(order){
        orders.push(order)
    }
    function resetOrderQueue(){
        orders = []
    }
    function orderMove(destX,destY){
        destX=alignToCells(destX)
        destY=alignToCells(destY)
        if(Math.abs(pos.x-destX) >= cellSize ||
           Math.abs(pos.y-destY) >= cellSize ){
            currentOrder = "move"
            target=Qt.point(destX,destY)
        }
    }
}
