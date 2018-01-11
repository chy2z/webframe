<%@ page pageEncoding="UTF-8"%>
<script>
    /**
     * 验证授权信息
     */
    function authentication() {
        if(sessionStorage.getItem("jwt")==null||sessionStorage.getItem("jwt")==""){
            window.location.href="${ctx}/login.jsp";
        }
    }

    /**
     * 退出登录
     */
    function outLogin(){
        sessionStorage.removeItem("jwt");
        authentication();
    }

    authentication();

</script>