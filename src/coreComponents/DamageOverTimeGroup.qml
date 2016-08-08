import QtQuick 2.0

SkillStat {
    function addDamageSource(){
        var damageSourceComponent=Qt.createComponent("DamageOverTimeSource.qml")
        var damageSource=damageSourceComponent.createObject(this)
        addBalancedChild(damageSource)
    }
    function removeDamageSource(sourceIndex){
        //var damageSource=childBalancedComponents[sourceIndex]
        removeBalancedChild(sourceIndex)
    }
}
