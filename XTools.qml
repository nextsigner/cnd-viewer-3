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
                let fileLocation='/home/ns/nsp/uda/cnd-viewer-3/iw/main.qml'
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
    function getJSON(fileLocation, comp, s, c, nomCuerpo) {
        var request = new XMLHttpRequest()

        //Url GitHub Raw Data
        //https://github.com/nextsigner/quiron/raw/main/data/pluton.json

        //Url File Local Data
        //'file:///home/ns/Documentos/unik/quiron/data/neptuno.json'

        let jsonFileUrl='file:///home/ns/nsp/uda/quiron/data/'+fileLocation
        //console.log('jsonFileUrl: '+jsonFileUrl)
        request.open('GET', jsonFileUrl, true);
        //request.open('GET', 'https://github.com/nextsigner/quiron/raw/main/data/'+cbPlanetas.currentText+'.json', true);
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status && request.status === 200) {
                    //console.log(":::", request.responseText)
                    var result = JSON.parse(request.responseText)
                    if(result){
                        //console.log(result)
                        //console.log('Abriendo casa de json: '+c)
                        console.log('Abriendo dato signo:'+s+' casa:'+c+'...')
                        let dataJson0=''
                        let data=''//+result['h'+c]
                        if(result['h'+c]){
                            console.log('Abriendo dato de casa... ')
                            dataJson0=result['h'+c].split('|')
                            data='<h2>'+nomCuerpo+' en casa '+c+'</h2>'
                            for(var i=0;i<dataJson0.length;i++){
                                data+='<p>'+dataJson0[i]+'</p>'
                            }
                        }
                        //console.log('Signo para mostar: '+s)
                        if(result['s'+s]){
                            console.log('Abriendo dato de signo... ')
                            dataJson0=result['s'+s].split('|')
                            data+='<h2>'+nomCuerpo+' en '+app.signos[s - 1]+'</h2>'
                            for(i=0;i<dataJson0.length;i++){
                                data+='<p>'+dataJson0[i]+'</p>'
                            }
                        }
                        let obj=comp.createObject(app, {textData:data, width: app.fs*14, fs: app.fs*0.5, title: nomCuerpo+' en '+app.signos[s]+' en casa '+c})
                    }
                    //console.log('Data-->'+JSON.stringify(result))
                } else {
                    console.log("HTTP:", request.status, request.statusText)
                }
            }
        }
        request.send()
    }

    function quitarAcentos(cadena){
        const acentos = {'á':'a','é':'e','í':'i','ó':'o','ú':'u','Á':'A','É':'E','Í':'I','Ó':'O','Ú':'U'};
        return cadena.split('').map( letra => acentos[letra] || letra).join('').toString();
    }
}
