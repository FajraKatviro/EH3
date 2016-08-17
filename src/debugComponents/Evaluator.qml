import QtQml 2.2

QtObject{
    id:evaluator

    property Connections connector:Connections{
        target:game
        onEvalRequested:{
            evaluator.doEvaluation(src)
        }
        onEvalActivated:{
            evaluator.doActivate(target)
        }
    }

    property bool active:false

    function doActivate(target){
        active=target===objectName
    }

    function doEvaluation(src){
        if(active)
            eval(src)
    }

}
