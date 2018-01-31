<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../taglib/taglibs.jsp" %>
<%@ include file="../taglib/import_iview.jsp" %>
<html>
<head>
    <title>500</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${ctx}/css/error/error-page.css">
    <link rel="stylesheet" href="${ctx}/css/error/500.css">
</head>
<body>
<div id="app" class="error-page">
    <Row class="error-page-box" type="flex" justify="center" align="middle">
        <i-Col span="10">
            <Card>
                <Row>
                    <div class="error-page-show">
                        <div class="error500">
                            <div class="error500-body-con">
                                <div class="error500-body-con-title">
                                    5<span class="error500-0-span"><Icon type="social-freebsd-devil"></Icon></span><span class="error500-0-span"><Icon type="social-freebsd-devil"></Icon></span>
                                </div>
                                <p class="error500-body-con-message">Oops! the server is wrong</p>
                                <div class="error500-btn-con">
                                    <i-Button type="text" @click="goHome" style="width: 200px;" type="text">返回登录
                                    </i-Button>
                                    <i-Button type="text" @click="backPage"  style="width: 200px;margin-left: 40px;" >后退上页</i-Button>
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
                window.parent.location.href="${ctx}/login.jsp";
            }
        }
    });
</script>
</html>