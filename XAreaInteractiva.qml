import QtQuick 2.0

Rectangle {
    id: r
    width: 100
    height: 500
    color: 'transparent'
    border.width: 4
    border.color: 'pink'
    signal seteandoObj(string objName, bool set)
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
            }
            XMira{
                id: xMiraSen
                w:app.fs*1.5
                mov: false//enabled?img.mov:true
                anchors.centerIn: xMASC
                visible: false
                property bool enabled: true
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
            color: 'transparent'
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
    function loadData(){
        let fn=app.url.replace('cap_', '').replace('.png', '')
        let jsonFileName=fn+'.json'//'/home/ns/temp-screenshots/'+ms+'.json'
        console.log('FileName SC: '+jsonFileName)
        let jsonFileData=unik.getFile(jsonFileName)
        //console.log(jsonFileData)
        let jsonData=JSON.parse(jsonFileData)
        //let numSigno=app.objSignsNames.indexOf()

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

        //        sObj='Ascendente'
        //        obj=jsonData.psc[sObj]
        //        addSC(sObj, 'Ascendente', jsonData.pc.h1.g, jsonData.pc.h1.m, ('i').toUpperCase(), jsonData)
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
        let fs=parseInt(app.fs*1.5)
        let fs2=parseInt(fs *0.4)
        let info1='<b  style="font-size:'+parseInt(fs*0.8)+'px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Signo</b><br />'
        info1+='<b  style="font-size:'+parseInt(fs*1.1)+'px;">Ascendente</b>'
        let info2='<b style="font-size:'+fs+'px;">'+app.signos[app.objSignsNames.indexOf(s)]+'</b>'
        let info3='<b style="font-size:'+fs2+'px;">°'+g+'\''+m+' Casa I</b>'
        let comp=scAsc
        let obj=comp.createObject(rueda, {rotation: -90, info1:info1,  info2:info2, info3:info3, son: ''+c+'_'+s+'_I'})
    }
    function getSigIndex(s){
        let ms=['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
        return ms.indexOf(s)
    }
}
