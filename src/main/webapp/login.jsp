<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="taglib/taglibs.jsp"%>
<html>
<head>
<title>登录</title>
<meta name="keywords" content="管理系统">
<meta name="description" content="管理系统">    
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>  
<link rel="stylesheet" href="css/login/reveal.css?v=${nowDate}">
<link rel="stylesheet" href="css/login/moudlelogin.css?v=${nowDate}">
<link rel="stylesheet" href="css/login/firebugResetStyles.css?v=${nowDate}">
</head>
<body>
	<input style="display: none" id="massage" value="">
	<div style="position: fixed; z-index: -1; background: transparent none repeat scroll 0% 0%;"
		id="js-login-bg" class="ModuleLogin-bg">
		<div
			style="left: 0px; top: 0px; overflow: hidden; margin: 0px; padding: 0px; z-index: -999998; position: absolute; width: 1920px; height: 457px;"
			class="backstretch">
			<img src="images/login/5.jpg"
				style="position: absolute; margin: 0px; padding: 0px; border: medium none; max-height: none; max-width: none; z-index: -999999; width: 1920px; height: 925.763px; left: 0px; top: -234.382px;">
		</div>
	</div>
	<form method="post" id="form1">
		<div class="ModuleLogin-layer">
			<table>
				<tbody>
					<tr>
						<td>

							<div class="ModuleLogin-wrap">
								<div class="ModuleLogin-logo">&nbsp;</div>
								<div class="ModuleLogin-main">

									<div class="tMainWrap">
										<p class="tUserWrap">
											<i class="tUserImg"></i>
											<input  name="username" id="txtUser" class="tUser" placeholder="用户名" value="51aspx" type="text" >
											<span class="tUserExt"></span>
										</p>

										<p class="tPasswordWrap">
											<i class="tPasswordImg"></i> <input name="password" id="txtPwd"	class="tPassword" placeholder="密码" type="password" value="" autocomplete="off">
										</p>


										<p class="tError">
											<span>
												<!-- 错误提示书写位置 -->
											</span>
										</p>
										<input name="loginBtn" value="登&nbsp;录" id="loginBtn" class="tSubmit" type="button">
										<p class="tResetPassword">
											<a href="#">忘记密码</a>
										</p>
									</div>

								</div>

								<div class="ModuleLogin-Copyright">
									<p>无忧有限公司</p>
									<p>Copyright chy Corporation, All Rights Reserved</p>
									<p>
										<em>©</em>chy 版权所有
									</p>
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="ModuleLogin-Qrcode">
			<div class="tQrcodeWrap">
				<div class="tQrcode">&nbsp;</div>
				<div class="tQrcodeTips">Android版</div>
			</div>
			<div class="tQrcodeWrapr">
				<div class="tQrcoder">&nbsp;</div>
				<div class="tQrcodeTips">IOS版</div>
			</div>
		</div>
	</form>
	<div id="myModal" class="reveal-modal">
		<h3 style="margin-bottom: 20px; font-size: 16px;">温馨提示</h3>
		<p id="tip" style="text-align: center; font-size: 15px;">信息不正确!</p>
		<a class="close-reveal-modal">&#215;</a>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/login/jquery.reveal.js"></script>
	<script type="text/javascript" src="js/login/jquery.backstretch.js"></script>
	<script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript">
		$(function() {
		    var domain="${ctx}";
		    var validateLogon_url=domain+"/login/validateLogon";
            var mainFrame_url=domain+"/login/mainFrame/";

			var listArr = [ "images/login/1.jpg", "images/login/2.jpg", "images/login/3.jpg", "images/login/4.jpg", "images/login/5.jpg", "images/login/6.jpg", "images/login/7.jpg","images/login/1.jpg"];
			$(".ModuleLogin-bg").backstretch(listArr, {
				fade : 1000,
				duration : 5000
			});

            $(document).keyup(function(event){
                if(event.keyCode ==13){
                    $("#loginBtn").click();
                }
            });

			$("#loginBtn").click(function(){
			    let name=$("#txtUser").val();
                let pwd=$("#txtPwd").val();
				if(isBlank(name)||isBlank(pwd)){
					$("#tip").text("用户名和密码都不能为空");
					$("#myModal").reveal("{data-animation:'none'}");
                }
                else{
                    let data = $.extend({uname:name,upwd:pwd},client.data);
                    $.ajax({
                        url: validateLogon_url,
                        type: "POST",
                        data: data,
                        success: function(data){
							if(data&&data.success){
                                vSetAuthenticationStorage(data.data);
                                window.location.href=mainFrame_url+data.data;
							}
							else{
                                $("#tip").text(data.tip);
                                $("#myModal").reveal("{data-animation:'none'}");
							}
                        },
                        error: function(res){
                            alert(res.responseText);
                        }
                    });
				}
			});
		});
	</script>
</body>
<script type="text/javascript">
	// 默认值
	var client={country:"中国",region:"安徽省",city:"南京"};
    $.get("http://freegeoip.net/json/",function(data){
        $.get("${ctx}/login/queryIp?ip="+ data.ip, function(result){
            var ipinfo=decodeUnicode(result.data);
            client=eval("("+ipinfo+")");
        });
    });
</script>
</html>