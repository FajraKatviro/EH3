import eh3 1.0

PlayerBase{
    property int currentHero
    function createHero(){
        var heroSource=Qt.createComponent("DefaultHero.qml")
        var newHero=heroSource.createObject(this)
        addHero(newHero)
    }
}
