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

    property string model: sourceHero.model
    property real modelScale: sourceHero.scale

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

            DirectionalLight{
                id:light
                worldDirection: Qt.vector3d( -0.3, -0.5, 0.2 )
                color : "white"
                intensity : 2.0
            }

            components: [
                RenderSettings {
                    activeFrameGraph: ForwardRenderer {
                        id:renderer
                        clearColor:  "#FF112244"
                        camera: camera
                    }
                }
            ]

            NormalDiffuseSpecularMapMaterial {
                id: material
                diffuse: "qrc:///models/" + heroView.model + "_diff.png"
                specular: "qrc:///models/" + heroView.model + "_spec.png"
                normal: "qrc:///models/" + heroView.model + "_norm.png"
                shininess: 0
            }

            Mesh {
                id: torusMesh
                source:"qrc:///models/" + heroView.model + ".obj"
            }

            Transform {
                id: torusTransform
                translation: Qt.vector3d(0, -10, 0)
                scale3D: Qt.vector3d(modelScale, modelScale, modelScale)
                rotation: fromAxesAndAngles(Qt.vector3d(1, 0, 0), 270, Qt.vector3d(0, 1, 0), 180 + mouseControl.rotation * factor)
            }

            Entity {
                id: torusEntity
                components: [ torusMesh, material, torusTransform, light ]
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
