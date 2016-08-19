import QtQuick 2.7 as QQ
import QtQuick.Layouts 1.2
import Qt3D.Core 2.0
import Qt3D.Render 2.0
//import Qt3D.Input 2.0
import Qt3D.Extras 2.0
import QtQuick.Scene3D 2.0

import "../debugComponents"

QQ.Rectangle{
    property var sourceHero
    border.width: 2
    id:heroView
    Layout.fillHeight: true
    Layout.preferredWidth: baseWidth * 0.3 * sizeSet


    Scene3D{
        id:scene3d
        anchors.fill: parent
        cameraAspectRatioMode: Scene3D.AutomaticAspectRatio


        Entity {
            id: sceneRoot

            Camera {
                id: camera
                projectionType: CameraLens.PerspectiveProjection
                fieldOfView: 45
                aspectRatio: scene3d.width/scene3d.height
                nearPlane : 0.1
                farPlane : 1000.0
                position: Qt.vector3d( 0.0, 0.0, -40.0 )
                upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
                viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
            }


            components: [
                RenderSettings {
                    activeFrameGraph: ForwardRenderer {
                        clearColor: Qt.rgba(0, 0.5, 1, 1)
                        camera: camera
                    }
                }
            ]

            PhongMaterial {
                id: material
            }

            Mesh {
                id: torusMesh
                source:"qrc:///models/mouse.obj"
            }

            Transform {
                id: torusTransform
                scale3D: Qt.vector3d(0.05, 0.05, 0.05)
                rotation: fromAxisAndAngle(Qt.vector3d(0, 1, 0), 180 + mouseControl.rotation * factor)
            }

            Entity {
                id: torusEntity
                components: [ torusMesh, material, torusTransform ]
            }

        }
    }
    QQ.TextInput{
        anchors.centerIn: parent
        text:sourceHero ? sourceHero.name : ""
        onEditingFinished:{
            if(sourceHero)
                sourceHero.name=text
            focus=false
        }
    }
    property real factor:1.0
    QQ.MouseArea{
        id:mouseControl
        anchors.fill: parent
        property real pos
        property real rotation:0.0
        readonly property real snap: 1.0
        onPressed: pos=mouseX
        onMouseXChanged: {
            var dx=mouseX-pos
            pos=mouseX
            rotation+=dx
        }
    }

    Evaluator{
        objectName: "heroView"
    }
}
