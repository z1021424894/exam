<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>学生登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link href="css/login.css" type="text/css" rel="stylesheet">
    
  </head> 
   
   <body> 

   <div class="login">
   <div class="message">学生登录</div>
   <div id="darkbannerwrap"></div>
    
    <form action="${pageContext.request.contextPath}/login.do" method="post">
		<input name="user_id" placeholder="学号" required="required" type="text">
		<hr class="hr15">
		<input name="password" placeholder="密码" required="required" type="password">
		<hr class="hr15">
		<input value="登录" style="width:100%;" type="submit">
		<hr class="hr20">
	</form>
	
  </div>

  </body>
</html>
