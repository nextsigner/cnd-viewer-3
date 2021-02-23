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
                console.log('uSon: '+app.uSon)
                let m0=app.uSon.split('_')
                let fileLocation='/home/ns/nsp/uda/cnd-viewer-2/iw/main.qml'
                let comp=Qt.createComponent(fileLocation)

                //Cuerpo en Casa
                let nomCuerpo=m0[0]!=='asc'?app.planetas[app.planetasRes.indexOf(m0[0])]:'Ascendente'
                let jsonFileName=m0[0]!=='asc'?quitarAcentos(nomCuerpo.toLowerCase())+'.json':'asc.json'
                let jsonFileLocation='/home/ns/nsp/uda/quiron/data/'+jsonFileName
                if(!unik.fileExist(jsonFileLocation)){
                    let obj=comp.createObject(app, {textData:'No hay datos disponibles.', width: app.fs*8, height: app.fs*3, fs: app.fs*0.5, title:'Sin datos'})
                }else{
                    let numHome=m0[0]!=='asc'?-1:1
                    let vNumRom=['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII']
                    numHome=vNumRom.indexOf(m0[2])+1
                    //console.log('::::Abriendo signo: '+app.objSignsNames.indexOf(m0[1])+' casa: '+numHome+' nomCuerpo: '+nomCuerpo)
                    getJSON(jsonFileName, comp, app.objSignsNames.indexOf(m0[1])+1, numHome, nomCuerpo)
                }
            }
        }
        Button{
            text: 'Archivos'
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                console.log('uSon: '+app.uSon)
                let m0=app.uSon.split('_')
                let fileLocation='/home/ns/nsp/uda/cnd-viewer-3/iwfiles/main.qml'
                let comp=Qt.createComponent(fileLocation)
                let obj=comp.createObject(app, {comp: app, width: app.fs*14, fs: app.fs*0.5, title:'Cargar Archivos'})
            }
        }
    }
    function quitarAcentos(cadena){
        const acentos = {'á':'a','é':'e','í':'i','ó':'o','ú':'u','Á':'A','É':'E','Í':'I','Ó':'O','Ú':'U'};
        return cadena.split('').map( letra => acentos[letra] || letra).join('').toString();
    }
}
