import QtQuick 2.0
import QtGraphicalEffects 1.12

Rectangle {
    id: r
    width: rowCuerpos.width
    height: app.fs*0.9
    color: arrColors[tipo]
    border.width: 2
    border.color: 'white'
    radius: app.fs*0.1
    property var arrPlanetas: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'n', 's', 'hiron', 'proserpina', 'selena', 'lilith']
    property int tipo: -1
    property string c1: 'moon'
    property string c2: 'sun'
    property string asp: ''
    property var arrColors: ['green', '#ff8833', 'red', '#124cb1']
    Row{
        id: rowCuerpos
        spacing: app.fs*0.1
        anchors.centerIn: r
        Repeater{
            model: 2
            Item{
                width: app.fs*0.7
                height: width
                Image {
                    id: iconoPlaneta
                    source: index===0?"./resources/imgs/planetas/"+r.c1+".svg":"./resources/imgs/planetas/"+r.c2+".svg"
                    visible: false
                    anchors.fill: parent
                }
                ColorOverlay {
                    anchors.fill: iconoPlaneta
                    source: iconoPlaneta
                    color: 'white'
                }

            }
        }
    }
    Component.onCompleted: {
        if(asp==='Trine'){
            r.tipo=0
        }
        if(asp==='Quadrature'){
            r.tipo=1
        }
        if(asp==='Opposition'){
            r.tipo=2
        }
        if(asp==='Conjunction'){
            r.tipo=3
        }
    }
}
/*
Debug: Asp: Trine Venus-Neptune c1:venus c2:neptune (file:///home/ns/nsp/uda/cnd-viewer-3/main.qml:386, load)

Debug: Asp: Conjunction Mars-Jupiter c1:mars c2:jupiter (file:///home/ns/nsp/uda/cnd-viewer-3/main.qml:386, load)

Debug: Asp: Quadrature Mars-Saturn c1:mars c2:saturn (file:///home/ns/nsp/uda/cnd-viewer-3/main.qml:386, load)

Debug: Asp: Quadrature Jupiter-Saturn c1:jupiter c2:saturn (file:///home/ns/nsp/uda/cnd-viewer-3/main.qml:386, load)
Debug: Asp: Trine Saturn-Lilith c1:saturn c2:lilith (file:///home/ns/nsp/uda/cnd-viewer-3/main.qml:386, load)

Debug: Asp: Opposition Uranus-Hiron c1:uranus c2:hiron (file:///home/ns/nsp/uda/cnd-viewer-3/main.qml:386, load)

Debug: Asp: Conjunction Uranus-Proserpina c1:uranus c2:proserpina (file:///home/ns/nsp/uda/cnd-viewer-3/main.qml:386, load)

Debug: Asp: Opposition Hiron-Proserpina c1:hiron c2:proserpina (file:///home/ns/nsp/uda/cnd-viewer-3/main.qml:386, load)

*/
