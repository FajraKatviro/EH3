import QtQuick 2.0

QtObject {
    property var heroList:[]
    function createHero(){
        var heroComponent=Qt.createComponent("Hero.qml")
        var newHero=heroComponent.createObject()
        heroList.push(newHero)
        heroListChanged()
    }
}

