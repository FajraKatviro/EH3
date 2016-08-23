import QtQuick 2.0
import eh3 1.0

HeroObject {
    property string name:"New character"
    property string image
    property string model
    property string characterSprite
    property real scale: 1.0
    property int heroPower:1000
    function createSkill(){
        var sourceComponent=Qt.createComponent("DefaultSkill.qml")
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
            name:"concentration"
            title:"Концентрация"
            basicCost: 80
        },
        HeroStat{
            name:"water"
            title:"Владение магией воды"
            property string specialEffectTitle:"Замедление"
        },
        HeroStat{
            name:"fire"
            title:"Владение магией огня"
            basicCost: 200
            property string specialEffectTitle:"Понижение брони"
        },
        HeroStat{
            name:"entropy"
            title:"Владение магией энтропии"
            basicCost:1500
            education: 0.0007
            property string specialEffectTitle:"Увеличение получаемого урона"
        }
    ]
    skills:[]
    onSkillAdded:skill.hero=this
}

