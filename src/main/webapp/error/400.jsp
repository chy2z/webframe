<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../taglib/taglibs.jsp" %>
<%@ include file="../taglib/import_iview.jsp" %>
<html>
<head>
    <title>400</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${ctx}/css/error/error-page.css">
    <link rel="stylesheet" href="${ctx}/css/error/400.css">
</head>
<body>
<div id="app" class="error-page">
    <Row class="error-page-box" type="flex" justify="center" align="middle">
        <i-Col span="10">
            <Card>
                <Row>
                    <div class="error-page-show">
                        <div class="error400">
                            <div class="error400-body-con">
                                <div class="error400-body-con-title">
                                    4<span class="error400-0-span"><Icon type="social-freebsd-devil"></Icon></span><span
                                        class="error400-0-span"><Icon type="social-freebsd-devil"></Icon></span>
                                </div>
                                <p class="error400-body-con-message">Request error!</p>
                                <div class="error400-btn-con">
                                    <i-Button type="text" @click="goHome" style="width: 200px;" type="text">返回登录
                                    </i-Button>
                                    <i-Button type="text" @click="backPage" style="width: 200px;margin-left: 40px;">
                                        后退上页
                                    </i-Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </Row>
            </Card>
        </i-Col>
    </Row>
</div>
</body>
<script>
    new Vue({
        el: '#app',
        data: {},
        methods: {
            backPage() {
                window.history.back();
            },
            goHome() {
                window.parent.location.href = "${ctx}/login.jsp";
            }
        }
    });
</script>
</html>