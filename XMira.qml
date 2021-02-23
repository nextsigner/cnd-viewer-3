import QtQuick 2.0
import QtGraphicalEffects 1.12

Item {
    id: r
    width: w
    height: w
    property int w: app.fs
    property bool mov: false
    property int b1: 6
    property int b2: 6
    onMovChanged: {
        if(mov){
            mira.visible=false
        }
    }
    Rectangle{
        id: mira
        width: r.w
        height: width
        radius: width*0.5
        border.width: r.b1
        border.color: 'red'
        color: 'transparent'
        anchors.centerIn: parent
        Rectangle{
            width: parent.width+r.b1*2
            height: width
            radius: width*0.5
            border.width: r.b2
            border.color: 'white'
            color: 'transparent'
            anchors.centerIn: parent
            z:parent.z-1
        }
    }
    Timer{
        running: true
        repeat: true
        interval: 350
        onTriggered: {
            mira.visible=!mira.visible
        }
    }
}
