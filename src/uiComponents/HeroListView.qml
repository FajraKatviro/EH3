import QtQuick 2.5
import QtQuick.Layouts 1.1

Rectangle{
    property var sourcePlayer
    property var currentHero:heroList.currentItem ? heroList.currentItem.hero : undefined
    border.width: 2
    Layout.fillHeight: true
    Layout.preferredWidth: 200
    ListView{
        id:heroList
        anchors.fill:parent
        anchors.margins: 5
        spacing: 5
        model:player.heroList
        clip: true
        header:Item{
            height:40
            width: parent.width
            z:2
            Rectangle{
                anchors.fill: parent
                anchors.bottomMargin: 5
                Text{
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text:"Ваши персонажи"
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }
                border.width: 2
                radius: 4
            }
        }
        headerPositioning:ListView.OverlayHeader
        delegate: HeroDelegate{
            hero:modelData
            text:hero.name
            border.width: 2
            radius: 4
        }
        footer:Item{
            height:80
            width: parent.width
            Rectangle{
                color:"lightblue"
                anchors.fill: parent
                anchors.topMargin: 5
                Text{
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text:"Создать персонажа"
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }
                border.width: 2
                radius: 4
                MouseArea{
                    anchors.fill: parent
                    onClicked: player.createHero()
                }
            }
        }
    }
}

