import QtQuick 2.5

SkillStat {
    title:"Снаряды"
    value:0

    function addEmission(){
        var emissiomSource=Qt.createComponent("DefaultEmission.qml")
        var newEmiission=emissiomSource.createObject(this)
        newEmiission.createdDynamically=true
        addBalancedChild(newEmiission)
    }

    function removeEmission(emissionIndex){
        var emission=childBalancedComponents[emissionIndex]
        removeBalancedChild(emissionIndex)
        if(emission.createdDynamically)
            emission.destroy()
    }
}

