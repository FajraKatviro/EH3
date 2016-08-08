import QtQuick 2.5
import QtQuick.Layouts 1.1

import eh3 1.0

Rectangle {
    id:hall
    color:"lightgreen"
    RowLayout{
        anchors.fill: parent
        spacing: 0
        HeroListView{
            id:heroList
            sourcePlayer: player
        }
        HeroMainView{
            sourceHero:heroList.currentHero
        }
        HeroStatsView{
            id:heroStats
            sourceHero:heroList.currentHero
        }
        HeroSkillView{
            sourceSkill:heroStats.currentSkill
        }
    }
}

