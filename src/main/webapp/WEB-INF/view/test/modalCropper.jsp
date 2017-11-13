<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../taglib/taglibs.jsp" %>
<%@ include file="../../../taglib/import_iview.jsp" %>
<%@ include file="../../../taglib/import_jquery.jsp" %>
<%@ include file="../../../taglib/import_common.jsp" %>
<%@ include file="../../../taglib/import_corpper.jsp"%>
<html>
<head>
    <title>文件上传测试</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">

    <Modal v-model="show" :mask-closable="false" :styles="{top: '20px'}" :width="800">
        <p slot="header">头像上传</p>
    <Row class="margin-top-10 image-editor" type="flex" justify="center" align="middle">
        <i-Col span="23">
        <Card>
            <p slot="title">
                <Icon type="qr-scanner"></Icon>
                裁剪图片
            </p>
            <Row>
                <i-Col span="12" class="image-editor-con cropper-left">
                    <div class="cropper">
                        <img id="cropimg1" src="../../images/lock.jpg" alt="">
                    </div>
                </i-Col>
                <div class="center-split"></div>
                <i-Col span="12" class="image-editor-con preview-right">
                    <div class="image-editor-con-preview-con">
                        <div id="preview1"></div>
                    </div>
                </i-Col>
            </Row>
            <Row type="flex" justify="center" align="middle">
                <i-Col span="12">
                <div class="image-editor-con-btn-con">
                    <input type="file" accept="image/png, image/jpeg, image/gif, image/jpg" @change="handleFileChange1" id="fileinput1" class="fileinput" />
                    <label class="filelabel" for="fileinput1"><Icon type="image"></Icon>&nbsp;选择图片</label>
                    <span><i-Button @click="handlecrop1" type="primary" icon="crop">裁剪</i-Button></span>
                    <span><i-Button @click="handleUpload" type="primary" icon="crop">上传</i-Button></span>
                </div>
                <Modal v-model="cropperOption1.showCropedImage">
                    <p slot="header">预览裁剪之后的图片</p>
                    <img :src="cropperOption1.cropedImg" alt="" v-if="cropperOption1.showCropedImage" style="width: 100%;">
                </Modal>
                </i-Col>
            </Row>
        </Card>
        </i-Col>
    </Row>

    </Modal>
</div>
</body>
<script>
    new Vue({
        el: '#app',
        data: {
            show:true,
            cropper1: {},
            cropperOption1: {
                showCropedImage: false,
                cropedImg: ''
            }
        },
        methods: {
            handleFileChange1 (e) {
                let file = e.target.files[0];
                let reader = new FileReader();
                reader.onload = () => {
                    this.cropper1.replace(reader.result);
                    reader.onload = null;
                };
                reader.readAsDataURL(file);
            },
            handlecrop1 () {
                let file = this.cropper1.getCroppedCanvas().toDataURL();
                this.cropperOption1.cropedImg = file;
                this.cropperOption1.showCropedImage = true;
            },
            handleUpload(){
                var vue=this;
                // Upload cropped image to server if the browser supports `HTMLCanvasElement.toBlob`
                this.cropper1.getCroppedCanvas().toBlob(function (blob) {
                    var formData = new FormData();
                    formData.append('upload', blob);
                    $.ajax('${ctx}/upload/imageUpload', {
                        method: "POST",
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (result) {
                            var res=$.evalJSON(result);
                            valert(vue,res.tip);
                            console.log('Upload success');
                        },
                        error: function () {
                            console.log('Upload error');
                        }
                    });
                });
            }
        },
        mounted() {
            this.cropper1 = new Cropper( document.getElementById('cropimg1'), {
                aspectRatio: 1 / 1,
                dragMode: 'move',
                preview: '#preview1',
                restore: false,
                center: false,
                highlight: false,
                cropBoxMovable: true,
                toggleDragModeOnDblclick: false
            });
        }
    });
</script>
</html>
