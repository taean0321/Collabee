<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ta.dto.*" %>
<%@ page import="com.ta.dao.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	session.setAttribute("id",2);
	int loginId = (int)(session.getAttribute("id"));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script>
        $(function() {
        	$(".linkName").hover(function(){
        		$(this).css("cursor","pointer");
        	});
            $("#fileBoxBtn").mouseenter(function() {
                $("#fileBoxList").css("display","block");
                $("#fileBoxList").css("box-shadow","1px 1px 1px 1px gray");
            });
            $("#fileBoxList").mouseleave(function() {
                $("#fileBoxList").css("display","none");
            });
            $("#close").click(function() {
            	window.history.back();;
            });
            $("#close").hover(function(){
                $("#close").find("img").css("fillter","brightness(0) saturate(100%) invert(56%) sepia(77%) saturate(393%) hue-rotate(8deg) brightness(105%) contrast(96%)");
            });
            $("#documentwrite").click(function(){
                alert("문서작성");
            });
            $("#documentwrite").hover(function(){
                $("#documentwrite").css("background-color","rgb(179,142,34)"); 
                $("#documentwrite").css("cursor","pointer");
            },function(){
                $("#documentwrite").css("background-color","rgb(217,173,43)");
            });
            $(".hoverRightTop").hover(function(){
                $(this).css("color","#dee0db");
            },function(){
                $(this).css("color","white");
            });
            $("#search").focusin(function(){
                $(".search_bar").width("268px");
                $("#search").width("233px");
                $("#documentwrite").css("display","none");
                $(this).css("outline","none");
            });
            $("#search").focusout(function(){
                $(".search_bar").width("143px");
                $("#search").width("100px");
                $("#documentwrite").css("display","block");
            });
            $("#search").keyup(function(key){
                $(this).attr("value",$(this).val());
                var search =  $(this).val();
                $(".linkComment").each(function(index, item){
                	if($(item).find(".linkTitle").text().includes(search)||$(item).find(".linkName").text().includes(search)){
						$(item).parent().css("display","block");                		
                	} else {
						$(item).parent().css("display","none");
                	}
                });
            });
            $(".fileTypeAndFilter").hover(function(){
                $(this).css("filter","opacity(0.4) drop-shadow(0 0 0 white)"); 
            },function(){
                $(this).css("filter","opacity(0.6) drop-shadow(0 0 0 white)"); 
            });
            $("#all").mouseenter(function(){
            	if($(this).attr("class")!="on"){
	                $(this).css("color","white");
            	}
                $(this).css("cursor","pointer");
            }); 
            $("#all").mouseleave(function(){
            	if($(this).attr("class")!="on"){
            		$(this).css("color","rgb(190,194,183)");
            }
            });
            $("#me").mouseenter(function(){
            	if($(this).attr("class")!="on"){
	                $(this).css("color","white");
            	}
                $(this).css("cursor","pointer");
            }); 
            $("#me").mouseleave(function(){
            	if($(this).attr("class")!="on"){
            		$(this).css("color","rgb(190,194,183)");
            }
            });
            $("#me").click(function(){
            	$("#all").removeClass("on");
            	$(this).addClass("on");
            	$(this).css("color","white");
            	$("#all").css("color","rgb(190, 194, 183)");
            	var workspace_id = $("#workspaceListBtn").attr("workspace_id");
            	$("#links").html("");
            	$.ajax({
            		type: 'get',
            		url: 'Controller?command=LinkMeAction',
            		data: {"login_id": <%=loginId%>, "workspace_id": workspace_id},
            		datatype: 'json',
            		success: function(data){
            			$.each(data,function(index,item){
            				var link =
	            				"<div class='link'>" +
	                    			"<a class='linkImg' target='_blank' href='"+item.link_name+"' style='background-image:url("+item.link_picture+"); '></a>" +
	                    			"<div class='pictureImg'>" +
	                        			"<img src='image/upload"+item.picture+"'/>" +
	                    			"</div>" +
	                    			"<div class='linkComment'>" +
	                        			"<h4 class='linkTitle'>"+item.link_title+"</h4>" +
	                        			"<p>"+item.link_explanation+"</p>" +
	                        			"<div>" +
	                            			"<a class='linkName'>"+item.link_name+"</a>" +
	                        			"</div>" +
	                        			"<span>"+item.workspace_name+"</span>" +
	                        			"<span class='documentName'> "+item.title+"</span>" +
	                    			"</div>" +
	                			"</div>";
	                		$("#links").append(link);	
            			});
            		},
            		error: function(r,s,e){
            			
            		}
            	});
            });
            $("#all").click(function(){
            	$("#me").removeClass("on");
            	$(this).addClass("on");
            	$(this).css("color","white");
            	$("#me").css("color","rgb(190, 194, 183)");
            	var workspace_id = $("#workspaceListBtn").attr("workspace_id");
            	$("#links").html("");
            	$.ajax({
            		type: 'get',
            		url: 'Controller?command=LinkAllAction',
            		data: {"login_id": <%=loginId%>, "workspace_id": workspace_id},
            		datatype: 'json',
            		success: function(data){
            			$.each(data,function(index,item){
            				var link =
	            				"<div class='link'>" +
	                    			"<a class='linkImg' target='_blank' href='"+item.link_name+"' style='background-image:url("+item.link_picture+"); '></a>" +
	                    			"<div class='pictureImg'>" +
	                        			"<img src='image/upload/"+item.picture+"'/>" +
	                    			"</div>" +
	                    			"<div class='linkComment'>" +
	                        			"<h4 class='linkTitle'>"+item.link_title+"</h4>" +
	                        			"<p>"+item.link_explanation+"</p>" +
	                        			"<div>" +
	                            			"<a class='linkName'>"+item.link_name+"</a>" +
	                        			"</div>" +
	                        			"<span>"+item.workspace_name+"</span>" +
	                        			"<span class='documentName'> "+item.title+"</span>" +
	                    			"</div>" +
	                			"</div>";
	                		$("#links").append(link);	
            			});
            		},
            		error: function(r,s,e){
            			
            		}
            	});
            });
            
            $("#workspaceListBtn").click(function(){ 
                $("#workspace_list").children().css("display","block");
                $("#workspaceListBtn").html("공간 검색").css("color", "rgb(255, 255, 255)");
                
            });
            $(".li").click(function(){
                var workspace = $(this).text();
                $("#workspaceListBtn").html(workspace);
                $("#workspace_list").children().css("display","none");
            	$("#workspaceListBtn").attr("workspace_id",$(this).attr("workspace_id"))   
            	var workspace_id = $("#workspaceListBtn").attr("workspace_id");
            	$("#links").html("");
            	$("#recentlyLink").html("");
            	$.ajax({
            		type: 'get',
            		url: 'Controller?command=LinkSelectWorkspaceAction',
            		data: {"login_id":<%=loginId%>,"workspace_id":workspace_id},
            		datatype: "json",
            		success: function(data){
            			$.each(data,function(index, item){
            				if(index==0){
            					$.each(item,function(index,item2){
            						var link =
            							"<div class='link'>" +
                                    		"<a class='linkImg' target='_blank' href='"+item2.link_name+"' style='background-image:url("+item2.link_picture+"); '></a>" +
                                    		"<div class='pictureImg'>" +
                                        		"<img src='image/upload"+item2.picture+"'/>" +
                                    		"</div>" +
                                    		"<div class='linkComment'>" +
                                        		"<h4 class='linkTitle'>"+item2.link_title+"</h4>" +
                                        		"<p>"+item2.link_explanation+"</p>" +
                                        		"<div>" +
                                            		"<a class='linkName'>"+item2.link_name+"</a>" +
                                        		"</div>" +
                                        		"<span>"+item2.workspace_name+"</span>" +
                                        		"<span class='documentName'> "+item2.title+"</span>" +
                                    		"</div>" +
                                		"</div>";
                                	$("#links").append(link);
            					});
            				} else {
            					var recentlyLink = "";
            					if(item.length==""){
            						recentlyLink =
            							"<p id='recentlyNotExistenceText'>최근 올린 링크가 없습니다.</p>";
            						$("#recentlyLink").append(recentlyLink);
            					} else {
	            					$.each(item,function(index,item3){
	            						recentlyLink = 
	            							"<li class='liImg'><a href='"+item3.link_name+"' target='_blank' link_id='"+item3.link_id+"''><img src='image/link.svg'/>"+item3.link_title+"</a></li>"
	            						$("#recentlyLink").append(recentlyLink);	
	            					});
            					}
            				}
            			});
            		},
            		error : function(r,s,e){
            			
            		}
            	});
            });
            $(".li").hover(function (){
                $(this).css("background-color", "rgb(242,242,242)");
                $(this).css("cursor","pointer");
            }, function(){
                $(this).css("background-color", "rgb(255, 255, 255)");
            });
            $("#close").hover(function(){
            	$(this).children().css("filter","brightness(0) saturate(100%) invert(68%) sepia(74%) saturate(461%) hue-rotate(2deg) brightness(92%) contrast(87%)");
            },function(){
            	$(this).children().css("filter","brightness(0) saturate(100%) invert(93%) sepia(0%) saturate(1646%) hue-rotate(76deg) brightness(95%) contrast(89%)");
            });
            $(".linkImg").hover(function(){
            	$(this).css("border","1px solid rgb(193,193,193)");
            },function(){
            	$(this).css("border","1px solid rgb(225,225,225)");
            });
        });
    </script>
    <style>
    	.pictureImg > img {
    		border-radius: 35px;
    	}
		.fileTypeAndFilter {
            float: right;
            width: 20px;
        }
        body{
            margin: 0px;
            padding: 0px;
        }
        * {
            font-family: -apple-system,BlinkMacSystemFont,Malgun Gothic,Hiragino Kaku Gothic ProN,Hiragino Sans,Meiryo,MS PGothic,sans-serif,Dotum;
        }
        .link {
         	border-bottom: 1px solid rgb(225,225,225); padding-bottom: 14px; width: 1400px; height: 100px; margin-bottom: 14px;
        }
        #rooptop {
         	position:fixed;
            z-index: 1;
        }
        #top {
            width:1720px;
            height:122px;
            background-image: url('image/linkBI.png');
            margin-left: 1px;
        }
        #top2 {
         	position: absolute;
            content: "";
            display: block;
            width: 1720px;
            height: 122px;
            background-color: rgba(0, 0, 0, 0.6);
            z-index:0;
        } 
        #bottom {
            margin-top: 122px;
        }
        #leftTop {
            position: relative;
            padding-left: 40px;
            flex-direction: column;
            -webkit-box-pack: justify;
            justify-content: space-between;
            width:1423px;
            height: 121px;
            margin-right:0px;      
        }
        #rightTop {
            width:240px;
            height:101px;
            margin-left:0px;
            margin-top:25px;
            font-size: 12px;
            color:white;  
            position: relative; 
            float:right;  
            padding: 0px;  
        }
        #leftBottom {
            float: left;
            width: 1470px;
            height:840px;
            padding: 7px 0 0 0;
            overflow: auto;
        }
        #leftBottom::-webkit-scrollbar {
            width: 4px;
        }
        #leftBottom::-webkit-scrollbar-track {
            background-color: white;
            border-radius: 5px;
        }
        #leftBottom::-webkit-scrollbar-thumb {
            background-color: rgb(225,225,225);
            border-radius: 5px;
        }
        #rightBottom {
            float: right;
            width:180px;
            height:100%;
            margin-top: 33px;
            margin-left: 1500px;
            position: fixed;
        }
        .fileicon {
            float: right;
            width: 21px;
            height: 21px;
        }
        option {
            background-color: aliceblue;
            color: black;
        }
        select {
            border: 0px; 
            background-color: rgb(22,74,102);
            margin-top: 24px;
            margin-bottom: 12px;
            color:white;
        }
        .search_bar{
            float: right;
            border: 1px solid rgba(255, 255, 255, 0.6);
            border-radius: 4px;
            width:143px;
            height:27px;
            margin-top: 18px;
        }
        #search {
            width:100px;
            height: 27px;
            background-color: rgba(255, 255, 255, 0);
            font-size: 13px;
            border: 0px ; 
            color: white;
            vertical-align: top;
        }
        #search_img {
            margin-top: 5px;
            margin-left: 7px;
            width: 17px;
            top: 10px;
            right: 12px;
        }
        #documentwrite {
            float: right; 
            background-color: rgb(217,173,43);
            text-align: center;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
            line-height: 1.5;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 0px;
            width: 105px;
            height: 28px;
            margin-top: 18px;
            margin-left: 20px;
        }
        .extension {
            font-size:14px;
            margin-top: 0;
            padding: 0;
        }
        #recentlyLinks {
            font-size: 14px;
            color: rgb(136,136,136);
        }
        #links {
        	padding: 16 16 16 16; width:1300px; height: 100%;  margin-top:15px; margin-left: 35px;
        }
        #left {
            float: left;
            width: 200px;
            height: 969px;
            background-color: #232323;
            border: none;
            position:absolute;
            display:block;
        }
        #right {
            float: left;
            margin-left: 200px;
            height: 100px; 
        }
        #fileBoxBtn {
            float: left; 
            margin-left:20px;
            cursor: pointer;
        
        }
        #fileBoxList {
            display : none; 
            border: 1px solid white; 
            width:150px; 
            height: 75px; 
            margin-top: 3px;
            border-radius: 5px; 
            margin-left: 60px; 
            background-color: white;
            color: black;
            cursor: pointer;
        }
        img {
            filter: opacity(0.6) drop-shadow(0 0 0 white);
        }  
        #close{
            background-color: #232323;
            z-index: 1;
            border: 0px; width:40px; height:40px; margin-left: 18px; margin-top: 18px; padding:0px; z-index:1; position: fixed;
        }
        /* #me #all {
            cursor: pointer;
        } */
        #workspaceListBtn {
	    	margin-top : 24px;
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
			background-color: rgba(255, 255, 255, 0);
			color: white;
			font-weight: bold;
			border:none;
	    }
	    #workspaceDownSvg {
	        filter: brightness(0) saturate(100%) invert(100%) sepia(100%) saturate(0%) hue-rotate(241deg) brightness(103%) contrast(103%);
	        width:16px; 
	        height:16px;
	    }
	    #workspace_list {
	    	display:flex;
			justify-content: right;
			position: absolute;
			margin-top:-10px;
			margin-left: 240px;
			z-index: 1;
	    }
	    #workspace_list ul{ 
	        position: absolute;
	        list-style: none;
	        background-color: rgb(255, 255, 255);
	        border-radius: 4px;
	        width: 160px;
	        height: 205px;
	        border:1px solid #e1e1e1;
	        font-size: 14px;
	        font-weight: 500;
	        color:rgb(34, 34, 34);
	        padding:5px 12px;
	        line-height: 2.5;
	        display:none;
	        overflow: auto;
	    }
	    #workspace_list ul::-webkit-scrollbar {
            width: 4px;
        }
        #workspace_list ul::-webkit-scrollbar-track {
            background-color: white;
            border-radius: 5px;
        }
        #workspace_list ul::-webkit-scrollbar-thumb {
        	background-color: rgb(225,225,225);
            border-radius: 5px;
        }
	    #workspace_list ul li:nth-child(1){
	        color:rgb(136, 136, 136); 
	        font-size: 10.5px; 
	        pointer-events: none;
	    }
	    #workspace_list li{
			padding:2px;
	        display:flex;
	        flex-direction: row;
	        align-items: center;
	        border-radius:5px;
	    }
	    #documentwrite > img {
			width:13px; height: 13px; margin-top: 3px;
		}
		#documentwrite > span {
			color:white; vertical-align:top;
		}
		#me {
			margin-right: 26px; font-size: 12px; color: rgb(190,194,183);
		}
		#all {
			font-size: 12px; color: white;
		}
		#filter {
			margin-left:17px;
		}
		#do {
			float: left; margin-left: 34px;	
		}
		#do > a {
			text-decoration:none; color:white;
		}
		#decision_making {
			float: left; margin-left:26px;
		}
		#decision_making > a {
			text-decoration:none; color:white;
		}
		#fileBoxBtn {
			margin-left: 26px;
		}
		#fileBoxBtn > img {
			width:12px; height:12px;; vertical-align: center;
		}
		#fileBtn  {
			margin: 17px 0px 0px 10px;
		}
		#fileBtn > a {
			text-decoration:none; color: black;
		}
		#fileBtn > a > img {
			width: 15px; height:15px; margin-right: 8px; vertical-align: bottom;
		}
		#linkBtn {
			margin: 10px 0px 0px 10px;
		}
		#linkBtn > img {
			width: 15px; height:15px; margin-right: 8px; vertical-align: bottom;
		}
		.pictureImg {
			float: right; margin-right: 10px;
		}
		.pictureImg > img {
			width:20px;
		}
		.linkImg {
			float:left; border: 1px solid rgb(225,225,225); border-radius:3px; width:130px; height:100px; margin-right: 15px; margin-left: 15px;
		}
		.linkComment > h4 {
			margin-bottom: 5px; margin-top: 0px;
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
		}
		.linkComment > p {
			margin-top: 5px; margin-bottom: 0px; font-size: 12px; color:gray;
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
		}
		.linkComment > div {
			margin-top: 0px; margin-bottom:20px; font-size: 12px;
		}
		.linkComment > div > a {
			color: rgb(2,135,207);
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
		}
		.linkComment > span {
			font-size: 12px;
		}
		#mainText {
			float: left; margin-top: 20px; margin-bottom: 3px; color:white; font-size: 22px; margin-right: 8px;  font-weight: 900;
		}
		#subText {
			clear:both; margin-top:0px; font-size: 12px; color: white; margin-bottom: 18px;
		}
		#recentlyNotExistenceText {
			font-size: 12px;
    		margin-left: 5px;
		}
		.liImg {
			list-style: none;
			width:200px;
		}
		.liImg > img {
			margin: 0px 5px;
       		width:13px;
       		vertical-align:bottom;
       		filter: brightness(0) saturate(100%) invert(93%) sepia(2%) saturate(30%) hue-rotate(317deg) brightness(84%) contrast(90%);
		}
		.li {
       		width:151px;
       	}
       	li {
       		font-size:14px; margin: 5px 0px 0px 0px;
       		white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
       	}
       	.liImg > a > img {
       		margin: 0px 5px;
       		width:13px;
       		vertical-align:bottom;
       		filter: brightness(0) saturate(100%) invert(93%) sepia(2%) saturate(30%) hue-rotate(317deg) brightness(84%) contrast(90%);
       	}
       	.liImg > a {
       		color:black;
       		font-size: 13px;
       		text-decoration:none;
       		width: 200px;
       		white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
       	}
       	.documentName {
       		color: green;
       	}
       	.linkImg {
       		background-repeat: no-repeat;
    		background-position: center center;
    		background-size: cover;
       	}
	</style>
