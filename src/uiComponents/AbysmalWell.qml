import QtQuick 2.5
import QtQuick.Layouts 1.1

import eh3 1.0

import "../coreComponents"
import "../sprites"

Rectangle {
    id:hall
    color:"darkgreen"




    /*NormalBehaviour{
        Prowl{
            Discover{
                Scout{

                }
                Walk{

                }
                UsePowerPoint{

                }
                Collect{

                }
            }
            Fight{
                OffensiveMove{

                }
                DefensiveMove{

                }
            }
            Escape{
                DefensiveMove{

                }
                EscapeMove{

                }
            }
        }
        HuntTarget{
            TraverseDestination{
                Scout{

                }
                Walk{

                }
            }
            Fight{

            }
            Escape{

            }
            AcquireBounty{
                Collect{

                }
                Idle{

                }
            }
        }
        HoldArea{
            TraverseDestination{

            }
            Fight{

            }
            Dispose{
                Patrol{

                }
                Locate{

                }
                Collect{

                }
            }
            Recover{
                Hide{

                }
                RestoreAction{

                }
            }
        }
    }
    PickValuableItem{
        Walk{

        }
        PickItem{

        }
    }*/

    Rectangle{
        color:"black"
        width: 100
        height: 50
        x:400
        y:700
        z:y+height
    }

    Character{
        id:heroDelegate
        speed: 250
        sprite:"qrc:///sprites/ArcherSprite.qml"
    }

    PathMap{
        id:locationPathMap
        location: hall
        cellSize: game.cellSize
    }

    MouseArea{
        anchors.fill: parent
        onClicked:{
            var x=mouseX, y=mouseY

            //select order type
            var order = function(){ heroDelegate.behaviour.orderMove(x, y) }

            //select execution moment
            if(mouse.modifiers & Qt.ShiftModifier){
                heroDelegate.behaviour.enqueueOrder(order)
            }else{
                heroDelegate.behaviour.resetOrderQueue()
                order()
            }
        }
    }

    Component.onCompleted:{
        locationPathMap.rebuildTerrainData()
    }

}

