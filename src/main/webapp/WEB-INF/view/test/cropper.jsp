<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../taglib/taglibs.jsp" %>
<%@ include file="../../../taglib/import_iview.jsp" %>
<%@ include file="../../../taglib/import_jquery.jsp" %>
<%@ include file="../../../taglib/import_common.jsp" %>
<html>
<head>
    <title>文件上传测试</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <link rel="stylesheet" href="${ctx}/css/cropper/cropper.css">
    <script type="text/javascript" src="${ctx}/js/cropper/cropper.js"></script>
    <style>
        .radiusContent {
            border: 1px solid #eee;
            border-radius: 6px;
            margin-bottom: 20px;
            position: relative;
            transition: all .2s ease-in-out;
        }

        .radiusContent:hover {
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.2);
        }

        .cropper-left {
            padding: 0px 5px;
            position: relative;
        }

        .preview-right {
            padding: 0 5px;
            position: relative;
            overflow: hidden;
            transition: height .2s ease-in-out;
        }

        .center-split {
            display: block;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 50%;
            border: 1px dashed #eee;
        }

        .image-editor .cropper {
            box-sizing: border-box;
            border: 1px solid #c3c3c3;
            width: 100%;
            height: 100%;
        }
        .image-editor .cropper img {
            max-height: 100%;
        }
        .image-editor .fileinput {
            display: none;
        }
        .image-editor .filelabel {
            display: block;
            padding: 6px 15px;
            background: #2d8cf0;
            display: inline-block;
            border: 1px solid #2d8cf0;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            font-size: 12px;
            text-align: center;
            transition: all .2s;
        }
        .image-editor .filelabel:hover {
            background: #5cadff;
            border: 1px solid #5cadff;
            transition: all .2s;
        }
        .image-editor-con {
            height: 300px;
        }

        .image-editor-con-preview-con {
            box-sizing: border-box;
            border: 1px solid #ebebeb;
            width: 100%;
            height: 100%;
        }

        .image-editor-con-preview-con #preview1 {
            top:0;bottom:0;right:0;left:0;
            margin:auto;
            width: 60%;
            height: 60%;
            overflow: hidden;
            position: absolute;
            background: #BBE8F2;
        }

        .image-editor-con-btn-con{
            text-align: center;
            margin-top: 15px;
        }

    </style>
</head>
<body>
<div id="app" class="image-editor">
    <Row class="margin-top-10" type="flex" justify="center" align="middle">
        <i-Col span="12">
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
                    <input type="file" accept="image/png, image/jpeg, image/gif, image/jpg" @change="handleChange1" id="fileinput1" class="fileinput" />
                    <label class="filelabel" for="fileinput1"><Icon type="image"></Icon>&nbsp;选择图片</label>
                    <span><i-Button @click="handlecrop1" type="primary" icon="crop">裁剪</i-Button></span>
                    <span><i-Button @click="handleUpload" type="primary" icon="crop">上传</i-Button></span>
                </div>
                <Modal v-model="option1.showCropedImage">
                    <p slot="header">预览裁剪之后的图片</p>
                    <img :src="option1.cropedImg" alt="" v-if="option1.showCropedImage" style="width: 100%;">
                </Modal>
                </i-Col>
            </Row>
        </Card>
        </i-Col>
    </Row>
</div>
</body>
<script>
    new Vue({
        el: '#app',
        data: {
            cropper1: {},
            option1: {
                showCropedImage: false,
                cropedImg: ''
            }
        },
        methods: {
            handleChange1 (e) {
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
                this.option1.cropedImg = file;
                this.option1.showCropedImage = true;
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
            let img1 = document.getElementById('cropimg1');
            this.cropper1 = new Cropper(img1, {
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