</head>
<body>
	<div id="left">
        <button id="close">
            <img src="image/x.svg" style="width:35px; height:35px; margin:0px; padding: 0px; "/>
        </button>
    </div>
    <div id="right"> 
        <div id="rooptop">
            <div id="top2"></div>
            <div id="top" >
                <div style="float:left;" id="leftTop" >
                	<%
                    	FileDao fDao = new FileDao();
                    	ArrayList<WorkspaceListDto> wDto = fDao.getFileWorkspaceList(loginId);
                    %>
                    <p id="mainText">링크 </p>
                    <button id="workspaceListBtn" workspace_id="0">모든 공간</button>
					<svg id="workspaceDownSvg" viewBox="0 0 24 24" class="svg1"><path d="M17.0278306,8 C18.1356358,8 18.40014,8.63354932 17.6171348,9.41655445 L13.4502437,13.5834455 C12.6679023,14.365787 11.40014,14.3664507 10.6171348,13.5834455 L6.45024373,9.41655445 C5.66790231,8.63421303 5.93074941,8 7.03954794,8 L17.0278306,8 Z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
                    <div id="workspace_list">
                		<ul>
                    		<li class="li">공간 검색</li>
                    		<li class="li" workspace_id="0">모든 공간</li>
                    <%
                    	for(WorkspaceListDto workspaceList : wDto){
                    %>
                    		<li class="li" workspace_id="<%=workspaceList.getWorkspaceId()%>"><span><%=workspaceList.getWorkspaceName()%></span></li>
					<%
                    	}
					%>
		                </ul>
           			</div>
                    <button id="documentwrite">
                        <img src="image/pen.svg"/>
                        <span>문서 작성</span>
                    </button>
                    <div class="search_bar">
                        <img src="image/magnifier.svg" id="search_img"/>
                        <input id="search" type="search" placeholder="검색"/>
                    </div>
                    <p id="subText"><b>업로드한 링크를 관리할 수 있습니다.</b></p>
                    <span id="me">내 링크</span>
                    <span id="all" class="on">전체 링크</span>
                    <span id="filter"><img class="fileTypeAndFilter fileicon" src="image/filter.svg "/></span>
                </div>
                    <div id="rightTop">
                        <div id="do"><a class="hoverRightTop" href="todo.jsp">할 일</a></div>
                        <div id="decision_making"><a class="hoverRightTop" href="0dm2.jsp">의사결정</a></div>
                        <div class="hoverRightTop" id="fileBoxBtn">파일함 <img src="image/down.svg"/></div><br/>
                        <div id = "fileBoxList">
                            <div id="fileBtn"><a href="Controller?command=FilesAction"><img src="image/file.svg"/>파일</a></div>
                            <div id="linkBtn"><img src="image/link.svg"/>링크</div>
                        </div>
                    </div>
                </div>
        </div>
        <div id="bottom">
            <div id="leftBottom">
                <div id="links">
                <%
                	LinkDao lDao = new LinkDao();
                	ArrayList<LinkDto> AllWorkspaceTotalLink = lDao.getAllWorkspaceTotalLink(loginId);
                	
                	for(LinkDto link : AllWorkspaceTotalLink){
                %>
                	<div class="link">
                        <a class="linkImg" target="_blank" href="<%=link.getLink_name() %>" style="background-image:url(<%=link.getLinkPicture()%>); "></a>
                        <div class="pictureImg">
                            <img src="image/upload/<%=link.getPicture()%>"/>
                        </div>
                        <div class="linkComment">
                            <h4 class="linkTitle"><%=link.getLink_title() %></h4>
                            <p><%=link.getLink_explanation() %></p>
                            <div>
                                <a class="linkName"><%=link.getLink_name() %></a>
                            </div>
                            <span><%=link.getWorkspace_name() %></span>
                            <span class='documentName'><%=link.getTitle() %></span>
                        </div>
                    </div>
                <%		
                	}
                %>
                </div>
            </div>
            <div id="rightBottom">
                <div id="recentlyLinks">최근 올린 링크</div>
                <div id="recentlyLink">
				<%
                	ArrayList<RecentlyLinkDto> AllWorkspaceRecentlyLink = lDao.getAllWorkspaceRecentlyLink(loginId);
                	if(AllWorkspaceRecentlyLink.size()==0){
                %>
                	<p id="recentlyNotExistenceText">최근 올린 링크가 없습니다.</p>
                <%	
                	} else {
                		for(RecentlyLinkDto recentlyLink : AllWorkspaceRecentlyLink){
                %>
                	<li class="liImg"><a href="<%=recentlyLink.getLink_name() %>" target="_blank" link_id="<%=recentlyLink.getLink_id() %>"><img src="image/link.svg"/><%=recentlyLink.getLink_title() %></a></li>
                <%			
                		}		
                	}
                %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>