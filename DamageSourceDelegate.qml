import QtQuick 2.5
import QtQuick.Controls 1.4

Item{
    property var actualSource
    property bool dot:false
    property real subshift:24
    signal removeRequested
    anchors{
        left: parent.left
        right: parent.right
    }
    height:statColumn.implicitHeight
    Column{
        id:statColumn
        anchors.fill: parent
        spacing:0
        SkillStatDelegate {
            stat:actualSource
            showValue:false
            statTitle:stat.title + " " + (index+1)
            Button{
                anchors{
                    top:parent.top
                    right:parent.right
                    bottom:parent.bottom
                    margins: 2
                }
                //width:40
                text:"Удалить"
                onClicked: removeRequested()
            }
        }
        ComboBox{
            currentIndex: typesList.find(actualSource.damageType)
            anchors{
                left: parent.left
                right: parent.right
                leftMargin: subshift
                rightMargin: 4
            }
            model:ListModel{
                id:typesList
                function find(damageType){
                    for(var i=0;i<count;++i)
                        if(get(i).val===damageType)
                            return i
                    return 0
                }
                ListElement { text: "Вода"; val: "water" }
                ListElement { text: "Огонь"; val: "fire" }
                ListElement { text: "Энтропия"; val: "entropy" }
            }
            onCurrentIndexChanged:actualSource.damageType=model.get(currentIndex).val
//            property bool wasInit:false
//            Component.onCompleted:{
//                currentIndex=typesList.find(actualSource.damageType)
//                wasInit=true
//            }
        }
        SkillStatDelegate{
            stat:actualSource.damage
            anchors.leftMargin: subshift
        }
        SkillStatDelegate{
            stat:actualSource.specialEffect
            anchors.leftMargin: subshift
        }
        SkillStatDelegate{
            visible:dot
            stat:dot ? actualSource.duration : actualSource
            showValue:dot
            anchors.leftMargin: subshift
        }
    }
}
