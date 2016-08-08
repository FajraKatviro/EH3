import QtQuick 2.5
import QtQuick.Layouts 1.1

Rectangle{
    property var sourceHero
    border.width: 2
    id:heroView
    Layout.fillHeight: true
    Layout.preferredWidth: 300
    TextInput{
        anchors.centerIn: parent
        text:sourceHero ? sourceHero.name : ""
        onEditingFinished:{
            if(sourceHero)
                sourceHero.name=text
            focus=false
        }
    }
}
