<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>大学校园考试系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<link type="text/css" rel="stylesheet" href="css/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
	<script type="text/javascript" src="css/bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="css/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  </head>

  <body>
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<nav class="navbar navbar-default" role="navigation">
					<div class="navbar-header">
						 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> 
						 <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span>
						 <span class="icon-bar"></span><span class="icon-bar"></span></button>
						 <a class="navbar-brand">大学校园考试系统</a>
					</div>
					
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">					 
							<li>
								 <a target=iframe href="http://localhost:8080/exam/stu_ann.jsp">查看公告</a>
							</li>
							<li>
								 <a target=iframe href="http://localhost:8080/exam/stu_info.jsp">个人信息</a>
							</li>
							<li>
								 <a target=iframe href="http://localhost:8080/exam/stu_exam.jsp">考试报名</a>
							</li>
							<li>
								 <a target=iframe href="http://localhost:8080/exam/stu_score.jsp">考试成绩</a>
							</li>															
						</ul>

					<ul class="nav navbar-nav navbar-right">
						<li>
						<a id="stu_name">欢迎您：</a>						
						</li>
						<li>
						<button class="btn btn-primary btn-lg"  id="undologin" onclick="logout()">注销</button>						
						</li>
					</ul>
					</div>					
				</nav>
			</div>
				<iframe name="iframe" width="100%" height="600" frameborder="0" ></iframe>
		</div>
	</div>
	
	
	<script type="text/javascript">
		var name = '${user.name}';
		$("#stu_name").append(name);
		function logout(){
			if(confirm("是否确认注销？")) {
				$.ajax({
			    type: "post",
			    url: "./logout.do",
			    data:"",
			    dataType:"json",                       
			    });
			alert("注销成功");
			location.replace("login.jsp");
			}
	    }  
	</script>
  </body>
</html>
