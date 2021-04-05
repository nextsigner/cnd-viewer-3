import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: r
    width: app.fs*6
    height: app.fs*3
    border.width: 2
    border.color: 'red'
    color: 'transparent'
    Column{
        anchors.centerIn: r
        Button{
            text: app.uSon
            anchors.horizontalCenter: parent.horizontalCenter
            visible: app.uSon!==''
            onClicked: {
                app.showIW()
            }
        }
        Button{
            text: 'Archivos'
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {               
                app.showIWFILES()
            }
        }
        Button{
            visible: app.uSon.indexOf('asc_')===0||app.uSon.indexOf('mc_')===0
            text: 'Sabianos'
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                if(app.uSon.indexOf('asc_')===0){
                    app.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uAscDegree-1)
                }
                if(app.uSon.indexOf('mc_')===0){
                    app.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uMcDegree-1)
                }
            }
        }
    }
    /*XCamera{
        id: xCamera
        anchors.centerIn: r
    }*/
}
