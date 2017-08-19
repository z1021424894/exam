<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'admin_enter_score.jsp' starting page</title>
    
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
    <input type="text" id="search" placeholder="姓名/科目名称/年份" class="form-control" style="width:200px;display:inline;margin-top:30px">
	<button type="button" class="btn btn-default" onclick="search()">搜索</button>
  	<!-- 模态框（Modal） -->
	<div class="modal fade" id="update_info" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">修改信息</h4>
				</div>
				<div class="modal-footer">
					<form role="form" action="update_info.do" method="post">
						<div class="form-group">
							<label for="user_id">学号</label> 
							<input type="text" class="form-control" name="user_id" id="reuser_id">
						</div>
						<div class="form-group">
							<label for="name">姓名</label> 
							<input type="text" class="form-control" name="name" id="rename">
						</div>
						<div class="form-group">
							<label for="exam_name">科目名称</label> 
							<input type="text" class="form-control" name="exam_name" id="reexam_name">
						</div>
						<div class="form-group">
							<label for="time">报名时间</label> 
							<input type="text" class="form-control" name="time" id="retime">
						</div>
						<div class="form-group">
							<label for="score">成绩</label> 
							<input type="text" class="form-control" name="score" id="rescore">
						</div>
						<div class="form-group">
							<label for="level">是否合格</label> 
							<input type="text" class="form-control" name="level" id="relevel">
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
	  <caption><br>报名与成绩信息</caption>
	  <thead>
		<tr>
			<th>学号</th>
			<th>姓名</th>
			<th>科目名称</th>
			<th>报名时间</th>
			<th>成绩</th>
			<th>是否合格</th>
			<th>证书管理号</th>
			<th>操作</th>
			<th>操作</th>
		</tr>
 	  </thead>
 	  <tbody id="tb_info" ></tbody>
 	</table>
 	
 	 <nav style="position:absolute;top:410px;left:450px">
	 <ul class="pagination pagination-lg" id="page"></ul>	 	 
	 </nav>
	 <span id="span" style="position:absolute;top:445px;left:700px"></span>
	 <div style="position:absolute;top:490px;left:500px">
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
		var levelCount;		
		
		$(function(){load_page(currentPage);});
		
		function load_page(page) {
		$.ajax({
		    type: "post",
		    url: "./get_allinfo.do",
		    data:{"currentPage":page,"pageSize":pageSize},
		    dataType:"json",
		    success: function(data){
		    		a=data.list;
		    		totalPage=data.totalPage;
		    		currentPage=data.currentPage;
		    		count=data.count;
		    		levelCount=data.levelCount;
		    		pages=indexes(currentPage,totalPage,3);
		    		$("#tb_info").empty();
		    		$("#page").empty();
		    		$("#goto").val("");		    		
		    		for(var i=0;i<a.length;i++)
		    			{
		    			
		    			  $("#tb_info").append("<tr><td>"+a[i].user_id+"</td><td>"+a[i].name+"</td><td>"+a[i].exam_name+"</td><td>"+format(a[i].time)+"</td><td>"+a[i].score+"</td><td>"+a[i].level+"</td><td>"+a[i].cmn+"</td><td><button id="+i+" onclick='deleteinfo(this)' class='btn btn-default'>删除</button>	</td><td><button data-toggle='modal' data-target='#update_info' type='button' id="+i+" onclick='updateinfo(this)' class='btn btn-default'>修改</button></td></tr>");
		    			 
		    			}
		    		$("#span").html("共"+count+"条记录/"+totalPage+"页/"+levelCount+"人合格");
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
			    url: "./search_info.do",
			    data: {"condition":$("#search").val(),"currentPage":page,"pageSize":pageSize},
			    dataType:"json",
			    success: function(data) {
			             c=data.list;
			    		 totalPage=data.totalPage;
			    		 currentPage=data.currentPage;
			    		 count=data.count;
			    		 levelCount=data.levelCount;
			    		 pages=indexes(currentPage,totalPage,3);
			    		 $("#page").empty();
			    		 $("#goto").val("");
			             $("#tb_info").empty();
			             for(var i=0;i<c.length;i++) {			             	
			             	$("#tb_info").append("<tr><td>"+c[i].user_id+"</td><td>"+c[i].name+"</td><td>"+c[i].exam_name+"</td><td>"+format(c[i].time)+"</td><td>"+c[i].score+"</td><td>"+c[i].level+"</td><td>"+c[i].cmn+"</td><td><button id="+i+" onclick='deleteinfo(this)' class='btn btn-default'>删除</button>	</td><td><button data-toggle='modal' data-target='#update_info' type='button' id="+i+" onclick='updateinfo(this)' class='btn btn-default'>修改</button></td></tr>");
			             }
			             $("#span").html("共"+count+"条记录/"+totalPage+"页/"+levelCount+"人合格");
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
		
		function deleteinfo(obj){
		if(confirm("是否确认删除？")) {
		   var param = {"id":a[obj.id].id};
		   $.ajax({
			    type: "post",
			    url: "./delete_info.do",
			    data: param,
			    dataType:"json",
			    success: function(data){
	    	    b=data;
	    	 	if (b[0].delete_info_result) {
		    		if (b[0].delete_info_result == "success") {
		    			alert("删除成功");
		    		} else
		    			{
		    			alert("删除失败");
		    			}
		    		}
		    	  location.replace("admin_enter_score.jsp");   			          
	            },
			    error:function(XMLHttpRequest, textStatus, errorThrown){
			       alert(XMLHttpRequest.status);
			       alert(XMLHttpRequest.readyState);
			       alert(textStatus);
			     },                        
		   });
		}
	   }  
				
		function updateinfo(obj){
		$('#reid').val(a[obj.id].id);
		$('#reuser_id').val(a[obj.id].user_id);
		$('#rename').val(a[obj.id].name);
		$('#reexam_name').val(a[obj.id].exam_name);
		$('#retime').val(format(a[obj.id].time));
		$('#rescore').val(a[obj.id].score);
		$('#relevel').val(a[obj.id].level);
		$('#recmn').val(a[obj.id].cmn);
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
		
		if ('${update_info_result}') {
			if ('${update_info_result}' == "success") {
				alert("修改成功");
			} else
				alert("修改失败");
		}	
  </script>	
</html>
