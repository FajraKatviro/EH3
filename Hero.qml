import QtQuick 2.0
import eh3 1.0

HeroObject {
    property string name:"New character"
    property string image
    property int heroPower:1000
    function createSkill(){
        var sourceComponent=Qt.createComponent("Skill.qml")
        var newSkill=sourceComponent.createObject(this)
        addSkill(newSkill)
    }

    stats:[
        HeroStat{
            name:"castSpeed"
            title:"Скорость чтения заклинаний"
        },
        HeroStat{
            name:"castDistance"
            title:"Дальность действия заклинаний"
            basicCost: 25
        },
        HeroStat{
            name:"waterPower"
            title:"Владение магией воды"
        },
        HeroStat{
            name:"firePower"
            title:"Владение магией огня"
            basicCost: 200
        },
        HeroStat{
            name:"entPower"
            title:"Владение магией энтропии"
            basicCost:1500
            education: 0.0007
        }
    ]
}

