<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'admin_exam.jsp' starting page</title>
    
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
	<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#add_exam">添加考试</button>
	<input type="text" id="search" placeholder="科目名称" class="form-control" style="width:200px;display:inline;margin-left:142px;margin-top:30px">
	<button type="button" class="btn btn-default" onclick="search()">搜索</button>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="add_exam" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加考试</h4>
				</div>
				<div class="modal-footer">
					<form role="form" action="add_exam.do" method="post">
						<div class="form-group">
							<label for="exam_name">科目名称</label> 
							<input type="text" class="form-control" name="exam_name" id="exam_name">
						</div>
						<div class="form-group">
							<label for="entertime">报名时间</label> 
							<input type="text" class="form-control" name="entertime" id="entertime">
						</div>
						<div class="form-group">
							<label for="endtime">截止时间</label> 
							<input type="text" class="form-control" name="endtime" id="endtime">
						</div>
						<div class="form-group">
							<label for="examtime">考试时间</label> 
							<input type="text" class="form-control" name="examtime" id="examtime">
						</div>
						<div class="form-group">
							<label for="mark">合格分数线</label> 
							<input type="text" class="form-control" name="mark" id="mark">
						</div>
						<div class="form-group">
							<label for="exp">有效期</label> 
							<input type="text" class="form-control" name="exp" id="exp">
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
	<div class="modal fade" id="update_exam" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">修改信息</h4>
				</div>
				<div class="modal-footer">
					<form role="form" action="update_exam.do" method="post">
						<div class="form-group">
							<label for="exam_name">科目名称</label> 
							<input type="text" class="form-control" name="exam_name" id="reexam_name">
						</div>
						<div class="form-group">
							<label for="entertime">报名时间</label> 
							<input type="text" class="form-control" name="entertime" id="reentertime">
						</div>
						<div class="form-group">
							<label for="endtime">截止时间</label> 
							<input type="text" class="form-control" name="endtime" id="reendtime">
						</div>
						<div class="form-group">
							<label for="examtime">考试时间</label> 
							<input type="text" class="form-control" name="examtime" id="reexamtime">
						</div>
						<div class="form-group">
							<label for="mark">合格分数线</label> 
							<input type="text" class="form-control" name="mark" id="remark">
						</div>
						<div class="form-group">
							<label for="exp">有效期</label> 
							<input type="text" class="form-control" name="exp" id="reexp">
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
	  
	  <table class="table table-hover table-bordered">
	  <caption>考试信息</caption>
	  <thead>
		<tr>
			<th>科目名称</th>
			<th>报名时间</th>
			<th>截止时间</th>
			<th>考试时间</th>
			<th>合格分数线</th>
			<th>有效期</th>
			<th>操作</th>
			<th>操作</th>
		</tr>
 	 </thead>
 	 <tbody id="tb_exam" ></tbody>
 	 </table>
 	 
 	 
 	 
	</body>
	
	
	<script type="text/javascript">
		var a=[];
		var b=[];
		var c=[];
		$.ajax({
		    type: "post",
		    url: "./admin_get_exam.do",
		    data:"",
		    dataType:"json",
		    success: function(data){
		    		a=data;
		    		for(var i=0;i<a.length;i++)
		    			{
		    			  $("#tb_exam").append("<tr><td>"+a[i].exam_name+"</td><td>"+format(a[i].entertime)+"</td><td>"+format(a[i].endtime)+"</td><td>"+format(a[i].examtime)+"</td><td>"+a[i].mark+"</td><td>"+format(a[i].exp)+"</td><td><button id="+i+" onclick='deleteexam(this)' class='btn btn-default'>删除</button>	</td><td><button data-toggle='modal' data-target='#update_exam' type='button' id="+i+" onclick='updateexam(this)' class='btn btn-default'>修改</button></td></tr>");
		    			 
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
			    url: "./search_exam.do",
			    data: {"condition":condition},
			    dataType:"json",
			    success: function(data) {
			             c=data;
			             $("#tb_exam").empty();
			             for(var i=0;i<c.length;i++) {		             	
			             	$("#tb_exam").append("<tr><td>"+c[i].exam_name+"</td><td>"+format(c[i].entertime)+"</td><td>"+format(c[i].endtime)+"</td><td>"+format(c[i].examtime)+"</td><td>"+c[i].mark+"</td><td>"+format(c[i].exp)+"</td><td><button id="+i+" onclick='deleteexam(this)' class='btn btn-default'>删除</button>	</td><td><button data-toggle='modal' data-target='#update_exam' type='button' id="+i+" onclick='updateexam(this)' class='btn btn-default'>修改</button></td></tr>");
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
		
		function deleteexam(obj){
		if(confirm("是否确认删除？")) {
		   var param = {"id":a[obj.id].id};
		   $.ajax({
			    type: "post",
			    url: "./delete_exam.do",
			    data: param,
			    dataType:"json",
			    success: function(data){
	    	    b=data;
	    	 	if (b[0].delete_exam_result) {
		    		if (b[0].delete_exam_result == "success") {
		    			alert("删除成功");
		    		} else
		    			{
		    			alert("删除失败");
		    			}
		    		}
		    	  location.replace("admin_exam.jsp");   			          
	            },
			    error:function(XMLHttpRequest, textStatus, errorThrown){
			       alert(XMLHttpRequest.status);
			       alert(XMLHttpRequest.readyState);
			       alert(textStatus);
			     },                        
		   });
		}
	   }  
				
		function updateexam(obj){
		$('#reid').val(a[obj.id].id);
		$('#reexam_name').val(a[obj.id].exam_name);
		$('#reentertime').val(format(a[obj.id].entertime));
		$('#reendtime').val(format(a[obj.id].endtime));
		$('#reexamtime').val(format(a[obj.id].examtime));
		$('#remark').val(a[obj.id].mark);
		$('#reexp').val(format(a[obj.id].exp));
		}
		
		function format(time) {
		var date = new Date(time);
		Y = date.getFullYear() + '-';
		M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
		D = (date.getDate() < 10 ? '0'+(date.getDate()) : date.getDate()) + ' ';
		h = (date.getHours() < 10 ? '0'+(date.getHours()) : date.getHours()) + ':';
		m = (date.getMinutes() < 10 ? '0'+(date.getMinutes()) : date.getMinutes()) + ':';
		s = date.getSeconds() < 10 ? '0'+(date.getSeconds()) : date.getSeconds();
		return Y+M+D+h+m+s;
		}
	
		if ('${add_exam_result}') {
			if ('${add_exam_result}' == "success") {
				alert("添加成功");
			} else
				alert("考试科目重复");
		}		
		if ('${update_exam_result}') {
			if ('${update_exam_result}' == "success") {
				alert("修改成功");
			} else
				alert("考试科目不存在");
		}				
	</script>
</html>

