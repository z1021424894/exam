<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'announcement.jsp' starting page</title>
    
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
	<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#add_ann">添加公告</button>
	<input type="text" id="search" placeholder="标题/yyyy-mm-dd hh:mm:ss" class="form-control" style="width:200px;display:inline;margin-left:142px;margin-top:30px">
	<button type="button" class="btn btn-default" onclick="search()">搜索</button>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="add_ann" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加公告</h4>
				</div>
				<div class="modal-footer">
					<form role="form" action="add_ann.do" method="post">
						<div class="form-group">
							<label for="title">标题</label> 
							<input type="text" class="form-control" name="title" id="title">
						</div>
						<div class="form-group">
							<label for="content">内容</label> 
							<input type="text" class="form-control" name="content" id="content">
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
	<div class="modal fade" id="update_ann" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">修改公告</h4>
				</div>
				<div class="modal-footer">
					<form role="form" action="update_ann.do" method="post">
						<div class="form-group">
							<label for="title">标题</label> 
							<input type="text" class="form-control" name="title" id="retitle">
						</div>
						<div class="form-group">
							<label for="content">内容</label> 
							<input type="text" class="form-control" name="content" id="recontent">
						</div>
						<input type="text" style="display: none" name="id" id="reid" value="" />
						<button type="submit" class="btn btn-default">提交</button>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		 </div>
		<!-- /.modal -->
	  </div>	
	    
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="look_ann" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">公告内容</h4>
				</div>
				<div class="modal-footer">
					<p id="ann_content" class="text-left"></p>
				</div>
			</div>
			<!-- /.modal-content -->
		 </div>
		<!-- /.modal -->
	  </div>	  

	  <table class="table table-hover table-bordered">
	  <caption>公告信息</caption>
	  <thead>
		<tr>
			<th>公告标题</th>
			<th>发布时间</th>
			<th>操作</th>
			<th>操作</th>
			<th>操作</th>
		</tr>
 	 </thead>
 	 <tbody id="tb_ann" ></tbody>
 	 </table>

 	 
	</body>
	
	
	<script type="text/javascript">
		var a=[];
		var b=[];
		var c=[];
		$.ajax({
		    type: "post",
		    url: "./get_ann.do",
		    data:"",
		    dataType:"json",
		    success: function(data){
		    		a=data;
		    		for(var i=0;i<a.length;i++)
		    			{	   			  
		    			  var date = new Date(a[i].time);
          				  Y = date.getFullYear() + '-';
						  M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
						  D = date.getDate() + ' ';
						  h = date.getHours() + ':';
						  m = date.getMinutes() + ':';
						  s = date.getSeconds(); 
		    			  $("#tb_ann").append("<tr><td>"+a[i].title+"</td><td>"+Y+M+D+h+m+s+"</td><td><button data-toggle='modal' data-target='#look_ann' type='button' id="+i+" onclick='lookann(this)' class='btn btn-default'>查看</button></td><td><button id="+i+" onclick='deleteann(this)' class='btn btn-default'>删除</button></td><td><button data-toggle='modal' data-target='#update_ann' type='button' class='btn btn-default' id="+i+" onclick='updateann(this)'>修改</button></td></tr>");
		    			 
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
			    url: "./search_ann.do",
			    data: {"condition":condition},
			    dataType:"json",
			    success: function(data) {
			             c=data;
			             $("#tb_ann").empty();
			             for(var i=0;i<c.length;i++) {	
			             	var date = new Date(c[i].time);
          				    Y = date.getFullYear() + '-';
						    M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
						    D = date.getDate() + ' ';
						    h = date.getHours() + ':';
						    m = date.getMinutes() + ':';
						    s = date.getSeconds();		             	
			             	$("#tb_ann").append("<tr><td>"+c[i].title+"</td><td>"+Y+M+D+h+m+s+"</td><td><button data-toggle='modal' data-target='#look_ann' type='button' id="+i+" onclick='lookann(this)' class='btn btn-default'>查看</button></td><td><button id="+i+" onclick='deleteann(this)' class='btn btn-default'>删除</button></td><td><button data-toggle='modal' data-target='#update_ann' type='button' id="+i+" onclick='updateann(this)' class='btn btn-default'>修改</button></td></tr>");
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
		
		function lookann(obj){
		$('#ann_content').html(a[obj.id].content);
		}
		
		function deleteann(obj){
		if(confirm("是否确认删除？")) {
		   var param = {"id":a[obj.id].id};
		   $.ajax({
			    type: "post",
			    url: "./delete_ann.do",
			    data: param,
			    dataType:"json",
			    success: function(data){
	    	    b=data;
	    	 	if (b[0].delete_ann_result) {
		    		if (b[0].delete_ann_result == "success") {
		    			alert("删除成功");
		    		} else
		    			{
		    			alert("删除失败");
		    			}
		    		}
		    	  location.replace("admin_ann.jsp");   			          
	            },
			    error:function(XMLHttpRequest, textStatus, errorThrown){
			       alert(XMLHttpRequest.status);
			       alert(XMLHttpRequest.readyState);
			       alert(textStatus);
			     },                        
		   });
		}
	   }  
				
		function updateann(obj){
		$('#retitle').val(a[obj.id].title);
		$('#recontent').val(a[obj.id].content);
		$('#reid').val(a[obj.id].id);
		}		
	
		if ('${add_ann_result}') {
			if ('${add_ann_result}' == "success") {
				alert("添加成功");
			} else
				alert("公告重复");
		}		
		if ('${update_ann_result}') {
			if ('${update_ann_result}' == "success") {
				alert("修改成功");
			} else
				alert("公告不存在");
		}		 		
	</script>
</html>
