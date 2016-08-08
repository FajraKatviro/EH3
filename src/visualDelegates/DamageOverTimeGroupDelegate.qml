import QtQuick 2.5

DamageGroupDelegate{
    damageSourceDelegate: DamageSourceDelegate{
        actualSource: modelData
        dot:true
        onRemoveRequested: actualGroup.removeDamageSource(index)
    }
}
