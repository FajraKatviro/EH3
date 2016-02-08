import QtQuick 2.5
import QtQuick.Layouts 1.1

import eh3 1.0

Rectangle {
    id:hall
    color:"lightgreen"
    RowLayout{
        anchors.fill: parent
        spacing: 0
        Rectangle{
            border.width: 2
//            anchors{
//                top:parent.top
//                bottom:parent.bottom
//            }
//            width:200
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
        Rectangle{
            border.width: 2
            id:heroView
//            anchors{
//                top:parent.top
//                bottom:parent.bottom
//            }
//            width:300
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            TextInput{
                anchors.centerIn: parent
                text:heroList.currentItem.text
                onEditingFinished:{
                    heroList.currentItem.hero.name=text
                    focus=false
                }
            }
        }
        Rectangle{
            border.width: 2
            id:skillView
//            anchors{
//                top:parent.top
//                bottom:parent.bottom
//            }
//            width:300
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            Column{
                anchors.fill: parent
                Text{
                    text:"Заклинания"
                    anchors{
                         right: parent.right
                         left: parent.left
                    }
                    horizontalAlignment: Text.AlignHCenter
                    font{
                        pointSize: 20
                    }
                }
                Rectangle{
                    color:"yellow"
                    border.width: 2
                    anchors{
                        right: parent.right
                        left: parent.left
                        margins: 5
                    }
                    height:(width+anchors.margins)*0.5
                    Item{
                        anchors.fill: parent
                        anchors.margins: 2
                        GridView{
                            id:skillGrid
                            clip: true
                            anchors.fill: parent
                            cellWidth: width/4
                            cellHeight: cellWidth
                            model: heroList.currentItem.hero.skills
                            footer:Item{
                                height:skillGrid.cellWidth
                                width: parent.width
                                Rectangle{
                                    color:"lightblue"
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    border.width: 2
                                    radius: 4
                                    Text{
                                        anchors.fill: parent
                                        text: "Создать новое заклинание"
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            heroList.currentItem.hero.createSkill()
                                            skillGrid.positionViewAtEnd()
                                        }
                                    }
                                }
                            }
                            delegate: Item{
                                id:skillDelegate
                                property Skill skill:modelData
                                width: skillGrid.cellWidth
                                height: skillGrid.cellWidth
                                Rectangle{
                                    anchors.fill: parent
                                    anchors.margins: 2
                                    radius: 4
                                    border.width: 2
                                    Text{
                                        anchors.fill: parent
                                        anchors.margins: 2
                                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        text:modelData.name
                                        font.pointSize: 10
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: skillDelegate.GridView.view.currentIndex=index
                                    }
                                }
                            }
                        }
                    }
                }
                Text{
                    text:"Боевой опыт"
                    anchors{
                         right: parent.right
                         left: parent.left
                    }
                    horizontalAlignment: Text.AlignHCenter
                    font{
                        pointSize: 20
                    }
                }
                Text{
                    anchors{
                         right: parent.right
                         left: parent.left
                         margins: 4
                    }
                    text:"Мощь героя: " + heroList.currentItem.hero.heroPower
                    font.pointSize: 14
                    //horizontalAlignment: Text.AlignHCenter
                }
                Item{
                    anchors{
                         right: parent.right
                         left: parent.left
                    }
                    height: width*2
                    ListView{
                        anchors.fill: parent
                        model:heroList.currentItem.hero.stats
                        interactive: false
                        anchors.margins: 4
                        spacing:4
                        delegate: Item{
                            id:statsDelegate
                            anchors{
                                left:parent.left
                                right:parent.right
                            }
                            height:50
                            RowLayout{
                                anchors.fill: parent
                                spacing: -1
                                Rectangle{
                                    color:"lightgrey"
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Text{
                                        anchors.fill: parent
                                        anchors.leftMargin: 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                        text:modelData.title
                                    }
                                    border.width: 2
                                    radius:4
                                }
                                Rectangle{
                                    color:"lightgrey"
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: 40
                                    Text{
                                        anchors.fill: parent
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        text:modelData.basicCost
                                    }
                                    border.width: 2
                                    radius:4
                                }
                                Rectangle{
                                    color:"lightgrey"
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: 40
                                    Text{
                                        anchors.fill: parent
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        text:modelData.battlePoints
                                    }
                                    border.width: 2
                                    radius:4
                                }
                                Rectangle{
                                    color:"lightgrey"
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: 40
                                    Text{
                                        anchors.fill: parent
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        text:modelData.finalCost
                                    }
                                    border.width: 2
                                    radius:4
                                }
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            border.width: 2
            id:skillSettingsView
            Layout.fillHeight: true
            Layout.fillWidth: true
            property Skill currentSkill:skillGrid.currentItem.skill
            Column{
                anchors.fill: parent
                Text{
                    anchors{
                        left:parent.left
                        right:parent.right
                    }
                    height: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text:skillSettingsView.currentSkill.name
                }
                SkillStatDelegate{
                    stat:skillSettingsView.currentSkill.castTime
                }
                SkillStatDelegate{
                    stat:skillSettingsView.currentSkill.recastTime
                }
//                SkillStatDelegate{
//                    stat:skillSettingsView.currentSkill.emissions
//                }
            }
        }
    }
}

