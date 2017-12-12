<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../taglib/taglibs.jsp" %>
<html>
<head>
    <title>ckeditor</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
</head>
<style>
    html, body {
        width: 100%;
        height: 100%;
        margin: 0;
        padding: 0;
        overflow: hidden;
    }
    .ckeditorParent{
        width: 100%;
        height: 80%;
    }
</style>
<body>
<div class="ckeditorParent">
<textarea style="width: 100%;height: 100%;padding: 0;border: 0;margin: 0;" name="content" id="contect_text" class="ckeditor"></textarea>
</div>
<input onclick="alert(CKEDITOR.instances.contect_text.getData())" type="button" value="获取内容" />
</body>
<script>
//初始化编辑器
var cKeditor=CKEDITOR.replace('contect_text',{
    //uiColor : '#7682ee',
    filebrowserImageUploadUrl: "${ctx}/upload/ckEditorImageUpload"
});
//实例准备
cKeditor.on('instanceReady',function(event)
{
    var editor=event.editor;
    //延时加载
    setTimeout(function(){
        if(!editor.element)
        {
            setTimeout(arguments.callee,1);
            return;
        }
        event.removeListener('instanceReady',this.callee);

        if(editor.name=='contect_text')
        {
            //重载高度计算高度
            editor.resize(editor.container.getStyle('width'),CKEDITOR.document.getById('cke_'+'contect_text').getParent().$.offsetHeight);
        }
    },0);
},null,null,9999);
</script>
</html>
