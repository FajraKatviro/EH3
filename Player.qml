import QtQuick 2.0

QtObject {
    property list<Hero> heroList

    function createHero(){
        var heroComponent=Qt.createComponent("Hero.qml")
        var newHero=heroComponent.createObject(this)
        heroList.append(newHero)
        heroListChanged()
    }
}

