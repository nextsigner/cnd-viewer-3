import QtQuick 2.0

Rectangle {
    id: r
    width: 100
    height: 500
    color: 'transparent'
    border.width: 40
    border.color: 'pink'
    Rectangle {
        id: rueda
        width: r.width*0.425
        height: width
        radius: width*0.5
        color: 'transparent'
        border.width: 0//poner en 3 para ver si está centrado
        border.color: 'blue'
        anchors.centerIn: r
        anchors.horizontalCenterOffset: app.fs*1.5
//        MouseArea{
//            anchors.fill: rueda
//            onClicked: {
//                for(var i=0;i<rueda.children.length;i++){
//                    console.log('Obj: '+rueda.children[i].objectName)
//                    if(rueda.children[i].objectName==='sun_psc'){
//                        rueda.children[i].activar()
//                    }
//                }
//                //rueda['sun_psc'].activar()
//            }
//        }
    }
    Component{
        id: sc
        Rectangle{
            id: compSenZoom
            width: 2//rueda.width
            height: rueda.width
            anchors.centerIn: parent
            rotation: 45
            color: 'transparent'
            //objectName: info1+'_'+info2
            property string info1: '???'
            property string info2: '???'
            property string info3: '???'
            Rectangle{
                id: info
                width: app.fs*7.24
                height: width
                radius: width*0.5
                border.width: 4
                border.color: 'red'
                clip: true
                anchors.centerIn: parent
                rotation: 0-parent.rotation
                property bool show: false
                opacity: 0.0//show?1.0:0.0
                Behavior on opacity {
                    NumberAnimation{duration: 200}
                }
                Column{
                    spacing: app.fs*0.1
                    anchors.centerIn: parent
                    Text {
                        id: i1
                        color: 'red'
                        font.pixelSize: app.fs*1.5
                        text: compSenZoom.info1
                        width: parent.width-app.fs
                        wrapMode: Text.WordWrap
                        textFormat: Text.RichText
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        id: i2
                        color: 'red'
                        font.pixelSize: app.fs*2
                        text: compSenZoom.info2
                        width: parent.width-app.fs*1.5
                        wrapMode: Text.WordWrap
                        textFormat: Text.RichText
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        id: i3
                        color: 'red'
                        font.pixelSize: app.fs*2
                        text: compSenZoom.info3
                        width: parent.width-app.fs
                        wrapMode: Text.WordWrap
                        textFormat: Text.RichText
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
            Rectangle{
                id: xMASCZOOM
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
                            if(!xMASCZOOM.seted){
                                xMASCZOOM.height=app.fs*0.85//xMASCZOOM.parent.height/2-mouseY
                                xMASCZOOM.width=xMASCZOOM.height
                                xMASCZOOM.y=mouseY-app.fs*0.85*0.5
                                xMASCZOOM.seted=true

                                //maSC.anchors.fill=xMASCZOOM
                                //pos.y=mouseY+xMASCZOOM-width//-app.fs*0.25
                            }
                            if(!app.lock){
                                app.setInfo(compSenZoom.info1, compSenZoom.info2, compSenZoom.info3)
                            }
                            xMiraSen.visible=!xMiraSen.visible
                        }
                        onDoubleClicked: {
                            maSC.enabled=false
                            tShowMASC.restart()
                        }
                        onEntered: {
                            if(!app.lock){
                                app.setInfo(compSenZoom.info1, compSenZoom.info2, compSenZoom.info3)
                            }
                            info.show=true
                        }
                        onExited: {
                            if(!app.lock){
                                app.setInfo('', '', '')
                            }
                            info.show=false
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
                w:app.fs*2
                mov: false//enabled?img.mov:true
                anchors.centerIn: xMASCZOOM
                visible: false
                property bool enabled: true
            }
            Text {
                id: txt
                text: '<b>'+parent.objectName.replace('_', ' en ')+'</b>'
                font.pixelSize: app.fs*2
                color: 'red'
                //visible: xMiraSen.visible
                rotation: 360-compSenZoom.rotation
                anchors.centerIn: xMiraSen
                visible: false
            }
            function activar(set){
                if(xMASCZOOM.seted){
                    xMiraSen.visible=set
                }
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
        let obj=comp.createObject(rueda, {rotation: gTotSig, info1:info1,  info2:info2, info3:info3, objectName: ''+c+'_'+s})
    }
    function getSigIndex(s){
        let ms=['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
        return ms.indexOf(s)
    }
    function setShow(objName, set){
        for(var i=0;i<rueda.children.length;i++){
            //console.log('Obj: '+rueda.children[i].objectName)
            if(rueda.children[i].objectName===objName){
                rueda.children[i].activar(set)
            }
        }
    }
}
