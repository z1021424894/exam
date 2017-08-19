<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'stu_exam.jsp' starting page</title>
    
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
    <table class="table table-hover table-bordered">
	  <caption><br>考试信息</caption>
	  <thead>
		<tr>
			<th>科目名称</th>
			<th>报名时间</th>
			<th>截止时间</th>
			<th>考试时间</th>
			<th>合格分数线</th>
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
		    url: "./get_exam.do",
		    data:{user_id:'${user.user_id}'},
		    dataType:"json",
		    success: function(data){
		    		a=data.exam;
		    		c=data.info;
		    		for(var i=0;i<a.length;i++)
		    			{
		    			  $("#tb_exam").append("<tr><td>"+a[i].exam_name+"</td><td>"+new Date(parseInt(a[i].entertime)).toLocaleString()+"</td><td>"+new Date(parseInt(a[i].endtime)).toLocaleString()+"</td><td>"+new Date(parseInt(a[i].examtime)).toLocaleString()+"</td><td>"+a[i].mark+"</td><td><button type='button' class='btn btn-default' id="+i+" onclick='enterexam(this)'>报名</button></td></tr>");
		    			  for(var j=0;j<c.length;j++) {
		    				if(c[j].exam_name == a[i].exam_name) {
		    					$("#"+i).attr("disabled","disabled");
		    					break;
		    				}
		    			}	
		    			}
		             },
		             error:function(XMLHttpRequest, textStatus, errorThrown){
		            	 alert("请登录");
		             },                        
		});
		
		function enterexam(obj) {
		if(confirm("是否确认报名？")) {
		   var param = {"exam_name":a[obj.id].exam_name,"user_id":'${user.user_id}',"name":'${user.name}'};
		   $.ajax({
			    type: "post",
			    url: "./add_info.do",
			    data: param,
			    dataType:"json",
			    success: function(data){
	    	    b=data;
	    	 	if (b[0].add_info_result) {
		    		if (b[0].add_info_result == "success") {
		    			alert("报名成功！");
		    		} 
		    		else if(b[0].add_info_result == "repeat") {
		    			alert("请勿重复报名！");
		    		}
		    		else if(b[0].add_info_result == "beforetime") {
		    			alert("未到报名时间！");
		    		}
		    		else if(b[0].add_info_result == "aftertime") {
		    			alert("已到截止时间！");
		    		}
		    		else {
		    			alert("报名失败");
		    		}
		    	}
		    	  location.replace("stu_exam.jsp");   			          
	            },
			    error:function(XMLHttpRequest, textStatus, errorThrown){
			       alert(XMLHttpRequest.status);
			       alert(XMLHttpRequest.readyState);
			       alert(textStatus);
			     },                        
		   });	
		}		   
		}  
  </script>
</html>
