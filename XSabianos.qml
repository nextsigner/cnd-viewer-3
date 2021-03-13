import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1

Rectangle {
    id: r
    visible: false
    color: 'white'
    anchors.fill: parent
    property string htmlFolder: ''
    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property int numSign: 0
    property int numDegree: 0
    property int fs: width*0.025
    property int currentInterpreter: 0
    Item{
        id: xr
        anchors.fill: parent
        focus: true
        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {
                /*if(rs.bgColor==='#ffffff'){
                    rs.bgColor='#000000'
                }else{
                    rs.bgColor='#ffffff'
                }*/
                loadData()
            }
        }
        Text{
            id: data
            text: '<h1>Los Sabianos</h1>'
            font.pixelSize: r.fs
            width: xr.width-r.fs*2
            wrapMode: Text.WordWrap
            //textFormat: Text.PlainText
            textFormat: Text.RichText
            anchors.centerIn: parent
        }
        Row{
            spacing: r.fs*0.25
            XSigno{
                id: xSigno
                numSign: r.numSign
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                id: currentSign
                text: '<b>'+r.signos[r.numSign]+'</b>'//+' ci:'+r.currentInterpreter+' ad:'+r.numDegree+' cs:'+r.numSign
                font.pixelSize: r.fs*2
                //color: 'white'
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Text {
            id: currentDegree
            property string sd: '?'
            text: '<b>'+sd+'</b>'//+' ci:'+r.currentInterpreter+' ad:'+r.numDegree+' cs:'+r.numSign
            font.pixelSize: r.fs*2
            //color: 'white'
            anchors.bottom: parent.bottom
            visible: false
        }
    }
    function ctrlDown(){
        if(r.numSign<11){
            r.numSign++
        }else{
            r.numSign=0
            r.currentInterpreter=0
        }
        loadData()
    }
    function ctrlUp(){
        if(r.numSign>0){
            r.numSign--
        }else{
            r.numSign=11
            r.currentInterpreter=0
        }
        loadData()
    }
    function down(){
        if(r.numDegree<30){
            r.numDegree++
        }else{
            r.numDegree=0
            r.currentInterpreter=0
        }
        loadData()
    }
    function up(){
        if(r.numDegree>0){
            r.numDegree--
        }else{
            r.numDegree=30
            r.currentInterpreter=0
        }
        loadData()
    }
    function left(){
        if(r.currentInterpreter>0){
            r.currentInterpreter--
        }else{
            r.currentInterpreter=2
            if(r.numDegree>0){
                r.numDegree--
            }else{
                r.numDegree=29
                r.currentInterpreter=2
                if(r.numSign>0){
                    r.numSign--
                }else{
                    r.numSign=11
                }
            }
        }
        loadData()
    }
    function right(){
        if(r.currentInterpreter<2){
            r.currentInterpreter++
        }else{
            r.currentInterpreter=0
            if(r.numDegree<29){
                r.numDegree++
            }else{
                r.numDegree=0
                r.currentInterpreter=0
                if(r.numSign<11){
                    r.numSign++
                }else{
                    r.numSign=0
                }
            }
        }
        loadData()
    }
    function makeHtml(string){
        let m0=string.split(' ')
        let html=''
        let cantGrupos=1
        for(var i=1;i<m0.length;i++){
            let m1=m0[i].split('.')
            let s=parseInt(m1[0])
            let g=parseInt(m1[1])
            let h=m1[2]

            html+='<h2>Grupo '+parseInt(i)+'</h2>\n'
            html+='<h4>Hora de Nacimiento: '+h+'hs</h4>\n'
            html+=getHtmlData(s-1,g-1,0)
            html+=getHtmlData(s-1,g-1,1)
            html+=getHtmlData(s-1,g-1,2)
            html+='\n'
            cantGrupos++
        }
        setHtml(html, m0[0])
        let d=new Date(Date.now())
        let ms=d.getTime()
        let url='https://nextsigner.github.io/sabianos/'+m0[0]+'.html?r='+ms
        let sh='#!/bin/bash\n'
        sh+='cd /home/ns/nsp/uda/nextsigner.github.io\n'
        sh+='git add *\n'
        sh+='git commit -m "se sube el html '+m0[0]+' '+ms+'"\n'
        sh+='git push origin master\n'
        sh+='echo "Html subido!"\n'
        sh+='exit\n'
        unik.setFile('/tmp/'+ms+'.sh', sh)
        unik.ejecutarLineaDeComandoAparte('sh /tmp/'+ms+'.sh')
        console.log('Url: '+url+' script=/tmp/'+ms+'.sh')
    }
    function loadData(){
        let fileData=''+unik.getFile('./360.html')
        let dataSign=fileData.split('---')
        let stringSplit=''
        if(r.numDegree<=8){
            stringSplit='0'+parseInt(r.numDegree+1)+'°:'
        }else{
            stringSplit=''+parseInt(r.numDegree+1)+'°:'
        }
        let signData=''+dataSign[r.numSign+1]
        //console.log('\n\n\nAries---->>'+signData+'\n\n\n')
        let dataDegree=signData.split('<p ')
        let htmlPrevio=''
        let cp=0
        currentDegree.sd=stringSplit
        for(var i=0;i<dataDegree.length;i++){
            //console.log('\n\n\n\n'+stringSplit+'----------->>'+dataDegree[i])
            if(dataDegree[i].indexOf(stringSplit)>0){
                htmlPrevio+='<p '+dataDegree[i]
                cp++
                //console.log('\n\n----------->>'+htmlPrevio)
            }
        }
        console.log('Cantidad '+cp)
        let mapHtmlDegree=htmlPrevio.split('<p ')
        let dataFinal='<p '+mapHtmlDegree[r.currentInterpreter + 1]

        //if(rs.bgColor!=='#ffffff'){
            /*if(dataFinal.indexOf('<p class="entry-excerpt" style="text-align: justify;"><strong><span style="color:')<0&&dataFinal.indexOf('<p class="entry-excerpt" style="text-align: justify;"><span>strong style="color:')<0){
                dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: justify;"><strong>','<p class="entry-excerpt" style="text-align: justify;color:#ffffff"><strong>')
                dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: justify;"><span ','<p class="entry-excerpt" style="text-align: justify;color:#ffffff"><span ')
                dataFinal=dataFinal.replace('style="color: rgb(0, 0, 255);','style="color: rgb(255, 255, 255);')*/
            //}else{
                if(dataFinal.indexOf('<p class="entry-excerpt" style="text-align: justify;"><strong><span style="color: rgb(255, 0, 0);">'>=0)){
                    dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: justify;"><strong>','<p class="entry-excerpt" style="text-align: justify;color:red"><strong>')
                }else{
                    dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: justify;"><strong>','<p class="entry-excerpt" style="text-align: justify;color:green"><strong>')
                }
            //}
        //}
        data.text=dataFinal
            console.log('DATA:::'+dataFinal)
    }
    function getHtmlData(s, g, item){
        let fileData=''+unik.getFile('360.html')
        let dataSign=fileData.split('---')
        let stringSplit=''
        if(g<=8){
            stringSplit='0'+parseInt(g+1)+'°:'
        }else{
            stringSplit=''+parseInt(g+1)+'°:'
        }
        let signData=''+dataSign[s+1]
        //console.log('\n\n\nAries---->>'+signData+'\n\n\n')
        let dataDegree=signData.split('<p ')
        let htmlPrevio=''
        let cp=0
        currentDegree.sd=stringSplit
        for(var i=0;i<dataDegree.length;i++){
            //console.log('\n\n\n\n'+stringSplit+'----------->>'+dataDegree[i])
            if(dataDegree[i].indexOf(stringSplit)>0){
                htmlPrevio+='<p '+dataDegree[i]
                cp++
                //console.log('\n\n----------->>'+htmlPrevio)
            }
        }
        let mapHtmlDegree=htmlPrevio.split('<p ')
        let dataFinal=item===0?'<h3> Grado °'+parseInt(g + 1)+' de '+r.signos[s]+'</h3>\n':''
        dataFinal+='<p '+mapHtmlDegree[item + 1]
        if(rs.bgColor!=='#ffffff'){
            if(dataFinal.indexOf('<p class="entry-excerpt" style="text-align: left;"><strong><span style="color:')<0&&dataFinal.indexOf('<p class="entry-excerpt" style="text-align: left;"><span>strong style="color:')<0){
                dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><strong>','<p class="entry-excerpt" style="text-align: left;color:#ffffff"><strong>')
                dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><span ','<p class="entry-excerpt" style="text-align: left;color:#ffffff"><span ')
                dataFinal=dataFinal.replace('style="color: rgb(0, 0, 255);','style="color: rgb(255, 255, 255);')
            }else{
                if(dataFinal.indexOf('<p class="entry-excerpt" style="text-align: left;"><strong><span style="color: rgb(255, 0, 0);">'>=0)){
                    dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><strong>','<p class="entry-excerpt" style="text-align: left;color:red"><strong>')
                }else{
                    dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><strong>','<p class="entry-excerpt" style="text-align: left;color:green"><strong>')
                }
            }
        }
        return dataFinal.replace(/style=\"text-align: justify;\"/g,'').replace(/&nbsp; /g, ' ')
    }
    function setHtml(html, nom){
        let htmlFinal='<DOCTYPE html>
<html>
<head>
    <title>'+nom+'</title>
</head>
    <body style="background-color:#ffffff;">
        <h1>Ajustando hora de nacimiento de '+nom+'</h1>
        <p>En esta página hay 3 grupos con 3 textos. Tenés que avisar cuál de todos estos grupos te parece que tiene más que ver con tu vida o tu forma de ser.</p>
        <p>Los textos que vas a leer a continuación, son como descripciones de imágenes que simbolizan una escena de algo que se puede presentar en tu vida de algn modo parecido o similar.</p>
        <p><b>Aviso: </b>Los textos en color rojo son algo negativos. Tantos los textos azules o rojos puede ser que aún no se hayan producido.</p>
        <br/>
        <h2>¿Cuál de los siguientes grupos de textos pensas que hablan de cosas más parecidas a tu vida o forma de ser?</h2>
        <br/>\n'
+html+
'<br />
         <br />
    </body>
</html>'
        unik.setFile('/home/ns/nsp/uda/nextsigner.github.io/sabianos/'+nom+'.html', htmlFinal)
    }
}
