import QtQuick 2.5

SkillStat{
    function addDamageSource(){
        var damageSourceComponent=Qt.createComponent("DamageSource.qml")
        var damageSource=damageSourceComponent.createObject(this)
        addBalancedChild(damageSource)
    }
    function removeDamageSource(sourceIndex){
        //var damageSource=childBalancedComponents[sourceIndex]
        removeBalancedChild(sourceIndex)
    }
}
