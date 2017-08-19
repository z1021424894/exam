<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'stu_ann.jsp' starting page</title>
    
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
			<ul id="ann"></ul>
		</div>
	</div>
    </div>
  </body>
  
  <script type="text/javascript">
		var a=[];
		$.ajax({
		    type: "post",
		    url: "./get_ann.do",
		    data:"",
		    dataType:"json",
		    success: function(data){
		    		a=data;
		    		for(var i=0;i<a.length;i++)
		    			{
		    			 
		    			  $("#ann").append("<li style='color:blue'><a data-toggle='modal' href='#look_ann' id="+i+" onclick='lookann(this)'>"+a[i].title+"</a><p class='text-right' style='color:black'><small>"+new Date(parseInt(a[i].time)).toLocaleString()+"</small></p></li><hr/>");
		    			 
		    			}
		             },
		             error:function(XMLHttpRequest, textStatus, errorThrown){
		            	 alert(XMLHttpRequest.status);
		            	 alert(XMLHttpRequest.readyState);
		            	 alert(textStatus);
		             },                        
		});
		
		function lookann(obj){
		$('#ann_content').html(a[obj.id].content);
		}  
  </script>
</html>
