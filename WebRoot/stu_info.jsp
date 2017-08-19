<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'stu_info.jsp' starting page</title>
    
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
    	<!-- 模态框（Modal） -->
	<div class="modal fade" id="update_stu" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">修改信息</h4>
				</div>
				<div class="modal-footer">
					<form role="form" action="update_stu.do" method="post">
						<div class="form-group">
							<label for="password">密码</label> 
							<input type="password" class="form-control" name="password" id="repassword">
						</div>
						<div class="form-group">
							<label for="name">姓名</label> 
							<input type="text" class="form-control" name="name" id="rename">
						</div>
						<div class="form-group">
							<label for="sex">性别</label> 
							<input type="text" class="form-control" name="sex" id="resex">
						</div>
						<div class="form-group">
							<label for="tel">联系电话</label> 
							<input type="text" class="form-control" name="tel" id="retel">
						</div>
						<div class="form-group">
							<label for="email">邮箱</label> 
							<input type="text" class="form-control" name="email" id="reemail">
						</div>
						<div class="form-group">
							<label for="qq">QQ</label> 
							<input type="text" class="form-control" name="qq" id="reqq">
						</div>
						<input type="text" style="display: none" name="user_id" id="reuser_id" value="" />
						<button type="submit" class="btn btn-default">提交</button>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		 </div>
		<!-- /.modal -->
	  </div>
	  
	  <table class="table table-hover table-bordered">
	  <caption>个人信息</caption>
	  <thead>
		<tr>
			<th>学号</th>
			<th>密码</th>
			<th>姓名</th>
			<th>性别</th>
			<th>联系电话</th>
			<th>邮箱</th>
			<th>QQ</th>
			<th>操作</th>
		</tr>
 	 </thead>
 	 <tbody id="tb_stu" ></tbody>
 	 </table>
  </body>
  
  <script type="text/javascript">
		$.ajax({
		    type: "post",
		    url: "./get_stu.do",
		    data: {user_id:'${user.user_id}'},
		    dataType:"json",
		    success: function(data){		    			
		    			$("#tb_stu").append("<tr><td>"+data.user_id+"</td><td>"+data.password+"</td><td>"+data.name+"</td><td>"+data.sex+"</td><td>"+data.tel+"</td><td>"+data.email+"</td><td>"+data.qq+"</td><td><button data-toggle='modal' data-target='#update_stu' type='button' class='btn btn-default'>修改</button></td></tr>");
		    			$('#reuser_id').val(data.user_id);
						$('#repassword').val(data.password);
						$('#rename').val(data.name);
						$('#resex').val(data.sex);
						$('#retel').val(data.tel);
						$('#reemail').val(data.email);
						$('#reqq').val(data.qq); 		    
		             },
		             error:function(XMLHttpRequest, textStatus, errorThrown){
		            	 alert("请登录");
		             },                        
		});						
			
		if ('${update_stu_result}') {
			if ('${update_stu_result}' == "success") {
				alert("修改成功");
			} else
				alert("用户名不存在");
		}				
	</script>
</html>
