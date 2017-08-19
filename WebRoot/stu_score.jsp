<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'stu_score.jsp' starting page</title>
    
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
	<div class="modal fade" id="update_score" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">录入成绩</h4>
				</div>
				<div class="modal-footer">
					<form role="form" action="update_score.do" method="post">
						<div class="form-group">
							<label for="score">成绩</label> 
							<input type="text" class="form-control" name="score" id="rescore">
						</div>
						<div class="form-group">
							<label for="cmn">证书管理号</label> 
							<input type="text" class="form-control" name="cmn" id="recmn">
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
	  <caption><br>考试成绩</caption>
	  <thead>
		<tr>
			<th>学号</th>
			<th>姓名</th>
			<th>科目名称</th>
			<th>成绩</th>
			<th>证书管理号</th>
			<th>操作</th>
		</tr>
 	  </thead>
 	  <tbody id="tb_score" ></tbody>
 	</table>
  </body>
  
  
  <script type="text/javascript">
		var a=[];
		$.ajax({
		    type: "post",
		    url: "./get_info.do",
		    data:{user_id:'${user.user_id}'},
		    dataType:"json",
		    success: function(data){
		    		a=data;
		    		for(var i=0;i<a.length;i++)
		    			{
		    			
		    			  $("#tb_score").append("<tr><td>"+a[i].user_id+"</td><td>"+a[i].name+"</td><td>"+a[i].exam_name+"</td><td>"+a[i].score+"</td><td>"+a[i].cmn+"</td><td><button data-toggle='modal' data-target='#update_score' type='button' class='btn btn-default' id="+i+" onclick='updatescore(this)'>录入</button></td></tr>");
		    			 
		    			}
		             },
		             error:function(XMLHttpRequest, textStatus, errorThrown){
		            	 alert("请登录");
		             },                        
		});	
				
		function updatescore(obj){
		$('#reid').val(a[obj.id].id);
		$('#rescore').val(a[obj.id].score);
		$('#recmn').val(a[obj.id].cmn);
		}
		
		if ('${update_score_result}') {
			if ('${update_score_result}' == "success") {
				alert("录入成功");
			}
			else if('${update_score_result}' == "afterExp") {
				alert("已过录入有效期");
			} 
			else
				alert("录入失败");
		}	
  </script>	
</html>
