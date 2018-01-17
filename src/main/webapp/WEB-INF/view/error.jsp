<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>错误页面</title>
</head>
<body>
    <h1>出错啦！攻城狮又要被祭天了！</h1>
    <% Exception ex = (Exception)request.getAttribute("exception");%>
    <% if(ex!=null){ %>
       <H2>Exception: <%=ex.getMessage() %></H2>
       <P/>
    <% ex.printStackTrace(new java.io.PrintWriter(out));%>
    <% }    %>
</body>
</html>