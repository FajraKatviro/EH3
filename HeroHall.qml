import QtQuick 2.0

import eh3 1.0

Rectangle {
    id:hall
    color:"lightgreen"
    Row{
        anchors.fill: parent
        Rectangle{
            border.width: 2
            anchors{
                top:parent.top
                bottom:parent.bottom
            }
            width:200
            ListView{
                id:heroList
                anchors.fill:parent
                anchors.margins: 5
                spacing: 5
                model:player.heroList
                delegate: HeroDelegate{
                    text:"Персонаж " + index
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
                        MouseArea{
                            anchors.fill: parent
                            onClicked: player.createHero()
                        }
                    }
                }
            }
        }
        Rectangle{
            border.width: 2
            id:heroView
            anchors{
                top:parent.top
                bottom:parent.bottom
            }
            width:300
            Text{
                text:heroList.currentItem.text
            }
        }
        Rectangle{
            border.width: 2
            id:skillView
            anchors{
                top:parent.top
                bottom:parent.bottom
            }
            width:300
            Rectangle{
                color:"red"
                anchors{
                    right: parent.right
                    left: parent.left
                    top: parent.top
                    margins: 5
                }
                height:skillGrid.cellWidth*2
                GridView{
                    id:skillGrid
                    anchors.fill: parent
                    cellWidth: width/4
                    cellHeight: cellWidth
                    model: 8
                    delegate: Rectangle{
                        width: skillGrid.cellWidth
                        height: skillGrid.cellWidth
                        color:"yellow"
                    }

                }
            }
        }
    }
}

