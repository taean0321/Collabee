<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ta.dto.*" %>
<%@ page import="com.ta.dao.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	session.setAttribute("id",3);
	int loginId = (int)(session.getAttribute("id"));
	int documentId = 2;
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script>
    $(function(){
        $("#slideComment").click(function(){
        	$("#comments").html("");
            $("#comment").animate({width:"toggle"},400);
			$.ajax({
				type: 'get',
				url: 'Controller?command=CommentContentAction',
				data: {"documentId":<%=documentId%>},
				datatype: 'json',
				success: function(data){
					$.each(data,function(index,item){
						var comment = "";
						if(item.file_id==0 && item.link_id==0){
							comment =
								"<div class='comment' message_id='"+item.message_id+"'>" +
			                		"<div><img class='profile' src='image/"+item.picture+"'/></div>" +
			                		"<div>" +
			                    		"<p class='information'><b>"+item.name+"</b><span> * "+item.creation_date+"</span></p>" +
			                    		"<p class ='information'>"+item.content+"</p>" +
			                		"</div>" +
			            		"</div>" ;
						} else if(item.file_id>0 && item.link_id==0){
							var fileName = "";
							$.ajax({
								type:'get',
								url:'Controller?command=CommentGetFileNameAction',
								data:{"file_id":item.file_id},
								datatype:'json',
								async: false,
								success: function(data){
									fileName = data.fileName;
								},
								error: function(r,s,e){
									
								}
							});
							comment =
								"<div class='comment' message_id='"+item.message_id+"'>" +
		                			"<div><img class='profile' src='image/"+item.picture+"'/></div>" +
		                			"<div>" +
		                    			"<p class='information'><b>"+item.name+"</b><span> * "+item.creation_date+"</span></p>" +
		                    			"<p class ='information'><a class='fileA' href='image/upload/"+fileName+"' download><img class='fileImg' src='image/file.svg'/>"+fileName+"</a></p>" +
		                			"</div>" +
		            			"</div>" ;
						} else if(item.link_id>0 && item.file_id==0){
							var linkName = "";
							$.ajax({
								type:'get',
								url:'Controller?command=CommentGetLinkNameAction',
								data:{"link_id":item.link_id},
								datatype:'json',
								async: false,
								success: function(data){
									linkName = data.linkName;
								},
								error: function(r,s,e){
									
								}
							});
							comment = 
								"<div class='comment' message_id='"+item.message_id+"'>" +
	                				"<div><img class='profile' src='image/"+item.picture+"'/></div>" +
	                				"<div>" +
	                    				"<p class='information'><b>"+item.name+"</b><span> * "+item.creation_date+"</span></p>" +
	                    				"<p class ='information'><a class='linkA' href='"+linkName+"'><img class='LinkImg' src='image/link.svg'/>"+linkName+"</a></p>" +
	                				"</div>" +
	            				"</div>" ;
						}
						$("#comments").append(comment);
					});
				},
				error : function(r,s,e){
					
				}
			});
        });
        $("#checkbox").click(function(){
            alert("댓글만보기");
        });
        $(".recommentBtn").click(function(){
            alert("답글쓰기");
        });
        $("#save").click(function(){
        	var message = $("#textbox").val();
        	var documentId = 2;
       		$.ajax({
       			type:'get',
       			url: 'Controller?command=CommentContentWriteAction',
       			data: {"loginId":<%=loginId%>,"message":message,"documentId":documentId},
       			datatype: 'json',
       			success: function(data){
       				$("#comment").css("display","none");
       				$("#textbox").val("");
       			},
       			error : function(r,s,e){
       				alert("실패");
       			}
       		});
        });
        $("#save").mouseenter(function() {
                $("#save").css("background-color","#d9ad2b");
        });
        $("#save").mouseleave(function() {
            $("#save").css("background-color","#d3d3d3");
        });
        $("#recommentXbtn").click(function(){
            $("#clickRecomment").css("display","none")
        });
        $("#textbox").keyup(function(){
        	$(this).attr("value",$(this).val());
        });
        $("#commentFile").change(function(){
			$("#loginIdInput").val(<%=loginId%>);
			var document_id =  2; //$(this).parent().parent().parent().find("#chatting_room_name").attr("chatting_room_id");
			$("#documentIdInput").val(document_id);
        	$("#fileUpload").submit();
		});
    });
