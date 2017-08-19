<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'admin_stu_info.jsp' starting page</title>
    
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
	<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#add_stu">添加学生</button>
	<input type="text" id="search" placeholder="姓名/性别" class="form-control" style="width:200px;display:inline;margin-left:142px;margin-top:30px">
	<button type="button" class="btn btn-default" onclick="search()">搜索</button>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="add_stu" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加学生</h4>
				</div>
				<div class="modal-footer">
					<form role="form" action="add_stu.do" method="post">
						<div class="form-group">
							<label for="user_id">学号</label> 
							<input type="text" class="form-control" name="user_id" id="user_id">
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
							<label for="sex">性别</label> 
							<input type="text" class="form-control" name="sex" id="sex">
						</div>
						<div class="form-group">
							<label for="tel">联系电话</label> 
							<input type="text" class="form-control" name="tel" id="tel">
						</div>
						<div class="form-group">
							<label for="email">邮箱</label> 
							<input type="text" class="form-control" name="email" id="email">
						</div>
						<div class="form-group">
							<label for="qq">QQ</label> 
							<input type="text" class="form-control" name="qq" id="qq">
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
					<form role="form" action="admin_update_stu.do" method="post">
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
	  <caption>学生信息</caption>
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
			<th>操作</th>
		</tr>
 	 </thead>
 	 <tbody id="tb_stu" ></tbody>
 	 </table> 	 


 	 <nav style="position:absolute;top:395px;left:450px">
	 <ul class="pagination pagination-lg" id="page"></ul>	 	 
	 </nav>
	 <span id="span" style="position:absolute;top:430px;left:700px"></span>
	 <div style="position:absolute;top:475px;left:500px">
	 	<span>第</span>
		<input type="text" id="goto"  style="display:inline;width:30px;height:20px">
		<span>页</span>
		<button onclick="go()" class="btn btn-default">跳转</button>	 		
	 </div>	 
 	 
	</body>
	
	
	<script type="text/javascript">
		var a=[];
		var b=[];
		var c=[];
		var pages=[];
		var currentPage=1;
		var pageSize=5;
		var totalPage;
		var count;
		
		$(function(){load_page(currentPage);});		
	
		function load_page(page) {
		$.ajax({
		    type: "post",
		    url: "./get_allstu.do",
		    data:{"currentPage":page,"pageSize":pageSize},
		    dataType:"json",
		    success: function(data){
		    		a=data.list;
		    		totalPage=data.totalPage;
		    		currentPage=data.currentPage;
		    		count=data.count;
		    		pages=indexes(currentPage,totalPage,3);
		    		$("#tb_stu").empty();
		    		$("#page").empty();
		    		$("#goto").val("");
		    		for(var i=0;i<a.length;i++)
		    			{
		    			
		    			  $("#tb_stu").append("<tr><td>"+a[i].user_id+"</td><td>"+a[i].password+"</td><td>"+a[i].name+"</td><td>"+a[i].sex+"</td><td>"+a[i].tel+"</td><td>"+a[i].email+"</td><td>"+a[i].qq+"</td><td><button id="+i+" onclick='deletestu(this)' class='btn btn-default'>删除</button>	</td><td><button data-toggle='modal' data-target='#update_stu' type='button' id="+i+" onclick='updatestu(this)' class='btn btn-default'>修改</button>	</td></tr>");
		    			 
		    			}
		    		$("#span").html("共"+count+"条记录/"+totalPage+"页");
		    		$("#page").append("<li><a onclick='previous()'>&laquo;</a></li>");		    			
		    		for(var j=0;j<=pages.length;j++)
		    			{
		    				if(j==pages.length){
		    					$("#page").append("<li><a onclick='next()'>&raquo;</a></li>");
		    					return;
		    				}
		    				if(pages[j] == currentPage) {
		    					$("#page").append("<li class='active'><a onclick='load(this)'>"+pages[j]+"</a></li>");
		    				}
		    				else {
		    					$("#page").append("<li><a onclick='load(this)'>"+pages[j]+"</a></li>");
		    				}		    				
		    			}
		             },
		             error:function(XMLHttpRequest, textStatus, errorThrown){
		            	 alert(XMLHttpRequest.status);
		            	 alert(XMLHttpRequest.readyState);
		            	 alert(textStatus);
		             },                        
		});
		}
		
		function previous() {
		if(currentPage>1) {
			currentPage -=1;
			load_page(currentPage);
		}
		}
		
		function next() {
		if(currentPage<totalPage) {
			currentPage +=1;
			load_page(currentPage);
		}
		}
		
		function load(obj) {
		var p = $(obj).html();
		load_page(p);
		}
		
		function indexes (currentPage, totalPage, displayLength) {  
			   var indexes = [];  
			   var start;  
			   var end;
			   var curIndex=currentPage%displayLength;
			   if(curIndex==0)
			   {
			   		end=currentPage;
			   		start = end - displayLength + 1; 
			   }  
			   else
			   {
			   		start=currentPage-curIndex+1;
			   		end = start + displayLength - 1;  
			   } 
			    if (end > totalPage) {  
			       	end = totalPage;  
			    }  
			    for (var i = start; i <= end; i++) {  
			        indexes.push(i);  
			    }  
			    return indexes;  
  		}; 
		
		function search() {
		var condition = $("#search").val();
		if(condition != "") {
        search_page(1);
		}
		else {
		alert("搜索条件不能为空");
		}
		}
		
		function search_page(page) {
				$.ajax({
			    type: "post",
			    url: "./search_stu.do",
			    data: {"condition":$("#search").val(),"currentPage":page,"pageSize":pageSize},
			    dataType:"json",
			    success: function(data) {
			             c=data.list;
			    		 totalPage=data.totalPage;
			    		 currentPage=data.currentPage;
			    		 count=data.count;
			    		 pages=indexes(currentPage,totalPage,3);
			    		 $("#tb_stu").empty();
			    		 $("#page").empty();
			    		 $("#goto").val("");
			             for(var i=0;i<c.length;i++) {			             	
			             	$("#tb_stu").append("<tr><td>"+c[i].user_id+"</td><td>"+c[i].password+"</td><td>"+c[i].name+"</td><td>"+c[i].sex+"</td><td>"+c[i].tel+"</td><td>"+c[i].email+"</td><td>"+c[i].qq+"</td><td><button id="+i+" onclick='deletestu(this)' class='btn btn-default'>删除</button>	</td><td><button data-toggle='modal' data-target='#update_stu' type='button' id="+i+" onclick='updatestu(this)' class='btn btn-default'>修改</button>	</td></tr>");
			             }
			             $("#span").html("共"+count+"条记录/"+totalPage+"页");
		    			 $("#page").append("<li><a onclick='sprevious()'>&laquo;</a></li>");		    			
		    		     for(var j=0;j<=pages.length;j++)
		    			    {
		    				if(j==pages.length){
		    					$("#page").append("<li><a onclick='snext()'>&raquo;</a></li>");
		    					return;
		    				}
		    				if(pages[j] == currentPage) {
		    					$("#page").append("<li class='active'><a onclick='search_load(this)'>"+pages[j]+"</a></li>");
		    				}
		    				else {
		    					$("#page").append("<li><a onclick='search_load(this)'>"+pages[j]+"</a></li>");
		    				}		    				
		    			}
			    },
			    error:function(XMLHttpRequest, textStatus, errorThrown){
		            alert(XMLHttpRequest.status);
		            alert(XMLHttpRequest.readyState);
		            alert(textStatus);
		        },  
		        });		
		}
		
		function sprevious() {
		if(currentPage>1) {
			currentPage -=1;
			search_page(currentPage);
		}
		}
		
		function snext() {
		if(currentPage<totalPage) {
			currentPage +=1;
			search_page(currentPage);
		}
		}		
		
		function search_load(obj) {
		var p = $(obj).html();
		search_page(p);		
		}
		
		function go() {
		var go = $("#goto").val();
		if(go!= "") {
			if(go<=totalPage) {
				if($("#search").val() != "") {
					search_page(go);
				}
				else {
					load_page(go);
				}
			}
			else {
				alert("没有这么多页");
				$("#goto").val("");
			}
		}
		else {
			alert("页数不能为空");
		}
		}
		
		function deletestu(obj){
		if(confirm("是否确认删除？")) {
		   var param = {"user_id":a[obj.id].user_id};
		   $.ajax({
			    type: "post",
			    url: "./delete_stu.do",
			    data: param,
			    dataType:"json",
			    success: function(data){
	    	    b=data;
	    	 	if (b[0].delete_stu_result) {
		    		if (b[0].delete_stu_result == "success") {
		    			alert("删除成功");
		    		} else
		    			{
		    			alert("删除失败");
		    			}
		    		}
		    	  location.replace("admin_stu_info.jsp");   			          
	            },
			    error:function(XMLHttpRequest, textStatus, errorThrown){
			       alert(XMLHttpRequest.status);
			       alert(XMLHttpRequest.readyState);
			       alert(textStatus);
			     },                        
		   });
		}
	   }  
				
		function updatestu(obj){
		$('#reuser_id').val(a[obj.id].user_id);
		$('#repassword').val(a[obj.id].password);
		$('#rename').val(a[obj.id].name);
		$('#resex').val(a[obj.id].sex);
		$('#retel').val(a[obj.id].tel);
		$('#reemail').val(a[obj.id].email);
		$('#reqq').val(a[obj.id].qq);		
		}
	
		if ('${add_stu_result}') {
			if ('${add_stu_result}' == "success") {
				alert("添加成功");
			} else
				alert("学号重复");
		}
				
		if ('${update_stu_result}') {
			if ('${update_stu_result}' == "success") {
				alert("修改成功");
			} else
				alert("用户不存在");
		}				
	</script>
</html>
