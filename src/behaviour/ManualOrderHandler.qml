import QtQml.StateMachine 1.0

CharacterBehaviour{
    property var orders: []
    property string currentOrder: "none"
    property string pendingOrder: "idle"
    initialState: listenOrder
    MoveToPointOrder{
        id:moveToPoint
        SignalTransition{
            targetState: listenOrder
            signal: moveToPoint.finished
        }
        SignalTransition{
            targetState: listenOrder
            signal: pendingOrderChanged
            guard: pendingOrder!=="none"
        }
        //add sequential move through path finding
    }
    MoveToPointOrder{
        id:patrol
        SignalTransition{
            targetState: patrol
            signal: patrol.finished
            onTriggered:{
                var temp=Qt.point(target.x,target.y)
                target=Qt.point(source.x,source.y)
                source=temp
            }
        }
        //change to patrol order
    }
    //MoveToPointAndAttackOrder
    //StayAndPersecuteOrder
    //HoldAndAttackOrder
    //MoveToTargetOrder
    //AttackTargetOrder
    IdleBehaviour{
        id:idle
        SignalTransition{
            targetState: listenOrder
            signal: pendingOrderChanged
            guard: pendingOrder!=="none"
        }
    }
    DynamicBehaviour{
        id:listenOrder
        SignalTransition{
            signal:currentOrderChanged
            targetState:moveToPoint
            guard:currentOrder === "move"
        }
        SignalTransition{
            signal:currentOrderChanged
            targetState:idle
            guard:currentOrder === "idle"
        }
        SignalTransition{
            signal:currentOrderChanged
            targetState:patrol
            guard:currentOrder === "patrol"
        }
        function update(){
            if(refreshOrder())
                return
            if(orders.length>0){
                var order = orders.shift()
                order()
            }else{
                pendingOrder="idle"
            }
            refreshOrder()
        }
        function refreshOrder(){
            if(pendingOrder!=="none"){
                currentOrder=pendingOrder
                pendingOrder="none"
                return true
            }
            return false
        }
        onEntered: currentOrder="none"
    }
    function enqueueOrder(order){
        orders.push(order)
    }
    function resetOrderQueue(){
        orders = []
    }

    //point-targeted
    function orderPointTarget(destX,destY,orderName){
        destX=alignToCells(destX - character.size / 2)
        destY=alignToCells(destY - character.size / 2)
        if(Math.abs(pos.x-destX) >= cellSize ||
           Math.abs(pos.y-destY) >= cellSize ){
            pendingOrder = orderName
            targetObj=undefined
            target=Qt.point(destX,destY)
            source=Qt.point(pos.x,pos.y)
        }
    }
    function orderMove(destX,destY){
        orderPointTarget(destX,destY,"move")
    }
    function orderAttack(destX,destY){
        orderPointTarget(destX,destY,"attack")
    }
    function orderPatrol(destX,destY){
        orderPointTarget(destX,destY,"patrol")
    }

    //object-targeted
    function orderObjectTarget(obj,orderName){
        if(Math.abs(pos.x-obj.pos.x) >= cellSize ||
           Math.abs(pos.y-obj.pos.y) >= cellSize ){
            pendingOrder = orderName
            targetObj=obj
            target=obj.pos
            source=Qt.point(pos.x,pos.y)
        }
    }
    function orderMoveTarget(obj){
        orderObjectTarget(obj,"moveTarget")
    }
    function orderAttackTarget(obj){
        orderObjectTarget(obj,"attackTarget")
    }
}
