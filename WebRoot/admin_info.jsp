<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'admin_info.jsp' starting page</title>
    
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
	<!-- 按钮触发模态框 -->
	<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#add_admin">添加管理员</button>
	<input type="text" id="search" placeholder="用户名/姓名" class="form-control" style="width:200px;display:inline;margin-left:142px;margin-top:30px">
	<button type="button" class="btn btn-default" onclick="search()">搜索</button>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="add_admin" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加管理员</h4>
				</div>
				<div class="modal-footer">
					<form role="form" action="add_admin.do" method="post">
						<div class="form-group">
							<label for="username">用户名</label> 
							<input type="text" class="form-control" name="username" id="username">
						</div>
						<div class="form-group">
							<label for="password">密码</label> 
							<input type="password" class="form-control" name="password" id="password">
						</div>
						<div class="form-group">
							<label for="name">姓名</label> 
							<input type="text" class="form-control" name="name" id="name">
						</div>
						<div class="form-group">
							<label for="role">角色</label> 
							<input type="text" class="form-control" name="role" id="role">
						</div>
						<button type="submit" class="btn btn-default">提交</button>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		 </div>
		<!-- /.modal -->
	  </div>
	  
	  
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="update_admin" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">修改信息</h4>
				</div>
				<div class="modal-footer">
					<form role="form" action="update_admin.do" method="post">
						<div class="form-group">
							<label for="password">密码</label> 
							<input type="password" class="form-control" name="password" id="repassword">
						</div>
						<div class="form-group">
							<label for="name">姓名</label> 
							<input type="text" class="form-control" name="name" id="rename">
						</div>
						<div class="form-group">
							<label for="role">角色</label> 
							<input type="text" class="form-control" name="role" id="rerole">
						</div>
						<input type="text" style="display: none" name="username" id="reusername" value="" />
						<button type="submit" class="btn btn-default">提交</button>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		 </div>
		<!-- /.modal -->
	  </div>
	  
	  <table class="table table-hover table-bordered">
	  <caption>管理员信息</caption>
	  <thead>
		<tr>
			<th>用户名</th>
			<th>密码</th>
			<th>姓名</th>
			<th>角色</th>
			<th>操作</th>
			<th>操作</th>
		</tr>
 	 </thead>
 	 <tbody id="tb_admin" ></tbody>
 	 </table>
 	 
 	 
 	 
	</body>
	
	
	<script type="text/javascript">
		var a=[];
		var b=[];
		var c=[];
		$.ajax({
		    type: "post",
		    url: "./get_alladmin.do",
		    data:"",
		    dataType:"json",
		    success: function(data){
		    		a=data;
		    		for(var i=0;i<a.length;i++)
		    			{
		    			
		    			  $("#tb_admin").append("<tr><td>"+a[i].username+"</td><td>"+a[i].password+"</td><td>"+a[i].name+"</td><td>"+a[i].role+"</td><td><button id="+i+" onclick='deleteadmin(this)' class='btn btn-default'>删除</button> </td><td><button data-toggle='modal' data-target='#update_admin' type='button' id="+i+" onclick='updateadmin(this)' class='btn btn-default'>修改</button></td></tr>");
		    			 
		    			}
		             },
		             error:function(XMLHttpRequest, textStatus, errorThrown){
		            	 alert(XMLHttpRequest.status);
		            	 alert(XMLHttpRequest.readyState);
		            	 alert(textStatus);
		             },                        
		});
		
		function search() {
		var condition = $("#search").val();
		if(condition != "") {
				$.ajax({
			    type: "post",
			    url: "./get_admin.do",
			    data: {"condition":condition},
			    dataType:"json",
			    success: function(data) {
			             c=data;
			             $("#tb_admin").empty();
			             for(var i=0;i<c.length;i++) {			             	
			             	$("#tb_admin").append("<tr><td>"+c[i].username+"</td><td>"+c[i].password+"</td><td>"+c[i].name+"</td><td>"+c[i].role+"</td><td><button id="+i+" onclick='deleteadmin(this)' class='btn btn-default'>删除</button> </td><td><button data-toggle='modal' data-target='#update_admin' type='button' id="+i+" onclick='updateadmin(this)' class='btn btn-default'>修改</button></td></tr>");
			             }
			    },
			    error:function(XMLHttpRequest, textStatus, errorThrown){
		            alert(XMLHttpRequest.status);
		            alert(XMLHttpRequest.readyState);
		            alert(textStatus);
		        },  
		        });
		}
		else {
		alert("搜索条件不能为空");
		}
		$("#search").val("");	    
		}
		
		function deleteadmin(obj){
		if(confirm("是否确认删除？")) {
		   var param = {"username":a[obj.id].username};
		   $.ajax({
			    type: "post",
			    url: "./delete_admin.do",
			    data: param,
			    dataType:"json",
			    success: function(data){
	    	    b=data;
	    	 	if (b[0].delete_admin_result) {
		    		if (b[0].delete_admin_result == "success") {
		    			alert("删除成功");
		    		} else
		    			{
		    			alert("删除失败");
		    			}
		    		}
		    	  location.replace("admin_info.jsp");   			          
	            },
			    error:function(XMLHttpRequest, textStatus, errorThrown){
			       alert(XMLHttpRequest.status);
			       alert(XMLHttpRequest.readyState);
			       alert(textStatus);
			     },                        
		   });
		}
	   }  
				
		function updateadmin(obj){
		$('#reusername').val(a[obj.id].username);
		$('#repassword').val(a[obj.id].password);
		$('#rename').val(a[obj.id].name);
		$('#rerole').val(a[obj.id].role);
		}				
	
		if ('${add_admin_result}') {
			if ('${add_admin_result}' == "success") {
				alert("添加成功");
			} else
				alert("用户名重复");
		}		
		if ('${update_admin_result}') {
			if ('${update_admin_result}' == "success") {
				alert("修改成功");
			} else
				alert("用户名不存在");
		}				
	</script>
</html>
