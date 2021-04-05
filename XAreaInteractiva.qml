import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: r
    width: 100
    height: 500
    color: 'transparent'
    border.width: 4
    border.color: 'pink'
    signal seteandoObj(string objName, bool set)
    property int uCA: -1

    Rectangle {
        id: rueda
        width: app.fs*14
        height: width
        radius: width*0.5
        color: 'transparent'
        border.width: 0//poner en 3 para ver si está centrado
        border.color: 'blue'
        anchors.centerIn: r
        anchors.horizontalCenterOffset: app.fs*0.77
    }
    Rectangle{
        id: xMsgProcDatos
        width: txtPD.contentWidth+app.fs
        height: app.fs*4
        color: 'black'
        border.width: 2
        border.color: 'white'
        visible: false
        Text {
            id: txtPD
            text: 'Procesando datos...'
            font.pixelSize: app.fs
            color: 'white'
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: parent.visible=false
        }
    }
    Component{
        id: sc
        Rectangle{
            id: compSen
            width: 2//rueda.width
            height: rueda.width
            anchors.centerIn: parent
            rotation: 45
            color: 'transparent'
            property string son: '???'
            property string info1: '???'
            property string info2: '???'
            property string info3: '???'
            Rectangle{
                id: xMASC
                width: app.fs*0.15
                height: parent.height/2
                border.width: 0
                border.color: 'yellow'
                radius: width*0.5
                color: 'transparent'
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.left: parent.left
                property bool show: false
                property bool seted: false
                onYChanged: {
                    border.width=1
                    tHideBorder.restart()
                }
                /*Rectangle{
                    id: bug
                    width: parent.width
                    height: width
                    color: 'red'
                    anchors.centerIn: parent
                    visible: false
                }
                Rectangle{
                    id: mask
                    width: 5
                    height: width
                    color: 'blue'
                    anchors.centerIn: parent
                    visible: false
                }*/
                Rectangle{
                    id: centroMira
                    width: 6
                    height: width
                    radius: width*0.5
                    antialiasing: true
                    color: parent.border.color
                    anchors.centerIn: parent
                    visible: parent.border.width>0
                    rotation: 360-parent.parent.rotation

                }

                Timer{
                    id: tHideBorder
                    running: false
                    repeat: false
                    interval: 3000
                    onTriggered: parent.border.width=0
                }

                Rectangle{
                    anchors.fill: parent
                    color: 'transparent'
                    Behavior on opacity {
                        NumberAnimation{duration: 200}
                    }
                    MouseArea{
                        id: maSC
                        anchors.fill: parent
                        hoverEnabled: true
                        drag.target: parent.parent
                        drag.axis: Drag.YAxis
                        //drag.active: true
                        onClicked: {
                            if(!xMASC.seted){
                                xMASC.height=app.fs*0.85//xMASC.parent.height/2-mouseY
                                xMASC.width=xMASC.height
                                xMASC.y=mouseY-app.fs*0.85*0.5
                                xMASC.seted=true

                                //maSC.anchors.fill=xMASC
                                //pos.y=mouseY+xMASC-width//-app.fs*0.25
                            }
                            if(!app.lock){
                                app.setInfo(compSen.info1, compSen.info2, compSen.info3, compSen.son)
                            }
                            xAsp.resaltar(compSen.son.split('_')[0])
                            xMiraSen.visible=!xMiraSen.visible
                            r.seteandoObj(son, xMiraSen.visible)
                            //console.log('Seteando '+son)
                        }
                        onDoubleClicked: {
                            xMiraSen.visible=true
                            app.lock=true
                            app.setInfo(compSen.info1, compSen.info2, compSen.info3,compSen.son)
                            maSC.enabled=false
                            tShowMASC.restart()
                        }
                        onEntered: {
                            if(!app.lock){
                                app.setInfo(compSen.info1, compSen.info2, compSen.info3, compSen.son)
                            }
                        }
                        onExited: {
                            if(!app.lock){
                                app.setInfo('', '', '','')
                            }
                        }
                    }
                    Timer{
                        id: tShowMASC
                        running: false
                        repeat: false
                        interval: 1500
                        onTriggered: {
                            maSC.enabled=true
                        }
                    }
                }
                Rectangle{
                    width: 2
                    height: 8000
                    color: parent.border.color
                    opacity: parent.border.width!==0?1.0:0.0
                    onOpacityChanged: {
                        x=parent.width*0.5-width*0.5
                        y=parent.height*0.5-2
                        //rotation=360-parent.parent.rotation
                    }
                    Behavior on opacity{
                        NumberAnimation{duration: 250}
                    }
                    Item{
                        id: xAxis
                        width: 4
                        height: 100
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.top
                        rotation: 360-compSen.rotation
                        //opacity: parent.border.width!==0?1.0:0.0
                        Row{
                            spacing: xMASC.height
                            anchors.centerIn: parent
                            Repeater{
                                model: 2
                                Rectangle{
                                    width: 8000
                                    height: 4
                                    color: 'yellow'
                                }
                            }
                        }
                        Row{
                            rotation: 90
                            spacing: xMASC.height
                            anchors.centerIn: parent
                            Repeater{
                                model: 2
                                Rectangle{
                                    width: 8000
                                    height: 4
                                    color: 'yellow'
                                }
                            }
                        }
                    }
                }
            }

            XMira{
                id: xMiraSen
                w:app.fs*1.5
                mov: false//enabled?img.mov:true
                anchors.centerIn: xMASC
                visible: false
                property bool enabled: true
            }
            function activar(){
                xAsp.resaltar(compSen.son.split('_')[0])
                app.setInfo(compSen.info1, compSen.info2, compSen.info3,compSen.son)
            }
            function acercarAlCentro(){
                if(!xMASC.seted){
                    xMASC.height=app.fs*0.85//xMASC.parent.height/2-mouseY
                    xMASC.width=xMASC.height
                    xMASC.seted=true
                }
                xMASC.y+=1
            }
            function acercarAlBorde(){
                if(!xMASC.seted){
                    xMASC.height=app.fs*0.85//xMASC.parent.height/2-mouseY
                    xMASC.width=xMASC.height
                    xMASC.seted=true
                }
                xMASC.y-=1
            }
        }
    }
    Component{
        id: scAsc
        Rectangle{
            id: compSenAsc
            width: 2//rueda.width
            height: rueda.width
            anchors.centerIn: parent
            rotation: 45
            color: rotation===-90?'transparent':'red'
            property string son: '???'
            property string info1: '???'
            property string info2: '???'
            property string info3: '???'
            Rectangle{
                id: xMASCASC
                width: app.fs*1.5
                height: width//parent.height/2
                border.width: 0
                border.color: 'yellow'
                radius: width*0.5
                color:  'transparent'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 0-app.fs*1.5
                property bool show: false
                property bool seted: false
                onYChanged: {
                    border.width=1
                    tHideBorder.restart()
                }
                Timer{
                    id: tHideBorder
                    running: false
                    repeat: false
                    interval: 100
                    onTriggered: parent.border.width=0
                }

                Rectangle{
                    anchors.fill: parent
                    color: 'transparent'
                    Behavior on opacity {
                        NumberAnimation{duration: 200}
                    }
                    MouseArea{
                        id: maSC
                        anchors.fill: parent
                        hoverEnabled: true
                        drag.target: parent.parent
                        drag.axis: Drag.YAxis
                        //drag.active: true
                        onClicked: {
                            if(!xMASCASC.seted){
                                //xMASC.height=app.fs*0.85//xMASC.parent.height/2-mouseY
                                //xMASC.width=xMASC.height
                                //xMASC.y=mouseY-app.fs*0.85*0.5
                                //xMASC.seted=true

                                //maSC.anchors.fill=xMASC
                                //pos.y=mouseY+xMASC-width//-app.fs*0.25
                            }
                            if(!app.lock){
                                app.setInfo(compSenAsc.info1, compSenAsc.info2, compSenAsc.info3, compSenAsc.son)
                            }
                            xMiraSenAsc.visible=!xMiraSenAsc.visible
                            r.seteandoObj(son, xMiraSenAsc.visible)
                            //console.log('Seteando '+son)
                        }
                        onDoubleClicked: {
                            xMiraSenAsc.visible=true
                            app.lock=true
                            console.log('111 Set son: '+compSenAsc.son)
                            app.setInfo(compSenAsc.info1, compSenAsc.info2, compSenAsc.info3, compSenAsc.son)
                            maSC.enabled=false
                            tShowMASC.restart()
                        }
                        onEntered: {
                            if(!app.lock){
                                app.setInfo(compSenAsc.info1, compSenAsc.info2, compSenAsc.info3, compSenAsc.son)
                            }
                        }
                        onExited: {
                            if(!app.lock){
                                app.setInfo('', '', '','')
                            }
                        }
                    }
                    Timer{
                        id: tShowMASC
                        running: false
                        repeat: false
                        interval: 1500
                        onTriggered: {
                            maSC.enabled=true
                        }
                    }
                }
            }
            XMira{
                id: xMiraSenAsc
                w:app.fs*2.5
                mov: false//enabled?img.mov:true
                anchors.centerIn: xMASCASC
                visible: false
                property bool enabled: true
            }
        }
    }
    function next(){
        if(r.uCA<15){
            r.uCA++
        }else{
            r.uCA=0
        }
        rueda.children[r.uCA].activar()
    }
    function back(){
        if(r.uCA>0){
            r.uCA--
        }else{
            r.uCA=15
        }
        rueda.children[r.uCA].activar()
    }
    function acercarAlCentro(){
        rueda.children[r.uCA].acercarAlCentro()
    }
    function acercarAlBorde(){
        rueda.children[r.uCA].acercarAlBorde()
    }
    function loadData(){
        clearRueda()
        let fn=apps.url.replace('cap_', '').replace('.png', '')
        let jsonFileName=fn+'.json'//'/home/ns/temp-screenshots/'+ms+'.json'
        console.log('FileName SC: '+jsonFileName)
        let jsonFileData=unik.getFile(jsonFileName)
        //console.log(jsonFileData)
        let jsonData=JSON.parse(jsonFileData)
        //let numSigno=app.objSignsNames.indexOf()

        if(!jsonData.asp){
            xMsgProcDatos.visible=true
            let name=jsonData.params.n
            let folderZodiacUser='/home/ns/zodiacserver/bin/user'
            let fileDatLocation=folderZodiacUser+'/'+name+'.dat'
            if(!unik.fileExist(fileDatLocation)){
                name='\''+name.replace(/ /g,' ')+'.dat'+'\''
                fileDatLocation=folderZodiacUser+'/'+name
            }
            //Argumentos fileName 1975 6 20 23 00 -3 -35.484462 -69.5797495 Malargue_Mendoza C:/nsp/uda/temp/data.json 15321321 10 "C:/nsp/uda/temp/capture.png" 1280x720 1280x720
            let cmd='wine /home/ns/zodiacserver/bin/zodiac_server.exe '+(''+jsonData.params.n).replace(/ /g, '_')+' '+jsonData.params.a+' '+jsonData.params.m+' '+jsonData.params.d+' '+jsonData.params.h+' '+jsonData.params.m+' '+jsonData.params.gmt+' '+jsonData.params.lat+' '+jsonData.params.lon+' '+(''+jsonData.params.ciudad).replace(/ /g, '_')+' /home/ns/temp-screenshots/'+jsonData.params.ms+'.json '+jsonData.params.ms+' 3  /home/ns/temp-screenshots/cap_'+jsonData.params.ms+'.png  2560x1440 2560x1440'
            console.log('CMD: '+cmd)
            unik.ejecutarLineaDeComandoAparte(cmd)
            return
        }else{
            xMsgProcDatos.visible=false
        }

        let sObj=''
        let obj

        sObj='sun'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='moon'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='mercury'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='venus'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='mars'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='jupiter'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='saturn'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='uranus'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='neptune'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='pluto'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='n'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='s'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='hiron'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='proserpina'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='selena'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='lilith'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        addSCAsc('asc', jsonData.pc.h1.s, jsonData.pc.h1.g, jsonData.pc.h1.m, jsonData)
        addSCMc('mc', jsonData.pc.h10.s, jsonData.pc.h10.g, jsonData.pc.h10.m, jsonData)

        //        sObj='Ascendente'
        //        obj=jsonData.psc[sObj]
        //        addSC(sObj, 'Ascendente', jsonData.pc.h1.g, jsonData.pc.h1.m, ('i').toUpperCase(), jsonData)
    }
    function clearRueda(){
        for(var i=0;i<rueda.children.length;i++){
            rueda.children[i].destroy(1)
        }
    }
    function addSC(c, s, g, m, h, j){
        let numSigno=app.objSignsNames.indexOf(j.pc.h1.s)
        let gAsc=j.pc.h1.g+numSigno*30
        //console.log('NumSig:'+numSigno)
        //console.log('gAsc:'+gAsc)
        let vRCuerpo=30*getSigIndex(s)
        let gTotSig=0-vRCuerpo+gAsc-g-90//gAsc-(app.objSignsNames.indexOf(s)+1)*30+g//+(360-gAsc)
        //console.log('-->'+c+' '+s+' '+g+' '+app.objSignsNames.indexOf(s))
        let fs=parseInt(app.fs*1.5)
        let fs2=parseInt(fs *0.7)
        //console.log('Planeta: '+app.planetas[app.planetasRes.indexOf(c)])
        let info1='<b>'+app.planetas[app.planetasRes.indexOf(c)]+'</b>'
        let info2='<b style="font-size:'+fs+'px">'+app.signos[app.objSignsNames.indexOf(s)]+'</b>'
        let info3='<b style="font-size:'+fs2+'px">°'+g+'\''+m+' Casa '+h+'</b>'
        let comp=sc
        let obj=comp.createObject(rueda, {rotation: gTotSig, info1:info1,  info2:info2, info3:info3, son: ''+c+'_'+s+'_'+h})
    }
    function addSCAsc(c, s, g, m, j){
        app.uAscDegree=g
        let fs=parseInt(app.fs*1.5)
        let fs2=parseInt(fs *0.4)
        let info1='<b  style="font-size:'+parseInt(fs*0.8)+'px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Signo</b><br />'
        info1+='<b  style="font-size:'+parseInt(fs*1.1)+'px;">Ascendente</b>'
        let info2='<b style="font-size:'+fs+'px;">'+app.signos[app.objSignsNames.indexOf(s)]+'</b>'
        let info3='<b style="font-size:'+fs2+'px;">°'+g+'\''+m+' Casa I</b>'
        let comp=scAsc
        let obj=comp.createObject(rueda, {rotation: -90, info1:info1,  info2:info2, info3:info3, son: ''+c+'_'+s+'_I'})
    }
    function addSCMc(c, s, g, m, j){
        app.uMcDegree=g
        let fs=parseInt(app.fs*1.5)
        let fs2=parseInt(fs *0.4)
        let info1='<b  style="font-size:'+parseInt(fs*0.8)+'px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Signo</b><br />'
        info1+='<b  style="font-size:'+parseInt(fs*1.1)+'px;">Medio Cielo</b>'
        let info2='<b style="font-size:'+fs+'px;">'+app.signos[app.objSignsNames.indexOf(s)]+'</b>'
        let info3='<b style="font-size:'+fs2+'px;">°'+g+'\''+m+' Casa X</b>'
        let comp=scAsc
        let indexSign=app.objSignsNames.indexOf(s)
        let totalDegrees=30*indexSign+g
        let numSigno=app.objSignsNames.indexOf(j.pc.h1.s)
        let gAsc=j.pc.h1.g+numSigno*30
        let obj=comp.createObject(rueda, {rotation: -90+gAsc-totalDegrees, info1:info1,  info2:info2, info3:info3, son: ''+c+'_'+s+'_X'})
    }
    function getSigIndex(s){
        let ms=['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
        return ms.indexOf(s)
    }
    function getAbsPos(grado){
        let _rads= grado * Math.PI/180
        let xOffset= Math.cos(_rads)
        let yOffset= Math.sin(_rads)
        return {x: xOffset, y: yOffset}
    }
}