</script>
<style>
	.fileImg, .LinkImg {
		vertical-align:bottom;
		width: 13px;
		filter: brightness(0) saturate(100%) invert(50%) sepia(5%) saturate(4258%) hue-rotate(7deg) brightness(85%) contrast(88%);
		margin-right:5px;
	}
	.fileA, .linkA {
		text-decoration: none;
		white-space: nowrap;
        overflow: hidden;   
        text-overflow: ellipsis;
        width:260px;
	}
	.fileA {
		color: rgb(133,111,46)
	}
	.linkA {
		color: rgb(2,136,209);
	}
    #comment {
        width: 380px;
        height:875px;
        background-color: #fafafa;
        float: right;
        margin-top: 70px;
        display:none;
    }
    #comments {
        margin-top: 10px;
        margin-left: 20px;
        width:360px;
        height:650px;
        overflow: auto;
    }
    #comments::-webkit-scrollbar{
        width: 5px;
    }
    #comments::-webkit-scrollbar-thumb{
        background-color: #e1e1e1;
        border-radius: 5px;
    }
    #comments::-webkit-scrollbar-track{
        background-color: #e1e1e1;
        border-radius: 5px;
    }
    .profile {
        width:22px;
        float: left;
    }
    .information {
        padding: 0px;
        margin: 0px;
        margin-left: 25px;
        font-size: 12px;
        margin-top: 5px;
    }
    .recommentBtn {
        width:60px;
        font-size: 12px;
        padding: 0px;
        margin-left: 25px;
        margin-top: 10px;
    }
    #commentwrite {
        width: 380px;
        height: 175px;
    }
    #textbox {
        border: none;
        width: 320px;
        height:100px;
        text-align:start;
        margin-top: 5px;
    }
    #checkbox {
        margin-left: 20px; 
        width:10px;
    }
    .checkboxCotent {
        font-size: 12px;
        vertical-align: center;
        margin-top: 0px;
        padding: 0px;
    }
    #save {
        margin-left: 280px;
        margin-bottom: 10px;
        border: none;
        background-color: #d3d3d3;
        color:white;
        border-radius: 5px;
        height:25px;
        width: 40px;
        font-size: 12px;
        float:left;
        margin-top:-27px;
    }
    .recommentContent {
        padding: 0px;
        font-size: 12px;
        margin-top: 0px;
        margin-bottom: 0px;
    }
    #clickRecomment{
        width:320px;
        height: 45px;
        border-bottom: 1px solid #d3d3d3;
    }
    #recommentXbtn {
        float: right;
        width: 20px;
        height: 20px;
        padding: 0px;
        margin-top: 5px;
        border:none;
        background-color:white;
    }
    #buttonImg {
        width: 20px;
        filter: brightness(0) saturate(100%) invert(0%) sepia(86%) saturate(2941%) hue-rotate(215deg) brightness(85%) contrast(110%);
    
    }
    #fileUpload > label > img {
	    width:24px;
	    margin : 0px 0px 0px 2px;
    }
    #loginIdInput, #documentIdInput, #commentFile {
    	display:none;
    }
    .comment {
    	margin-bottom:20px;
    }
</style>
</head>
<body>
	<div id="comment">
        <div id="comments">
            <div class="comment">
                <div><img class="profile" src="image/+.svg"/></div>
                <div>
                    <p class="information"><b>이름</b><span> * 5월 8일 오후 5:15</span></p>
                    <p class ="information">내용</p>
                </div>
            </div>

        </div>
        <div id="commentWrite">
            <div style=" border: 1px solid #d3d3d3;border-radius: 5px; padding: 10px 5px 0px 10px; width:330px; margin-left: 17px; background-color: white; margin-top: 10px;">
                <input id="textbox" type="text" placeholder="여기에 입력하세요"/>
                 <form id="fileUpload" action="Controller?command=CommnetFileUploadAction" method="post" enctype="multipart/form-data">
	            	<label for="commentFile">
	            		<img src="image/fileIcon.svg"/>
	            	</label>
	                <input type="file" id="commentFile" name="commentFile"/>
					<input type="hidden" id="loginIdInput" name="loginId" value=""/>
                	<input type="hidden" id="documentIdInput" name="documentId" value=""/>
            	</form>
                <button id="save">저장</button>
            </div>
        </div>
        <input type="checkbox" id="checkbox"/><span class="checkboxCotent"> 댓글만 보기</span>
    </div>
    <button id="slideComment" style="float: right; margin-top: 80px;"><img src="image/comment.svg" style="width:20px; vertical-align: bottom;"/></button>
</body>
</html>