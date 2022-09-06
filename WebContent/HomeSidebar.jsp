<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.yr.dto.*" %>
<%@ page import="com.yr.dao.*" %>
<%@ page import="com.ta.dto.*" %>
<%@ page import="com.ta.dao.*" %>
<%@ page import = "com.jm.dao.*" %>
<%@ page import = "com.jm.dto.*" %>
<%
	session.setAttribute("id",4);
	int loginId = (int)(session.getAttribute("id"));
%>
<%
	/* int member_id = (Integer)(session.getAttribute("member_id")); */
	int member_id = 4;
	HomeDao hDao = new HomeDao();
	ArrayList<NoneFolderDto> listNone = hDao.getHomeWorkspace(member_id);
	//ArrayList<NoneFolderDto> listNone = (ArrayList<NoneFolderDto>)request.getAttribute("list2");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>collabee.co/homesidebar</title>
	<link rel="icon" href="Images/favicon.ico" type="image/x-icon">
	<script src="js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
  	<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
  	<script>
    	$(function(){
		    function f1(_this){
		        var chatting_room_id = _this.attr("chatting_room_id");
		        $.ajax({
		   			type: 'get',
		   			url: 'ChattingMessageServlet',
		   			data : {"loginId": <%=loginId%>, "chatting_room_id": chatting_room_id},
		   			datatype: "json",
		   			success: function(data) {
		   				$.each(data, function(index, item){
		   					if(index==0)
		   						$.each(item, function(index, item){
									$("#chatting_room_name").attr("chatting_room_id",item.chatting_room_id);		       						
		   							$("#chatting_room_name").text(item.chatting_room_name);
		   						});
		   					else if(index>0){
		   						$.each(item, function(index, item){
		   							if(item.file_id==0 && item.link_id==0){
		   								var chattingContent =  
			       						"<div class='message' message_id="+item.message_id +">" +
			       			                "<div>" +
			       			                    "<img class='messageProfile' src=image/upload/"+item.picture+"/>" +
			       			                "</div>" +
			       			                "<div>" +
			       			                    "<div><span class='Cname'>"+item.name+"</span><span>"+item.send_time+"</span></div>" +
			       			                    "<div class='chattingMessage'>"+item.message+"</div>"+
			       			                "</div>"+
			       			            "</div>";
		       							$("#chatting_middle").append(chattingContent);	  
		   							} else if(item.file_id > 0){
			       			             $.ajax({
				       			       		type: 'get',
				       			       		url: 'ChattingFileMessageServlet',
				       			       		data : {"fileId": item.file_id},
				       			       		datatype: "json",
				       			       		async: false,
				       			       		success: function(data) {
		       									var chattingFileContent =  
					       					"<div class='message' id="+item.message_id +">" +
					       			        	"<div>" +
					       			            	"<img class='messageProfile' src="+item.picture+"/>" +
					       			            "</div>" +
					       			            "<div>" +
					       			                "<div><span class='Cname'>"+item.name+"</span><span> "+item.send_time+"</span></div>" +
					       			             	"<div class='messageFile' file_id='"+item.file_id+"'>" +
				                     				"<img class='"+data.picture+"' src='image/file.svg'/>" +
					                     			"<span class='fileName'><a class='messageFileA' href='image/upload/"+data.file_name+"'download> "+data.file_name+"</a></span>" +
					                     			"</div>" +
					                     			"<div style='clear:both;''></div>" +
					                         	"</div>" +
					                     	"</div>"
				       							$("#chatting_middle").append(chattingFileContent);	
				       			       		}, 
					       			       	error: function(r,s,e){
					       		       			alert("파일실패");
					       		       		}
		   								}); 
		   							} else if(item.link_id>0) {
										$.ajax({
											type:'get',
											url : 'ChattingLinkMessageServlet',
											data : {"linkId": item.link_id},
											datatype: "json",
											async:false,
											success: function(data){
												var chattingLinkContent="";
												if(data.picture==null){
													chattingLinkContent	=
														"<div class='message' id="+item.message_id+">" +
										                    "<div>" +
										                        "<img class='messageProfile' src="+item.picture+"/>" + // 경로 image/ 추가
										                    "</div>" +
										                    "<div style='width:350px;'>" +
										                    "<div><span class='Cname'>"+item.name+"</span><span> "+item.send_time+"</span></div>" +
										                        "<a target='_blank' class='chattingLinkA' href='"+data.link_name+"'>"+data.link_name+"</a>" +
										                        "<div class='messageLink' link_id='"+item.link_id+"'>" +
										                        	"<div class='linkImgBox'><img src='image/link.svg'/></div>" +
										                        	"<div class='linkContent'>" +
											                			"<p>"+data.link_title+"</p>" +
																		"<p>"+data.link_explanation+"</p>" +									                        	
										                        	"</div>" +
										                		"</div>" +
										                		"<div style='clear:both;'></div>" +
										                    "</div>" +
										                "</div>";
												} else {
														chattingLinkContent	=
													"<div class='message' id="+item.message_id+">" +
									                    "<div>" +
									                        "<img class='messageProfile' src=image/upload/"+item.picture+"/>" + // 경로 image/ 추가
									                    "</div>" +
									                    "<div style='width:350px;'>" +
									                    "<div><span class='Cname'>"+item.name+"</span><span> "+item.send_time+"</span></div>" +
									                        "<a target='_blank' class='chattingLinkA' href='"+data.link_name+"'>"+data.link_name+"</a>" +
									                        "<div class='messageLink' link_id='"+item.link_id+"'>" +
									                        	"<div class='linkImgBox'><img src='"+data.picture+"'/></div>" +
									                        	"<div class='linkContent'>" +
										                			"<p>"+data.link_title+"</p>" +
																	"<p>"+data.link_explanation+"</p>" +									                        	
									                        	"</div>" +
									                		"</div>" +
									                		"<div style='clear:both;'></div>" +
									                    "</div>" +
									                "</div>";
												}
												$("#chatting_middle").append(chattingLinkContent);
											}, 
											error : function(r,s,e){
												alert("링크실패");
											}
										});	       		
									}
		   						});
		   					}
		   				});
		   			},
		   			error: function(r,s,e){
		   				alert("실패");
		   			}
		        });  
			}
	       	var webSocket = new WebSocket("ws://localhost:9090/Collabee/broadcasting");
	       	webSocket.onmessage = function(e) {
				if(e.data=="file"){
					f1($("#chatting_room_name"));
				} else {
		       		var arr = e.data.split(" ");
		       		if($("#chatting_room_name").attr("chatting_room_id")==arr[0]){
			   			$.ajax({
			   				type: 'get',
			   				url:'ChattingContentServlet',
			   				data:{"messageId":arr[1]},
			   				datatype:'json',
			   				success: function(data){
			   					if(data.file_id==0 && data.link_id==0){
										var chattingContent =  
		       						"<div class='message' message_id="+data.message_id +">" +
		       			                "<div>" +
		       			                    "<img class='messageProfile' src=image/upload/"+data.picture+"/>" +
		       			                "</div>" +
		       			                "<div>" +
		       			                    "<div><span class='Cname'>"+data.name+"</span><span>"+data.send_time+"</span></div>" +
		       			                    "<div class='chattingMessage'>"+data.message+"</div>"+
		       			                "</div>"+
		       			            "</div>";
		   							$("#chatting_middle").append(chattingContent);	  
									} else if(data.file_id > 0){
		       			             $.ajax({
			       			       		type: 'get',
			       			       		url: 'ChattingFileMessageServlet',
			       			       		data : {"fileId": data.file_id},
			       			       		datatype: "json",
			       			       		async: false,
			       			       		success: function(file_data) {
		   									var chattingFileContent =  
				       					"<div class='message' id="+data.message_id +">" +
				       			        	"<div>" +
				       			            	"<img class='messageProfile' src=image/upload/"+data.picture+"/>" +
				       			            "</div>" +
				       			            "<div>" +
				       			                "<div><span class='Cname'>"+data.name+"</span><span> "+data.send_time+"</span></div>" +
				       			             	"<div class='messageFile' file_id='"+data.file_id+"'>" +
			                     				"<img class='"+file_data.picture+"' src='image/file.svg'/>" +
				                     			"<span class='fileName'><a class='messageFileA' href='image/upload/"+file_data.file_name+"'download> "+file_data.file_name+"</a></span>" +
				                     			"</div>" +
				                     			"<div style='clear:both;''></div>" +
				                         	"</div>" +
				                     	"</div>"
			       							$("#chatting_middle").append(chattingFileContent);	
			       			       		}, 
				       			       	error: function(r,s,e){
				       		       			alert("파일실패");
				       		       		}
										}); 
									} else if(data.link_id>0) {
									$.ajax({
										type:'get',
										url : 'ChattingLinkMessageServlet',
										data : {"linkId": data.link_id},
										datatype: "json",
										async:false,
										success: function(link_data){
											var chattingLinkContent="";
											if(data.picture==null){
												chattingLinkContent	=
													"<div class='message' id="+data.message_id+">" +
									                    "<div>" +
									                        "<img class='messageProfile' src='image/upload/"+data.picture+"'/>" + // 경로 image/ 추가
									                    "</div>" +
									                    "<div style='width:350px;'>" +
									                    "<div><span class='Cname'>"+data.name+"</span><span> "+dat.send_time+"</span></div>" +
									                        "<a target='_blank' class='chattingLinkA' href='image/upload/"+link_data.link_name+"'>"+link_data.link_name+"</a>" +
									                        "<div class='messageLink' link_id='"+data.link_id+"'>" +
									                        	"<div class='linkImgBox'><img src='image/link.svg'/></div>" +
									                        	"<div class='linkContent'>" +
										                			"<p>"+link_data.link_title+"</p>" +
																	"<p>"+link_data.link_explanation+"</p>" +									                        	
									                        	"</div>" +
									                		"</div>" +
									                		"<div style='clear:both;'></div>" +
									                    "</div>" +
									                "</div>";
											} else {
													chattingLinkContent	=
												"<div class='message' id="+data.message_id+">" +
								                    "<div>" +
								                        "<img class='messageProfile' src='image/upload/"+data.picture+"'/>" + // 경로 image/ 추가
								                    "</div>" +
								                    "<div style='width:350px;'>" +
								                    "<div><span class='Cname'>"+data.name+"</span><span> "+data.send_time+"</span></div>" +
								                        "<a target='_blank' class='chattingLinkA' href='"+link_data.link_name+"'>"+link_data.link_name+"</a>" +
								                        "<div class='messageLink' link_id='"+data.link_id+"'>" +
								                        	"<div class='linkImgBox'><img src='"+link_data.picture+"'/></div>" +
								                        	"<div class='linkContent'>" +
									                			"<p>"+link_data.link_title+"</p>" +
																"<p>"+link_data.link_explanation+"</p>" +									                        	
								                        	"</div>" +
								                		"</div>" +
								                		"<div style='clear:both;'></div>" +
								                    "</div>" +
								                "</div>";
											}
											$("#chatting_middle").append(chattingLinkContent);
										}, 
										error : function(r,s,e){
											alert("링크실패");
										}
									});	       		
								}
			   				},
			   				error: function(r,s,e){
			   					
			   				}
			   			});
		       		}
				}
	       	}
			webSocket.onopen = function(e) {
				
	   		}
	   		webSocket.onerror = function(e) {
	   			alert(e.data);
	   		}
         
			$("#chattingInput").keyup(function(e){
				$(this).attr("value",$(this).val());
				if(e.keyCode==13){
					if($(this).val()!=""){
						var chattingRoomId = $(this).parent().parent().find("#chatting_room_name").attr("chatting_room_id");
						var message=$(this).val();
						$.ajax({
							type: 'get',
							url: 'ChattingLinkOrMessageServlet',
							data: {"loginId":<%=loginId%>,"message":message,"chattingRoomId":chattingRoomId},
							datatype: 'json',
							success: function(data) {
								webSocket.send(chattingRoomId+" "+data.message_id);
								if(data.link_id>0){
									$.ajax({
										type:'get',
										url : 'ChattingLinkMessageServlet',
										data : {"linkId": data.link_id},
										datatype: "json",
										async:false,
										success: function(link_data){
											var chattingLinkContent	= "";
											if(link_data.picture==null){
												chattingLinkContent	=
													"<div class='message' id="+item.message_id+">" +
									                    "<div>" +
									                        "<img class='messageProfile' src='image/upload/"+item.picture+"''/>" + // 경로 image/ 추가
									                    "</div>" +
									                    "<div style='width:350px;'>" +
									                    "<div><span class='Cname'>"+item.name+"</span><span> "+item.send_time+"</span></div>" +
									                        "<a target='_blank' class='chattingLinkA' href='"+data.link_name+"'>"+data.link_name+"</a>" +
									                        "<div class='messageLink' link_id='"+item.link_id+"'>" +
									                        	"<div class='linkImgBox'><img src='image/link.svg'/></div>" +
									                        	"<div class='linkContent'>" +
										                			"<p>"+data.link_title+"</p>" +
																	"<p>"+data.link_explanation+"</p>" +									                        	
									                        	"</div>" +
									                		"</div>" +
									                		"<div style='clear:both;'></div>" +
									                    "</div>" +
									                "</div>";
											} else {
												chattingLinkContent	=
												"<div class='message' id="+data.message_id+">" +
								                    "<div>" +
								                        "<img class='messageProfile' src='image/upload/"+data.picture+"'/>" + // 경로 image/ 추가
								                    "</div>" +
								                    "<div style='width:350px;'>" +
								                    "<div><span class='Cname'>"+data.name+"</span><span> "+data.send_time+"</span></div>" +
								                        "<a target='_blank' class='chattingLinkA' href='"+link_data.link_name+"'>"+link_data.link_name+"</a>" +
								                        "<div class='messageLink' link_id='"+data.link_id+"'>" +
								                        	"<div class='linkImgBox'><img src='image/upload/"+link_data.picture+"'/></div>" +
								                        	"<div class='linkContent'>" +
									                			"<p>"+link_data.link_title+"</p>" +
																"<p>"+link_data.link_explanation+"</p>" +									                        	
								                        	"</div>" +
								                		"</div>" +
								                		"<div style='clear:both;'></div>" +
								                    "</div>" +
								                "</div>";
											}
											$("#chatting_middle").append(chattingLinkContent);
										}, 
										error : function(r,s,e){
											alert("링크실패");
										}
									});	
								} else {
									var chattingContent =  
			       						"<div class='message' message_id="+data.message_id +">" +
			       			                "<div>" +
			       			                    "<img class='messageProfile' src='image/upload/"+data.picture+"'/>" +
			       			                "</div>" +
			       			                "<div>" +
			       			                    "<div><span class='Cname'>"+data.name+"</span><span>"+data.send_time+"</span></div>" +
			       			                    "<div class='chattingMessage'>"+data.message+"</div>"+
			       			                "</div>"+
			       			            "</div>";
		       						$("#chatting_middle").append(chattingContent);	
								}
							},
							error: function(r,s,e){
								
							}
						});
						$(this).val("");
					}
				}
			});       	 
			$(document).on("mouseenter",".chatting_room_name",function(e){
            	if($(this).attr("click")!="on"){
					$(this).css("background-color","rgb(46,44,39)") 
            	}
            	e.preventDefault();
                e.stopPropagation();
            });
			$(document).on("mouseleave",".chatting_room_name",function(e){
				if($(this).attr("click")!="on"){
					$(this).css("background-color","#393731") 
				}
            	e.preventDefault();
                e.stopPropagation();
            });
			
            $(document).on("click",".chatting_room_name",function(){
            	$(this).attr("click","on");
				$(this).css("background-color","rgb(46,44,39)");
            	f1($(this));            	
		    	$("#chatting_middle").html("");
		    	$("#messengerFiles").css("display","none");
		    	$("#messengerLinks").css("display","none");
		    	$("#inviteChattingRoom").css("display","none");
		    	$("#chattingRoomInformation").css("display","none");
		    	$("#chattingOnOff").css("display","block");
		        if($("#chattingOnOff").css("display")=="block"){
		        	$(this).css("background-color","rgb(110,101,84)")
		        }
            });
            $("#xbutton").click(function(){
				var chatting_room_id = $(this).parent().parent().find("#chatting_room_name").attr("chatting_room_id");
				$(".chatting_room_name").each(function(index, item){
					if($(item).attr("chatting_room_id")==chatting_room_id){
						$(item).css("background-color","#393731");
						$(item).attr("click","");
					}
				});
                $("#chattingOnOff").css("display","none");
                $("#messengerLinks").css("display","none");
                $("#messengerFiles").css("display","none");
                $("#chatting_middle").html("");
                $("#chatting_room_name").attr("chatting_room_id","");
            });
            $(".xBtn").click(function(e){
                $(this).parent().parent().css("display","none");
                $("#chattingFiles").html("");
                e.preventDefault();
                e.stopPropagation();
            });
            $("#slide_chat_up").on("click", function(e){
				$("#workspaceChattingName").html("");
				$("#groupChattingName").html("");
				$("#companyColleague").html("");
				$("#externalPartner").html("");
                $("#right").slideToggle("fast");
                $.ajax({
					type: 'get',
					url: 'ChattingListAndPartnerServlet',
					data: {"loginId":<%=loginId%>},
					datatype: 'json',
					success: function(data){
						$.each(data, function(index, item){
							console.log(data);							
							if(index==0){
								$("#chattingMainName").text(item.chattingMainName);
							} else if(index==1){
								$.each(item, function(index, item2){
									var workspaceChattingName =
										"<div style='padding-right:10px;'>" +
											"<p class='chatting_room_name' chatting_room_id='"+item2.chattingRoomId+"'>"+item2.chattingRoomName+"</p>" +
										"</div>";
									$("#workspaceChattingName").append(workspaceChattingName);	
								});
							} else if(index==2){
								$.each(item, function(index, item2){
									var groupChattingName =
										"<div style='padding-right:10px;'>" +
											"<p class='chatting_room_name' chatting_room_id='"+item2.chattingRoomId+"'>"+item2.chattingRoomName+"</p>" +
										"</div>";
									$("#groupChattingName").append(groupChattingName);	
								});
							} 
							if(data.length==5){
								if(index==3){
									$.each(item, function(index, item2){
										var companyColleague =
											"<div class='chatting_partner' member_id='"+item2.member_id+"'>" +
						                		"<div class='chattingMemberPicture' style='background-image: url(image/upload/"+item2.picture+";'>" +
						                		"</div>"+item2.name+" "+item2.email+""+
						            		"</div>" +
						            		"<div style='clear:both;'></div>";
										$("#companyColleague").append(companyColleague);	
									});
								} else if(index==4){
									$.each(item, function(index, item2){
										var externalPartner =
											"<div class='chatting_partner' member_id='"+item2.member_id+"'>" +
					                			"<div class='chattingMemberPicture' style='background-image: url(image/upload/"+item2.picture+";'>" +
					                			"</div>"+item2.name+" "+item2.email+""+
					            			"</div>" +
					            			"<div style='clear:both;'></div>";
										$("#externalPartner").append(externalPartner);	
									});
								}
							} else {
								if(index==3){
									$("#corporationP").css("display","none");
									$("#partnerOrExternalPartner").text("파트너");
									$.each(item, function(index, item2){
										var partner =
											"<div class='chatting_partner' member_id='"+item2.member_id+"'>" +
				                			"<div class='chattingMemberPicture' style='background-image: url(image/upload/"+item2.picture+";'>" +
				                			"</div>"+item2.name+" "+item2.email+""+
				            			"</div>" +
				            			"<div style='clear:both;'></div>";
									$("#externalPartner").append(externalPartner);		
									});
								}
							}
						});
					},
					error : function(r,s,e){
						alert("실패");
					}
                });
                e.preventDefault();
            });
            $("#documentwrite").click(function(e){
            	$(".documentWriteClickAfterBanner").css("display","block");
            	$(this).parent().css("display","none");
            	$(this).parent().parent().find(".chatting_name").css("display","none")
            	$(".messageProfile").each(function(index,item) {
            		$(item).attr("origin",$(item).attr("src"));
            	});
            	$(".messageProfile").attr("src","image/check.svg");
            	$(".messageProfile").addClass("check");
                $(this).parent().parent().parent().find("#chatting_bottom").children("input").css("display","none");
                $("#fileUpload").css("display","none");
                $(this).parent().parent().parent().find("#documentWriteBtn").css("display","block");
                e.preventDefault();
                e.stopPropagation();
            });
            //$(".messageProfile").on("click",function(){
            $(document).on("click", ".messageProfile", function() {
            	if($(this).attr("class").includes("check")){
					if($(this).attr("class").includes("filter-active")) {
						$(this).removeClass("filter-active");
					}else {
						$(this).addClass("filter-active");
					}            		
            	}
            });
            $(".xbutton").click(function(){
            	$(".messageProfile").each(function(index,item) {
            		$(item).attr("src",$(item).attr("origin"));
            		$(item).css("filter","brightness(0) saturate(100%) invert(54%) sepia(0%) saturate(0%) hue-rotate(51deg) brightness(98%) contrast(97%)");
            	});
            	$(".messageProfile").removeClass("check");
            	$(".documentWriteClickAfterBanner").css("display","none");
            	$("#documentwrite").parent().css("display","block");
            	$(".chatting_name").css("display","block")
            	$("#chatting_bottom").children("input").css("display","block");
            	$("#documentWriteBtn").css("display","none");
            	$("#fileUpload").css("display","block");
            });
            $("#documentwrite").hover(function(){
                $(this).css("background-color","rgb(179,142,34)"); 
                $(this).css("cursor","pointer");
            },function(){
                $(this).css("background-color","rgb(217,173,43)");
            });
            // 채팅창에서 채팅창명 클릭시 나오는 방정보
            $("#chattingRoomInformationBtn").click(function(e){
            	$("#chattingparticipantsInformation").html("");
            	$("#chattingParticipantsInformation2").html("");
            	var chatting_room_id = $(this).children("#chatting_room_name").attr("chatting_room_id");
            	$.ajax({
			       		type: 'get',
			       		url: 'ChattingParticipantsServlet',
			       		data : {"chatting_room_id": chatting_room_id },
			       		datatype: "json",
			       		success: function(data) {
			       			$.each(data, function(index, item){
			       				if(index==0){
				       				$("#participants").find("span").text(item.countParticipants);			       					
			       				}
			       				if(index > 0){
			       					var participants =
			       						"<div>" +
                                        	"<img class='participantsImg' member_id='"+item.member_id+"' src='image/upload/"+item.picture+"'>" +
                                        	"<span style='font-size: 10px; margin: 0px 0px 0px 3px;'>"+item.name+"</span>" +
                                    	"</div>";
                                    $("#chattingparticipantsInformation").append(participants);
                                    var participants2 = 
                                    	"<div class='participantBox' member_id='"+item.member_id+"'>" +
						    				"<img src='"+item.picture+"'/> " + item.name +
						    			"</div>" ;
						    		$("#chattingParticipantsInformation2").append(participants2);
			       				}
			       			});
			       		},
			       		error : function(r,s,e) {
			       			
			       		}
            		
            	});
                if($(this).parent().find("#chattingRoomInformation").css("display")=="none"){
                	$(this).parent().find("#chattingRoomInformation").css("display","block");
                } else {
                	$(this).parent().find("#chattingRoomInformation").css("display","none");
                }
                e.preventDefault();
                e.stopPropagation();
            });
            $("#alarmBtn").click(function(e){
                if($("#alarmSetting").css("display")=="none"){
                    $("#alarmSetting").css("display","block");
                } else {
                    $("#alarmSetting").css("display","none");
                }
                e.preventDefault();
                e.stopPropagation();
            });
            $("#alarmOn").click(function(e){
                $(this).css("color","rgb(217,173,43)");
                $(this).parent().children("#alarmOff").css("color","black");
                $(this).parent().parent().find("span").find("img").attr("src","image/bell.svg");
                $(this).parent().parent().find("#alarmText").text(" 모든 메세지 알림받기");
                $("#alarmSetting").css("display","none");
                e.preventDefault();
                e.stopPropagation();
            });
            $("#alarmOff").click(function(e){
                $(this).css("color","rgb(217,173,43)");
                $(this).parent().children("#alarmOn").css("color","black");
                $(this).parent().parent().find("span").find("img").attr("src","image/bellOff.png");
                $(this).parent().parent().find("#alarmText").text(" 끄기");
                $("#alarmSetting").css("display","none");
                e.preventDefault();
                e.stopPropagation();
            });
            $("#alarm").click(function(e){
                if($(".mainAlarm").css("display")=="none"){
                    $(".mainAlarm").css("display","block");
                } else {
                    $(".mainAlarm").css("display","none");
                }
                e.preventDefault();
                e.stopPropagation();
            });
            $(".notDistrubMode").click(function(e){
                $("#alarm").children().attr("src","image/zAlarm.svg"); 
                $(this).css("color","rgb(217,173,43)")
                $(".distrubMode").css("display","block");
                $(".mainAlarm").css("display","none");
                e.preventDefault();
                e.stopPropagation();
            });
            $(".distrubMode").click(function(e){
                $(".notDistrubMode").css("color","black");
                $("#alarm").children().attr("src","image/bell.svg"); 
                $(".distrubMode").css("display","none");
                $(".mainAlarm").css("display","none");
                e.preventDefault();
                e.stopPropagation();
            });
            $("#chattingFileBtn").click(function(e){
            	var chatting_room_id = $(this).parents().parents().parents().find("#chatting_room_name").attr("chatting_room_id");
            	$("#chattingFiles").html(""); 	
            	$.ajax({
            		type: 'get',
		       		url: 'ChattingFileServlet',
		       		data : {"chatting_room_id": chatting_room_id },
		       		datatype: "json",
		       		success: function(data) {
		       			$.each(data,function(index,item){
							var files =
								"<div class='chattingFile' file_id='"+item.file_id+"'>" +
										"<div style='float:left;'>" +
				                    		"<img src='image/file.svg' class='"+item.file_picture+"'/>" +
				                		"</div>" +
				                		"<div style='float:left;'>" +
				                		"<a href='image/upload/"+item.file_name+"' download>" +
					                    	"<p class='fileInformation'><b>"+item.file_name+"</b></p>" +
				                		"</a>" +
				                    		"<p class='fileInformation'><span>"+item.file_date+"</span><span> "+item.name+"</span></p>" +
				                		"</div>" +
				                		"<div style='float:right'>" +
				                    		"<img src='image/upload/"+item.picture+"' style='width:20px; margin-top:3px; margin-right: 5px; border-radius: 35px; filter: brightness(0) saturate(100%) invert(0%) sepia(0%) saturate(7500%) hue-rotate(288deg) brightness(94%) contrast(108%); width:20px;'/>" +
				                		"</div>" +
			            		"</div>";
			            	$("#chattingFiles").append(files);
						});
		       		},
		       		error: function(r,s,e) {
		       			
		       		}
            	});
                $(this).parent().parent().parent().parent().parent().parent().find("#messengerFiles").animate({width:"toggle"},500);;
                e.preventDefault();
                e.stopPropagation();
            })
            $("#chattingLinkBtn").click(function(e){
            	var chatting_room_id = $(this).parents().parents().parents().find("#chatting_room_name").attr("chatting_room_id");
            	$("#chattingLinks").html("");  	
            	$.ajax({
            		type: 'get',
		       		url: 'ChattingLinkServlet',
		       		data : {"chatting_room_id": chatting_room_id },
		       		datatype: "json",
		       		success: function(data) {
		       			$.each(data,function(index,item){
							var links =
								"<div class='chattingLink' link_id='"+item.link_id+"'>" +
			                		"<div style='float:left;'>" +
			                    		"<img src='image/upload/"+item.link_picture+"' style='width:30px'/>" +
			                		"</div>" +
			                		"<div style='float:left;'>" +
			                    		"<p class='fileInformation'><b>"+item.link_title+"</b></p>" +
			                    		"<p class='fileInformation'>"+item.link_explanation+"</p>" +
			                    		"<a target='_blank' class='fileInformation' style='text-decoration: none; display: block;' href='"+item.link_name+"' >"+item.link_name+"</a>" +
			                    		"<p class='fileInformation'><span>"+item.link_date+"</span><span> "+item.name+"</span></p>" +
			                		"</div>" +
			                		"<div style='float:right'>" +
			                    		"<img src='image/upload/"+item.picture+"' style='width:20px; margin-top:3px; margin-right: 5px; border-radius: 35px; filter: brightness(0) saturate(100%) invert(0%) sepia(0%) saturate(7500%) hue-rotate(288deg) brightness(94%) contrast(108%); width:20px;'/>" +
			                		"</div>" +
			            		"</div>";
			            	$("#chattingLinks").append(links);
						});
		       		},
		       		error: function(r,s,e) {
		       			
		       		}
            	});
                $(this).parent().parent().parent().parent().parent().parent().find("#messengerLinks").animate({width:"toggle"},500);;
                e.preventDefault();
                e.stopPropagation();
            });
            $("#chattingSearch").keyup(function(key){
                $(this).attr("value",$(this).val());
                var search = $(this).val();
                $(".chatting_room_name").each(function(index, item){
                	if($(item).text().includes(search)){
						$(item).css("display","block");                		
                	} else {
						$(item).css("display","none");
                	}
                });
            });
            $("#chattingFileSearch").keyup(function(key){
                $(this).attr("value",$(this).val());
                var search = $(this).val();
                $(".chattingFile").each(function(index, item){
                	if($(item).text().includes(search)){
						$(item).css("display","block");                		
                	} else {
						$(item).css("display","none");
                	}
                });
            });
            $("#inviteSearchPartner").keyup(function(key){
                $(this).attr("value",$(this).val());
                var search = $(this).val();
                $(".chattingInviteParterList").each(function(index, item){
                	if($(item).text().includes(search)){
						$(item).css("display","block");                		
                	} else {
						$(item).css("display","none");
                	}
                });
            });
            $("#chattingLinkSearch").keyup(function(key){
                $(this).attr("value",$(this).val());
                var search = $(this).val();
                $(".chattingLink").each(function(index, item){
                	if($(item).text().includes(search)){
						$(item).css("display","block");                		
                	} else {
						$(item).css("display","none");
                	}
                });
            });
            $("#inviteSearchPartner").hover(function(e){
            	$(this).css("border","1px solid rgb(158,158,158)");
            	e.preventDefault();
            	e.stopPropagation();
            },function(e){
            	$(this).css("border","1px solid rgb(208,208,208)");
            	e.preventDefault();
            	e.stopPropagation();
            });
            $("#inviteSearchPartner").focus(function(){
            	$("#invitePartnerList").html("");
            	$.ajax({
            		type : 'get',
            		url : 'ChattingInvitePartnerListServlet',
            		data : {"loginId":<%=loginId%>},
            		datatype: "json",
            		success: function(data){
            			$.each(data, function(index, item){
            				var chattingInviteParterList = 
            					"<div class='chattingInviteParterList' member_id='"+item.member_id+"'>" +
		    						"<img src='image/upload/"+item.picture+"'/> "+item.name+" <span>"+item.email+"</span>" +
		    					"</div>";
		    				$("#invitePartnerList").append(chattingInviteParterList);
            			});
            		},
            		error: function(r,s,e){
            			
            		}
            	});
            	$(this).parent().parent().find("#invitePartnerList").css("display","block");
            	$(this).css("outline","2px solid #dfba4c");
            });
            $(document).on("click",".chattingInviteParterList",function(){
				$(this).css("cursor","pointer");
				var member_id = $(this).attr("member_id");
				var nameEmail = $(this).text();
				$("#inviteSearchPartner").val(nameEmail);
				$("#inviteSearchPartner").attr("member_id",member_id);
				$("#invitePartnerList").css("display","none");
            });
 			$(".closeInviteBox").click(function(e){
            	$(this).parent().css("display","none");
            	e.preventDefault();
                e.stopPropagation();
            });
            $("#inviteBtn").click(function(){
            	var member_id = $("#inviteSearchPartner").attr("member_id");
            	var chatting_room_id = $(this).parent().parent().parent().parent().find("#chatting_room_name").attr("chatting_room_id");
            	if(member_id==null){
            		alert("초대할 대상을 선택해주세요");
            	} else {
            		$.ajax({
    					type : 'get',
    					url : 'ChattingInviteMemberServlet',
    					data : {"member_id" : member_id, "chatting_room_id" : chatting_room_id},
    					datatype : "json",
    					success: function(data) {
    						if(data.name==null){
    							alert("이미 채팅방에 있는 사람입니다.");
    						} else {
    							$("#countParticipantsMember").text(data.count);
    							var inviteMember = 	
    								"<div class ='participantBox'>" +
    									"<img src='"+data.picture+"'/> " + data.name +
    								"</div>";
    							var inviteMember2 =
    								"<div>" +
    									"<img class='participantsImg' src='image/upload/"+data.picture+"'>" +
    									"<span style='font-size: 10px; margin: 0px 0px 0px 3px;'>"+data.name+"</span>" +
    								"</div>";
    							$("#chattingParticipantsInformation2").append(inviteMember);
    							$("#chattingparticipantsInformation").append(inviteMember2);
    						}
    					},
    					error: function(r,s,e){
    						
    					}
                	});
            	}
            });
            $("#inviteBtn").hover(function(){
            	$(this).css("background-color","rgb(179,142,34)")
            },function(){
            	$(this).css("background-color","rgb(217,173,43)")
            })
            $(".inviteChattingMemberBtn").click(function(e){
            	$(this).parent().parent().parent().find(".inviteChattingRoom").css("display","block");
            	e.preventDefault();
                e.stopPropagation();
            });
            $("#chattingFile").change(function(){
    			$("#loginIdInput").val(<%=loginId%>);
    			var chatting_room_id = $(this).parent().parent().parent().find("#chatting_room_name").attr("chatting_room_id");
    			$("#chattingRoomIdInput").val(chatting_room_id);
    			webSocket.send("file"); 
            	$("#fileUpload").submit();
    		});
            $("#invietBtn").click(function(){
				$("#new_chatting_room").css("display","block");
            });
            $(".button_x_ncr").click(function(){
            	$("#new_chatting_room").css("display","none");
            });
            //////////////////////////////////////////////////////////////////////////////////////////////
            $("#nc").click(function () {
				$(".ncr_search").css('display', 'block');	
			});

	        //멤버선택
 	        $(document).on("click",".ncr_search>ul>div>li", function(){ 
	            var name = $(this).find(".nc_select_name").text();
	            var email = $(this).find(".nc_select_email").text();  
	            var select_member_id = $(this).parent().find(".member_id_nc_modal").text();
				var img = $(this).parent().find(".picture_nc_modal").css("background-image");
	            $(".ncr_search").css('display', 'none');
	            $(this).parent().detach();
	            var setPickedMember = "<div class='selected_nc' email='"+email+"'><div class='picture_nc_modal' style='"+img+"' ></div><span style='margin-left: 35px;'>"+name+"</span><div class='member_id_picked_nc' style='display: none;' value='"+select_member_id+"'></div></div>";
	            $(".nc_people").append(setPickedMember);
	            

	        }); 
	        
	        //멤버해제
	        $(document).on("click",".selected_nc", function(){
	        	var name = $(this).find("span").text();
	            var email = $(this).attr("email");  
	            var member_id = $(this).find(".member_id_picked_nc").attr("value");
	            var img = $(this).find(".picture_nc_modal").css('background-image');
	            $(this).detach();
	            var setPickedMember = "<div><div class='picture_nc_modal' style='background-image:"+img+"'></div><div class='member_id_nc_modal' style='display: none'>"+member_id+"</div><li><span style='color: black;'class='nc_select_name'>"+name+"</span><span class='nc_select_email'>"+email+"</span></li></div>";
	            $(".ncr_search ul").append(setPickedMember);

	        });	
	        
	        $(".ncr_btn").click(function() {
	        	var nc_list_str = "";
	        	var chattingRoom_id;
	        	$(".selected_nc > .member_id_picked_nc").each(function(index, item) {
		        	var member_id = $(item).attr('value');
		        	nc_list_str += member_id + "_";
	        	});

	        	$.ajax({
	        		type: 'post',
	        		url: 'Controller',
	        		data: {'command' : 'NewChattingRoomInsert', 'list' : nc_list_str},
	        		datatype: 'json',
	        		success: function(d){
	        			alert(d.nc_id);
	        		},
	        		error: function(r,s,e){
	        			alert("에러");
	        		}
	        	});
	        });
	        
            $(".ncr_input").keyup(function(key){
                $(this).attr("value",$(this).val());
                var search = $(this).val();
                $(".nc_select_name").each(function(index, item){
                	if($(item).text().includes(search)){
						$(item).parent().parent().css("display","block");                		
                	} else {
						$(item).parent().parent().css("display","none");
                	}
                });
            });
        });
    </script>
  	<style>
  		companyColleague, #externalPartner, #chattingPartner {
    		padding: 5px 0 0 0;
    	}
    	.chattingInviteParterList {
    		display:none;
    	}
    	.pptx {
        	filter: brightness(0) saturate(100%) invert(27%) sepia(86%) saturate(1088%) hue-rotate(346deg) brightness(106%) contrast(105%); 
        } 
        .xlsx {
        	filter: brightness(0) saturate(100%) invert(30%) sepia(14%) saturate(1966%) hue-rotate(77deg) brightness(98%) contrast(86%);
        }
        .zip {
        	filter: brightness(0) saturate(100%) invert(21%) sepia(57%) saturate(867%) hue-rotate(238deg) brightness(91%) contrast(92%);
        }
        .docx {
        	filter: brightness(0) saturate(100%) invert(31%) sepia(7%) saturate(3352%) hue-rotate(160deg) brightness(94%) contrast(92%);
        }
        .pdf {
        	filter: brightness(0) saturate(100%) invert(10%) sepia(88%) saturate(5623%) hue-rotate(343deg) brightness(71%) contrast(114%);
        }
        .etc {
        	filter: brightness(0) saturate(100%) invert(62%) sepia(3%) saturate(12%) hue-rotate(47deg) brightness(85%) contrast(91%);
        }
        .img {
        	filter: brightness(0) saturate(100%) invert(42%) sepia(100%) saturate(809%) hue-rotate(360deg) brightness(105%) contrast(107%);
        }
    	.messageProfile {
    		border-radius:35px;
    	}
    	.Cname, .chattingMessage{
    		padding:0px 5px;
    	}
        body{
            margin:0px;
            padding: 0px;
        }
        #right {
            width:236px;
            height:418px;
            margin: 0px;
           	display:none;
           	background-color: #393731;
        }
        #top {
            width:236px;
            margin: 0px;
            height: 45px;
            padding-top: 10px;
        }
        #bottom {
            margin-top: 10px;
            width:236px;
            height:315px;
            padding: 27px 0px 0px 0px;
            overflow:auto;
        }
        #bottom::-webkit-scrollbar {
            width: 5px;
        }
        #bottom::-webkit-scrollbar-track {
            background-color: #393731;
            border-radius: 5px;
           
        }
        #bottom::-webkit-scrollbar-thumb {
            background-color: gray;
            border-radius: 5px;
        }
        #alarm {
            width: 20px;
            height: 20px;
            padding: 0px;
            margin: 0px 0px 0px 35px;
            border:none;
            background-color: #393731;
            float:right; 
            margin-right: 10px;
        }
        .title {
            color: gray;
            font-size: 12px;
            margin-bottom: 0px;
        }
        .chatting_title {
            margin-left: 8px;
            margin-bottom: 8px;
        }
        .chatting_room_name {
            margin:0px;
            padding: 2px 5px 2px 5px;
            color:white;
            cursor: pointer;
            border-radius: 5px;
            font-size:12px;
        }
        .chatting_partner {
            margin:0 0 0 0;
            padding: 0px;
            color:white;
            cursor: pointer;
            font-size:12px;
        }
        #chatting_top {
            position:fixed;
            width: 400px;
            height: 40px;
            border-bottom: 1px solid gray; 
            z-index: 1;
        }
        #chatting_middle {
            width: 400px;
            height: 470px;
            padding: 0;
            overflow:auto;
        }
        #chatting_middle::-webkit-scrollbar {
            width: 5px;
        }
        #chatting_middle::-webkit-scrollbar-track{
            background-color: white;
            border-radius: 5px;
        }
        #chatting_middle::-webkit-scrollbar-thumb{
            background-color: gray;
            border-radius: 5px;
        }
        #chatting_bottom {
            width:400px;
            height: 70px;
            position: fixed;
        }
        .chatting_name {
            float:left;
            margin-top: 3px;
        }
        #down_button {
            filter: brightness(0) saturate(100%) invert(0%) sepia(1%) saturate(5580%) hue-rotate(332deg) brightness(95%) contrast(92%);
        }
        #documentwrite {
            margin-top: 6px; 
            background-color: rgb(217,173,43);
            text-align: center;
            border-radius: 4px;
            border: 1px solid rgba(255, 255, 255, 0.2); 
            width: 75px;
            height: 25px;
        }
        .file_link_img {
            width:20px; 
            height: 20px; 
            vertical-align: bottom; 
            filter: brightness(0) saturate(100%) invert(54%) sepia(0%) saturate(0%) hue-rotate(51deg) brightness(98%) contrast(97%);
        }
        #chattingFileBtn {
            margin-right: -4px;
        }
        #chattingFileBtn #chattingLinkBtn {
            border-radius: 5px;
        }
        .message {
            margin-left: 2px;
            margin-top: 10px;
            font-size: 12px;
            clear: both;
            width:393px;
            height:40px; 
        }
        .documentWriteClickAfterBanner {
       		padding: 5px;
       		display:none;
       	}
       	.documentWriteClickAfterBanner > span {
       		font-size : 12px;
       	}
        #chattingRoomInformation{
            margin-left: 60px;
            height:120px;
            width:180px;
            border-radius: 5px;
            border: 1px solid gray;
            background-color: white;
            font-size: 12px;
            display: none;
        }
        #participants {
            overflow: auto;
            width:180px; 
            height:57px; 
            border-radius: 10px;
        }
        #participants::-webkit-scrollbar{
            width: 2px;
        }
        #participants::-webkit-scrollbar-thumb{
            border-radius: 2px;
            background-color: black;
        }
        #participants::-webkit-scrollbar-track{
            border-radius: 2px;
        }
        #alarmSetting {
            margin-left: 180px;
            margin-top:-30px;
            font-size:10px; 
            border-radius: 5px; 
            border: 1px solid gray; 
            width:130px; 
            background-color: white;
            display: none;
        }
        #alarmBtn {
            border: none; font-size:10px; margin:0px; padding:0px; border-radius: 5px; 
            background-color: white; height:30px;
        }
        #make_chatting_room {
            border: none; 
            background-color:#393731; 
            margin-left: 130px;
        }
        .mainAlarm {
            padding:5px 10px 5px 10px;
            width:190px; 
            height:auto; 
            border:1px solid gray; 
            border-radius:5px;
            display: none;
        }
        #chattingOnOff {
            border: 1px solid black; 
            width:400px; height:600px; 
            margin: 0px; padding: 0px; 
            border-radius: 4px;
            display: none;
        }
        #make_chatting_room > img {
       		width:18px; background-color: #393731; vertical-align: bottom;
       	}
       	#down_button {
       		width:18px; vertical-align: bottom;
       	}
       	.participantsImg {
       		width:15px; margin-left: 10px; border-radius: 35px; border:1px solid gray; vertical-align: top;
       	}
       	#participants > p {
       		margin-left: 10px; font-size: 10px; margin-bottom: 2px;
       	}
       	.closeInviteBox > img {
       		filter: brightness(0) saturate(100%) invert(0%) sepia(0%) saturate(7500%) hue-rotate(288deg) brightness(94%) contrast(108%);
       	} 
       	.xbutton > img {
       		filter: brightness(0) saturate(100%) invert(0%) sepia(50%) saturate(4692%) hue-rotate(129deg) brightness(99%) contrast(96%);
       	}
       	.xBtn {
       		width:20px; height:20px; padding: 0px; float: right; margin-right:15px; margin-top: 2px; border:none; background-color: white;
       	}
       	.xBtn > img {
       		filter: brightness(0) saturate(100%) invert(0%) sepia(0%) saturate(7500%) hue-rotate(288deg) brightness(94%) contrast(108%); width:20px;
       	}
       	#messagerFiles > input {
       		margin-left:20px; margin-top: 10px; width: 250px;
       	}
       	.chattingFile > div > img {
       		width:30px
       	}
       	.chattingFile > a {
       		text-decoration: none;
       	}
       	.messageFileA {
       		text-decoration:none;
       		color:black;
       	}
       	.fileInformation > b {
       		color:black;
       	}
        .mainAlarmBtn {
            width: 200px;
            margin-top: 5px;
            font-size: 12px;
            background-color: white;
            border: none;
            text-align: left;
        }
        #xbutton {
            width: 20px; 
            height:20px; 
            margin-left: 378px; 
            margin-top: 2px; 
            margin-bottom: 2px; 
            padding: 0px;
        }
        .xbutton {
        	float: right;
        	width: 20px; 
            height:20px; 
            margin-left: 375px; 
            margin-top: 2px; 
            margin-bottom: 2px; 
            padding: 0px;
            margin-top: -16px;
  			border: none;
    		background-color: white;
        }
        #chattingRoomInformationBtn {
            height:30px; text-align: center; border: none; background-color: white;
        }
        #chattingFiles {
            width:300px;
            height: 532px;
            border-radius: 5px; 
            margin-top: 5px;
            overflow: auto;
        }
        #chattingFiles::-webkit-scrollbar {
            width: 1px;
        }
        #chattingFiles::-webkit-scrollbar-thumb {
            border-radius: 5px;
            background-color: #393731;
        }
        #chattingFiles::-webkit-scrollbar-track {
            border-radius: 5px;
            background-color: white;
        }
        .chattingFile {
            width:270px;
            height: 45px;
            border-bottom: 1px solid rgb(142,142,142);
            padding: 10px 10px 0px 19px;
            margin-bottom: 1px;
        }
        .fileInformation {
            width: 205px;
            padding: 0px;
            margin: 0px;
            font-size: 11px;
            margin-left: 5px;
            height:15px;
            white-space: nowrap;
            overflow: hidden;   
            text-overflow: ellipsis;
            -webkit-line-clamp: 1;
        }
        .chattingLink > div > a {
        	color:rgb(2,135,207);
        }
        #messengerFiles {
            float: left; 
            width:300px; 
            height:600px; 
            border:1px solid black; 
            border-radius:5px;
            display: none;
            position: absolute;
    		top: 17%;
    		left: 33.9%;
        }
        #messengerFiles > input {
        	margin-left: 20px;
    		width: 265px;
    		margin-top: 5px;
        }
        #messengerLinks {
            float: left; 
            width:300px; 
            height:600px; 
            border:1px solid black; 
            border-radius:5px;
            display: none;
            position: absolute;
    		top: 17%;
    		left: 49.6%;
        }
        #chattingLinks {
            width:300px;
            height: 532px;
            border-radius: 5px; 
            margin-top: 5px;
            overflow: auto;
        }
        #chattingLinks::-webkit-scrollbar {
            width: 1px;
        }
        #chattingLinks::-webkit-scrollbar-thumb {
            border-radius: 5px;
            background-color: #393731;
        }
        #chattingLinks::-webkit-scrollbar-track {
            border-radius: 5px;
            background-color: white;
        }
        .chattingLink {
            width:270px;
            height: 70px;
            border-bottom: 1px solid rgb(142,142,142);
            padding: 10px 10px 0px 19px;
            margin-bottom: 1px;
        }
        .chattingProfileImg {
            width:15px;
            vertical-align: bottom;
            border-radius: 35px;
        }
        .chattingMemberPicture {
            width:20px; 
            float: left; 
            border-radius: 35px; 
            height: 20px;
        }
        #alarmOn {
			width:130px; font-size: 10px; border: none; background-color:white; border-radius: 5px; margin-top: 5px; color:#d9ad2b
		}
		#alarmOn > img {
			width:15px;  vertical-align: top;
		}
		#alarmOff {
			width:130px; font-size: 10px; text-align: left; border: none; background-color:white; border-radius: 5px;
		}
		#alarmOff > img {
			width: 17px; margin-left: 3px; vertical-align: top; margin-top: -5px;
		}
		#alarmSetting > p {
			margin-top:5px; margin-left: 10px; margin-bottom: 0px;
		}
		#documentwrite > span {
			color:white; font-size: 12px;
		}
		.message > div {
			float:left;
		}
		.message > div > img {
			width:30px; height:30px; filter: brightness(0) saturate(100%) invert(54%) sepia(0%) saturate(0%) hue-rotate(51deg) brightness(98%) contrast(97%);
		}
		.chattingDateTime {
			text-align: center; font-size: 10px;
		}
		.chattingDateTime > span {
			border: 1px solid rgb(245,245,245); background-color:rgb(245,245,245); border-radius:10px; padding: 0px 5px 0px 5px;
		}
		#chatting_bottom > input {
			margin: -32px 16px 16px 27px ; width:360px; height:30px; font-size: 12px; border-radius: 5px;
		}
		.inviteChattingRoom{
	    	border: 1px solid black;
	    	width:400px;
	    	height:500px;
			margin-left: 180px;
			background-color: white;
			border-radius:5px;
			padding: 10px 15px;		
			overflow:auto;
			display:none;
    	}
    	.inviteChattingRoom::-webkit-scrollbar {
    		width:1px;
    	}
    	.inviteChattingRoom::-webkit-scrollbar-trace {
    		border-radius: 5px;
      		background-color: #white;
    	}
    	.inviteChattingRoom::-webkit-scrollbar-thumb {
    		border-radius: 5px;
      		background-color: #393731;
    	}
    	.inviteChattingRoom h2 {
    		margin-top:0px;
    	}
    	.inviteChattingRoom p {
    		color:gray;
    	}
    	#inviteSearchPartner {
    		width:300px; height:20px; border-radius:5px; border: 1px solid rgb(208,208,208);
    	}
    	#inviteBtn {
    		color:white; background-color:rgb(217,173,43); border-radius:5px; width:75px; height:27px; border:none; font-size: 12px; margin-left:5px;
    	}
    	#invitePartnerList {
    		width: 284px; height: 100px; border: 1px solid rgb(208,208,208); border-radius:5px; padding:0px 10px 10px 10px;
    		overflow: auto;
    		display:none;
    	}
    	#invitePartnerList > div > img {
    		border-radius: 35px;
    	}
    	#invitePartnerList::-webkit-scrollbar{
    		width: 1px
    	}
    	#invitePartnerList::-webkit-scrollbar-thumb{
    		border-radius: 5px;
      		background-color: #393731;
    	}
    	#invitePartnerList::-webkit-scrollbar-trace{
    		border-radius: 5px;
      		background-color: #white;
    	}
    	#invitePartnerList > div {
    		padding: 5px; border-radius:5px; width:260px; margin: 5px 10px 0px 0px;
    	}
    	#invitePartnerList > div > img {
    		width:10px; height:10px;
    	}
    	#invitePartnerList > div > span {
    		color:gray;
    	}
    	.participantBox {
    		float:left; padding: 5px; background-color:rgb(245,245,245); border-radius:5px; width:180px; margin: 10px 10px 0px 0px;
    	}
    	.participantBox > img {
    		width:10px; height:10px; border-radius: 35px;
    	}
    	.closeInviteBox {
    		width: 20px; 
            height:20px; 
            margin-left: 378px; 
            margin-top: 2px; 
            margin-bottom: 2px; 
            padding: 0px;
            border:none;
            background-color:white;
    	}
    	.inviteChattingMemberBtn {
       		margin-top:1px; height:30px; width:180px; padding-top: 0px; padding-bottom: 0px; text-align:left; background-color:white; border:none; border-radius:5px;
       	}
       	#chatting_bottom > button {
       		width: 359px;
       		height: 25px;
			margin-left: 20px;
			color: white;
			background-color: rgb(217, 173, 43);
			border:none;
			border-radius:5px;
			font-size: 12px;
			margin-top: 10px;
       	}
       	#documentWriteBtn {
       		display: none;
       		margin-top:20px;
       	}
       	#chattingSearch {
       		width:210px; height: 25px; font-size:12px; background-color: #393731; color:white; border: 0.5px solid gray; border-radius: 3px;
       	}
       	
       	.filter-active {
       		filter: brightness(0) saturate(100%) invert(83%) sepia(67%) saturate(2404%) hue-rotate(331deg) brightness(89%) contrast(92%) !important;
       	}
       	#chattingFile {
       		display:none;
       	}
       	#chatting_bottom > form > label > img {
       		width:24px;
       		margin : 12px 0px 0px 2px;
       	}
       	.messageFile {
            width: 200px;
            height: 25px;
          	border: 2px solid gray;
          	border-radius: 5px;
          	padding: 5px;
          	margin-bottom:5px;
        }
        .messageFile > img {
          	width:25px;
          	float:left;
        }
        .fileName {
        	margin: 2px 0px 0px 2px;
        }
        .messageFile > span {
          	float:left;
          	width: 170px;
          	white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
        }
        .messageLink {
          	width: 200px;
          	height: 35px;
          	border: 2px solid gray;
          	border-radius: 5px;
          	margin-bottom:5px;
        }
        .linkImgBox > img {
          	width:35px;
        }
        .linkImgBox {
          	float:left;
          	border-radius:5px;
          	width: 35px;
          	height: 35px;
        }
        .linkContent {
          	width:155px;
          	height:35px;
          	float:left;
          	border-left:1px solid gray;
        }
        a {
        	text-decoration : none;
        	color:blue;
        }
        .chattingLinkA {
        	color: rgb(2,135,207);
        	display:block;
        	margin-left:5px;
        	width:200px;
        	white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
        }
        .linkContent > p {
          	margin:2px 0px -3px 2px;
          	width:150px;
          	white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
        }
        #loginIdInput, #chattingRoomIdInput {
        	display:none;
        }
        #invietBtn {
        	float:right;
        	margin-right: 15px;
        	border: none;
        	background-color: rgb(57,55,49); 
        	width:18px;
        	height:18px;
        	padding:0px;
        	margin-top: -2px;
        }
        #invietBtn > img {
        	filter: brightness(0) saturate(100%) invert(54%) sepia(5%) saturate(5%) hue-rotate(324deg) brightness(92%) contrast(82%);
        	width:18px;
        }
        
        /* body, *{
            font-family: -apple-system,BlinkMacSystemFont,Malgun Gothic,Hiragino Kaku Gothic ProN,Hiragino Sans,Meiryo,MS PGothic,sans-serif,Dotum;
            box-sizing: border-box;
            margin:0;
            padding:0;
            outline: none;
        } */
        .overlay{
        	z-index: 1;
        	position:fixed;
            width:100%;
            height:100%;
            background-color:rgba(0, 0, 0, 0.5);
            display:flex;
            align-items: center;
            justify-content: center;
            transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;
        }
        .new_chatting_room_container{
        	width: 600px;
		    padding: 20px 32px 32px;
		    display: flex;
		    flex-direction: column;
		    min-height: 440px;
		    height: 680px;
		    
		    background-color: #fff;
		    flex: 0 1 auto;
		    max-height: calc(100% - 96px);
		    margin: 48px;
		    display: flex;
		    position: relative;
		    /* overflow-y: auto; */
		    border-radius: 4px;
		    box-shadow: 0px 11px 15px -7px rgb(0 0 0 / 20%), 0px 24px 38px 3px rgb(0 0 0 / 14%), 0px 9px 46px 8px rgb(0 0 0 / 12%);
        }
        .new_cr_header{
        	display: flex;
		    flex-direction: row;
		    -webkit-box-pack: justify;
		    justify-content: space-between;
		    align-items: flex-start;
		    margin-bottom: 20px;
		    flex: 0 0 64px;
        }
        .header_for_resetPW{
        	margin-bottom: 40px;
		    color: rgb(136, 136, 136);
		    flex: 0 1 auto;
        }
        .h2_for_resetPW{
        	font-size: 22px;
		    line-height: 1.36;
		    color: rgb(34, 34, 34);
		    font-weight: bold;
		    margin-bottom: 8px;
        }
        .span_for_resetPW{
        	font-size: 15px;
		    line-height: 1.47;
		    color: rgb(136, 136, 136);
        }
        .button_x_ncr{
        	position: absolute;
		    top: 12px;
		    right: 12px;
		    padding-left: 0px;
		    padding-right: 0px;
		    transition: fill 0.2s ease 0s;
		    cursor: pointer;
		    pointer-events: auto;
		    width: auto;
		    background-color: transparent;
		    text-decoration: none;
        }
        .button_x{
        	transition: fill 0.2s ease 0s;
    		fill: rgb(136, 136, 136);
        }
        .button_x_ncr:hover{
    		background-color: rgba(0, 0, 0, 0.05);
    		border-radius: 6px;
		}
		.ncr_input{
			width: 430px;
    		height: 42px;
			border: 1px solid rgb(189, 189, 189);
			border-radius: 4px; 
			padding-left: 10px;
		} 
		.ncr_input:focus{
         	box-shadow: rgb(217 173 43) 0px 0px 0px 1px inset, rgb(217 173 43 / 20%) 0px 0px 0px 4px;
         	border-color: #fcba03;
         }
         .ncr_input:placeholder{
         	color: rgb(189, 189, 189);
         }

		.ncr_btn{
			border-width: 1px;
		    border-style: solid;
		    border-color: rgb(217, 173, 43);
		    background-color: rgb(217, 173, 43);
		    opacity: 0.6;
		    box-shadow: none;
		    height: 42px;
		    font-weight: bold;
		    font-size: 14px;
		    border-radius: 6px;
		    position: relative;
		    min-height: inherit;
		    color: rgb(255, 255, 255);
		    text-align: center;
		    padding: 5px 18px;
		    transition: background-color 0.2s ease 0s, color 0.2s ease 0s, border-color 0.4s ease 0s, fill 0.2s ease 0s, opacity 0.2s ease 0s;
		
			margin-left: 6px;
		}
		.ncr_btn:hover{
			background-color: rgb(179, 142, 34);
    		border-color: rgb(179, 142, 34);
		}
		.ncr_search{
			display: none;
			width: 430px;
			
			border: 1px solid rgb(189, 189, 189);
			border-radius: 4px; 
			padding: 10px;
			box-shadow: rgb(0 0 0 / 10%) 0px 4px 10px 2px;
			margin-top: 5px;
			font-size: 15px;
			color: rgb(136, 136, 136);
			
			position: absolute;
			top: 189px;
    		background-color: white;
		}
		.nc_people{
			border-radius: 4px; 
			border: 1px solid rgb(189, 189, 189);
			padding: 10px;
			background-color: 1px solid rgb(189, 189, 189);
			margin-top: 10px;
			height: 450px;
		}
		#new_chatting_room {
			display:none;
		}
		.picture_nc_modal{
            width: 20px;
            height:20px;
            border-radius:50%;
            background-color:rgb(255, 255, 255);
            content:"";
            background-size:cover;
            position:absolute;
            margin-top:5px;
		}
        .ncr_search ul{
            list-style: none;
            padding-top: 12px;
            padding-left: 16px;
        }
        .ncr_search li{
        	margin-left: 30px;
        	cursor: pointer;
        }
        .selected_nc{
            display: flex;
            height: 32px;
            margin: 8px 4px 0px 0px;
            padding: 5px 10px 5px 13px;
            border: 1px solid rgb(224, 221, 217);
            border-radius: 18px;
            background-color: rgb(255, 255, 255);
            font-size: 15px;
            -webkit-box-align: center;
            align-items: center;
            box-sizing: border-box;
            cursor:pointer;
            width: fit-content;
        }
	html {
	    position: relative;
	    min-height: 100%;
	    -webkit-tap-highlight-color: transparent;
	    overflow-x :  hidden;
	}
	html::-webkit-scrollbar {
		width:4px;
	}
	html::-webkit-scrollbar-thumb {
	    height: 70%; /* 스크롤바의 길이 */
	    background-color: #e1e1e1; /* 스크롤바의 색상 */
	    border-radius: 2px;
	}
	html::-webkit-scrollbar-track{
		background-color: white;
	}
	body, html {
    	height: 100%;
    	font-family: -apple-system,BlinkMacSystemFont,Malgun Gothic,Hiragino Kaku Gothic ProN,Hiragino Sans,Meiryo,MS PGothic,sans-serif,Dotum;
		margin: 0px;
	}
	ul {
    	list-style-type: none;
	}
	a{
		text-decoration: none;
	}
	button{
		border: none;
	}
	.home_layout{
		display: flex;
	    flex-direction: row;
	    width: 100vw;
	    height: 100vh;
	    background-color: rgb(255, 255, 255);
	}
	.home_sidebar{
		z-index: 1;
		position: relative;
	    width: 240px;
	    background-color: rgb(247, 246, 245);
	    flex: 0 0 auto;
	    display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	    padding-top: 72px;
	    overflow-y: auto;
	    /* margin-left: -10px;
	    margin-top: -10px; */
	}
	.left-bar{
		/* position: fixed; */
		position: relative;
	    overflow-y: auto;
	    flex: 1 1 auto;
	    overflow-x: hidden;
	}
	.left-bar::-webkit-scrollbar {
		width:4px;
	}
	.left-bar::-webkit-scrollbar-thumb {
	    height: 70%; /* 스크롤바의 길이 */
	    background: #e1e1e1; /* 스크롤바의 색상 */
	    border-radius: 2px;
	}
	.home_top-row{
		position: relative;
	    display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	}
	.home_header{
		display: flex;
	    flex-direction: row;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    -webkit-box-align: center;
	    align-items: center;
	    padding: 0px 14px 0px 20px;
	    flex: 0 1 auto;
	    height: 72px;
	    top: 0px;
	    z-index: 9;
	    background-color: rgb(247, 246, 245);
	    width: 205px;
	    position: fixed;
	}
	.collabee{
		min-width: inherit;
	    min-height: inherit;
	    padding-left: 0px;
	    padding-right: 0px;
	    transition: fill 0.2s ease 0s;
	    cursor: pointer;
	    pointer-events: auto;
	    width: auto;
	    background-color: transparent;
	    color: yellow;
	}
	.alarm{
		padding-bottom: 4px;
		min-width: inherit;
	    min-height: inherit;
	    padding-left: 0px;
	    padding-right: 0px;
	    transition: fill 0.2s ease 0s;
	    cursor: pointer;
	    pointer-events: auto;
	    width: auto;
	    background-color: transparent;
	    text-decoration: none;
	    border: none;
	    box-sizing: border-box;
	    font-size: 12px;
	    outline: 0;
	    z-index:10;
	}
	.alarm_svg{
		display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: gray;
	}
	.alarm_svg:hover{
		fill: #616060;
	}
	.left-navigation{
		display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	    padding-bottom: 22px;
	}
	.home_h2{
		margin: 0px;
	    padding-left: 20px;
	    padding-bottom: 2px;
	    font-size: 13px;
	    line-height: 1.54;
	    font-weight: normal;
	    color: rgb(136, 136, 136);
	}
	.home_svg1{
		display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(136, 136, 136);
	}
	.fill_black{
		fill: rgb(34, 34, 34);
	}
	.menu{
		background-color: rgba(0, 0, 0, 0.05);
		cursor: pointer;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    background-color: transparent;
	    padding-left: 18px;
	    padding-right: 16px;
	    position: relative;
	    pointer-events: auto;
	}
	.menu:hover{
		background-color: #e3e3e3;
	}
	.chosen{
		background-color: #e3e3e3;
	}
	.name{
		padding: 3px 0px;
	    margin-left: 4px;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    font-size: 14px;
	    line-height: 1.57;
	    color: rgb(34, 34, 34);
	}
	.f_name{
		padding: 3px 0px;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    font-size: 13px;
	    color: rgb(136, 136, 136);
	}
	.bold{
		font-weight: bold;
	}
	.home_svg2{
		display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(34, 34, 34);
	    opacity:0;
	}
	.home_btn1{
		display: inline-block;
		background-color: transparent;
		position: absolute;
	    top: 50%;
	    right: 16px;
	    width: 20px;
	    height: 20px;
	    transform: translate(0px, -50%);
	}
	.menu > .home_btn1:hover{
		background-color: #c7c5c5;
		border-radius: 4px;
	}
	.beta{
		display: inline-block;
	    margin-left: 4px;
	    color: #a3a3a3;
	    font-size: 12px;
	    vertical-align: middle;
	}
	.private{
		display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	    padding-bottom: 22px;
	}
	.new_workspace{
		margin: 6px 16px 8px;
	    font-weight: bold;
	    font-size: 14px;
	    line-height: 1.57;
	    padding: 5px;
	    position: relative;
	    min-height: inherit;
	    color: rgb(255, 255, 255);
	    border-radius: 4px;
	    text-align: center;
	    transition: background-color 0.2s ease 0s, color 0.2s ease 0s, border-color 0.4s ease 0s, fill 0.2s ease 0s, opacity 0.2s ease 0s;
	    border-width: 1px;
	    border-style: solid;
	    border-color: rgb(51, 132, 108);
	    background-color: rgb(51, 132, 108);
	    cursor: pointer;
	    opacity: 1;
	    width: auto;
	    box-shadow: none;
	}
	.new_workspace:hover{
		background-color: rgb(44, 111, 91);
    	border-color: rgb(44, 111, 91);
	}
	.w_search{
		box-sizing: border-box;
	    border: 1px solid rgb(193, 193, 193);
	    border-radius: 4px;
	    font-size: 13px;
	    color: rgb(34, 34, 34);
	    line-height: 1.54;
	    width: 100%;
	    padding: 4px 24px 4px 26px;
	}
	.w_search:hover{
		border: 1px solid black;
	}
	.createFolder{
		display: flex;
	    flex-direction: column;
	    padding-left: 16px;
	    padding-right: 16px;
	}
	.home_btn2{
		position: relative;
	    cursor: pointer;
	    background-color: transparent;
	}
	.home_btn2::before{
		position: absolute;
	    right: 0px;
	    left: 0px;
	    height: 1px;
	    background-color: rgb(230, 230, 230);
	    content: " ";
	    top: 50%;
	}
	.contents{
		position: relative;
	    display: inline-flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    background-color: rgb(247, 246, 245);
	    font-size: 12px;
	    color: rgb(136, 136, 136);
	    padding: 5px 4px;
	}
	.home_svg3{
		margin-right: 4px;
		display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(193, 193, 193);
	}
	.folder1{
		flex: 1 0 auto;
	    width: 100%;
	    box-sizing: border-box;
	    min-width: 0px;
	}
	.f_container{
		position: relative;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    margin-top: 0px;
	    margin-bottom: 0px;
	    user-select: none;
	    padding: 0px 0px 0px 4px;
	    cursor: pointer;
	    background-color: transparent;
	}
	.f_container:hover{
		background-color: #e3e3e3;
	}
	.home_svg4{
		visibility: hidden;
	    flex-shrink: 0;
	    margin-right: 2px;
	    display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(193, 193, 193);
	}
	.f_container2{
		flex: 1 0 auto;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    margin-left: 0px;
	    width: 0px;
    }
    .f_container3{
	    display: flex;
	    flex: 1 0 auto;
	    width: 100%;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    padding-right: 16px;
    }
    .home_svg5{
	    display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(136, 136, 136);
    }
    .f_container4{
	    display: flex;
	    flex: 1 0 auto;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    padding: 2px 0px;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    font-size: 13px
	    color: rgb(136, 136, 136)
    }
    .home_btn3{
	    min-width: inherit;
	    min-height: inherit;
	    padding-left: 0px;
	    padding-right: 0px;
	    transition: fill 0.2s ease 0s;
	    cursor: pointer;
	    pointer-events: auto;
	    width: auto;
	    background-color: transparent;
	    text-decoration: none;
	    font-weight: 400;
	    color: gray;
    }
    .w_list{
	    flex: 1 0 auto;
	    width: 100%;
	    box-sizing: border-box;
	    min-width: 0px;
	    margin-left: 10px;
	    margin-top: -5px;
    }
    .sidebar-footer{
	    display: flex;
	    flex-direction: column;
	    color: rgb(136, 136, 136);
	    font-size: 12px;
	    line-height: 1.5;
	    padding-top: 40px;
	    padding-left: 20px;
	    padding-bottom: 90px;
    }
    .alarm_expl{
		position: absolute;
		z-index: 101;	
		display: none;	
		outline: none;
	    width: 236px;
    	background-color: rgb(255, 255, 255);
	    height: 220px;
	    box-shadow: 0px 5px 5px -3px rgb(0 0 0 / 20%), 0px 8px 10px 1px rgb(0 0 0 / 14%), 0px 3px 14px 2px rgb(0 0 0 / 12%);
	}
	.home_h6{
		all: unset;
	    display: block;
	    font-size: 12px;
	    line-height: 1.5;
	    color: rgb(136, 136, 136);
	    padding: 12px 0px 4px 18px;
	}
	.alarm_expl2{
		display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	    padding-top: 0px;
	    padding-bottom: 12px;
	}
	.alarm_btn1{
		font-size: 13px;
	    font-weight: normal;
	    color: rgb(34, 34, 34);
	    text-align: left;
	    position: relative;
	    line-height: 1.5;
	    border-radius: 3px;
	    padding: 5px 18px;
	    background-color: transparent;
	    cursor: pointer;
	    border: none;
	}
	.alarm_btn1:hover{
		background-color: rgb(242, 242, 242);
    	border-color: rgb(242, 242, 242);
	}
	.alarm_expl3{
		display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	    border-top: 1px solid rgb(225, 225, 225);
	    padding: 12px 0px;
	}
	.alarm_expl4{
		position: relative;
		color: rgb(34, 34, 34);
	    font-size: 12px;
	    font-weight: 500;
	    line-height: 1.5;
	    padding: 5px 18px;
	    cursor: pointer;
	}
	.alarm_expl4:hover{
		background-color: rgb(242, 242, 242);
    	border-color: rgb(242, 242, 242);
	}
	.folder_namebox{
		display: none;
		position: relative;
	    padding: 2px 8px;
	    width: 100%;
	    font-size: 13px;
	    line-height: 1.54;
	    color: rgb(34, 34, 34);
	    background-color: rgb(255, 255, 255);
	    box-shadow: rgb(51 132 108) 0px 0px 0px 1px inset;
	    border: 4px solid rgba(51, 132, 108, 0.2);
	    border-radius: 8px;
	    box-sizing: border-box;
	}
	.folder_namebox:focus{
		outline: none;
	}
	.div_background{
		display: none;
		z-index: 9;
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom : 0;
		width: 100%;
		height: 100%;
		background-color: transparent;
	}
	.home_svg22{
		transition: fill 0.2s ease 0s;
    	fill: rgb(163, 163, 163);
	}
	.calendar_button{
    	background-color: rgba(0, 0, 0, 0.05);
		cursor: pointer;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    background-color: transparent;
	    padding-right: 16px;
	    padding-left: 0px;
	    position: relative;
	    font-size: 14px;
	    line-height: 1.57;
	    color: rgb(34, 34, 34);
	    pointer-events: auto;
	    width: 100%;
	}
	.calendar_button:hover{
		background-color: #e3e3e3;
    }
    .calendar2{
	    cursor: pointer;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    background-color: transparent;
	    padding-left: 18px;
	    padding-right: 16px;
    }
	
	input[type="checkbox"]{
        display: none;
	}
	input[type="checkbox"] + label{
		display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    width: 10px;
        height: 10px;
        border: 1px solid black;
        cursor: pointer;
        border-radius: 2px;
	}
	.folder_selection0{
		display: none;
		position: absolute;
		z-index: 101;
	}
	.folder_selection{
		border-radius: 4px;
	    box-shadow: rgb(0 0 0 / 10%) 0px 0px 6px 2px;
	    background-color: rgb(255, 255, 255);
	    padding: 12px 0px;
	    min-width: 160px;
	    max-width: 100%;
	    display: flex;
	    flex-direction: column;
	}
	.folder_selection_btn1{
		cursor: pointer;
	    font-size: 13px;
	    line-height: 1.54;
	    color: rgb(34, 34, 34);
	    padding: 5px 18px 3px;
	    background-color: transparent;
	    text-align: left;
	}
	.folder_selection_btn1:hover{
		background-color: rgb(242, 242, 242);
	}
	.hidden{
		display: none;
	}
	</style>
	<script>
	$(function(){
		$('.calendar_button').click(function (){
			alert("준비 중입니다.");
		/* 	$('.calendar_selection').css('display','block'); */
		}); 
		$('.menu').click(function(){
			var idx = $(this).index();
			//alert(idx);
			if(idx==5){
				alert("준비 중입니다.");
			}
		});
	
	
		$('.home_btn2').click(function (){
			if($('.folder_namebox').css('display')=='none') {
				$('.folder_namebox').css('display','block');
				$('.folder_namebox').focus();
			} else {
				$('.folder_namebox').css('display','none');
			}
		});
	
		$('.folder_namebox').focusout(function (e){
			$('.folder_namebox').css('display','none');
		});
		
		$('.f_container').mouseenter(function(){
	      	$(this).find('.home_svg2').css('opacity', '1');
	      	$(this).find('.home_svg4').css('visibility', 'visible');
	    });
	      $('.f_container').mouseleave(function(){
	      	$(this).find('.home_svg2').css('opacity', '0');
	      	$(this).find('.home_svg4').css('visibility', 'hidden');
	    });
	      
		$('.menu').mouseenter(function(){
			$(this).find('.home_svg2').css('opacity', '1');
		});
		$('.menu').mouseleave(function(){
			$(this).find('.home_svg2').css('opacity', '0');
		});
		
		$('.home_btn2').mouseenter(function(){
			$(this).children("span").css('color', 'rgb(0,0,0)');
			$(this).find('.home_svg3').css('fill', 'rgb(0,0,0)');
		});
		$('.home_btn2').mouseleave(function(){
			$(this).children("span").css('color', 'rgb(136,136,136)');
			$(this).find('.home_svg3').css('fill', 'rgb(136,136,136)');
		});
		
		$('.f_container4').click(function(){
        	$(this).parent().parent().next('.w_list').toggleClass("hidden");
        	if($(this).parent().parent().next('.w_list').hasClass("hidden")===true){
        		$(this).find('.home_svg22').css('transform', 'scaleY(-1)');
        	}else{
        		$(this).find('.home_svg22').css('transform', 'scaleY(1)');
        	}
        });
		
		$('.folder1').sortable({
   			revert:true,
   			axis : 'y',
   			cursor: "grabbing",
   			update: function(event, ui){
   				var arrWorkspaceId = new Array();
   				$('.f_container').each(function(index){
   					var workspaceId = $(this).attr('workspaceId');
   					arrWorkspaceId.push(workspaceId);
   				});
   				alert(arrWorkspaceId);
   				$.ajax({
   					type: "post",
   					url: 'WorkspaceOrderServlet',
   					traditional : true,
   					data : {
   						'main' : arrWorkspaceId
   					},
   					datatype: "json",
   					success: function(data){
   						//alert("success");
   					},
   					error: function(r,e,s){
   						alert("error!!!");
   					}
   				});
   			}
       	});
       	
       	$('.w_list').sortable({
   			revert:true,
   			cursor: "grabbing"
       	});
		
       	$(document).ready(function() {
			$("#calendar-total").click(function() {
				if($("#calendar-total").is(":checked")) $("input[name=cld]").prop("checked", true);
				else $("input[name=cld]").prop("checked", false);
			});
			
			$("input[name=cld]").click(function() {
				var total = $("input[name=cld]").length;
				var checked = $("input[name=cld]:checked").length;
				
				if(total != checked) $("#calendar-total").prop("checked", false);
				else $("#calendar-total").prop("checked", true); 
			});
		});
		
       	$('.alarm').click(function (){
        	var px = $(this).offset().left;
        	var py = $(this).offset().top + 30;
        	if($('.alarm_expl').css('display')=='none') {
        		$('.alarm_expl').css('display','block');
        		$('.alarm_expl').css('left',px+'px');
            	$('.alarm_expl').css('top',py+'px');
        		$('.div_background').css('display', 'block');
        	} else {
        		$('.alarm_expl').css('display','none');
        		$('.div_background').css('display', 'none');
        	}
       });
		
		
		/* $('.home_svg2').click(function (){
        	var px = $(this).offset().left;
        	var py = $(this).offset().top + 10;
        	$('.folder_selection0').css('left',px+'px');
        	$('.folder_selection0').css('top',py+'px');
        	$('.div_background').css('display', 'block');
			$('.folder_selection0').css('display', 'block');
       }); */
		
       	$('.div_background').click(function() {
        	$('.div_background').css('display', 'none');
      		if($('.home_option').css('display')!='none'){
       			$('.home_option').css('display','none');
      		}else if($('.alarm_expl').css('display')!='none'){
      			$('.alarm_expl').css('display','none');
      		}else if($('.folder_selection0').css('display')!='none'){
      			$('.folder_selection0').css('display','none');
      		}
      	});
		
		
		
		
	});
	
	</script>
</head>
<body style="overflow-x: hidden;">
	<div class="div_background"></div>
	<!--<div class="folder_selection0">
		<div class="folder_selection">
			<button class="folder_selection_btn1">폴더이름 변경</button>
			<button class="folder_selection_btn1">폴더 제거</button>
		</div>
	</div>-->
	<div class="alarm_expl0">
		<div class="alarm_expl">
			<h6 class="home_h6">방해금지 모드</h6>
			<div class="alarm_expl2">
				<button class="alarm_btn1">1시간 동안 알림 끄기</button>
				<button class="alarm_btn1">2시간 동안 알림 끄기</button>
				<button class="alarm_btn1">4시간 동안 알림 끄기</button>
				<button class="alarm_btn1">아침까지 알림 끄기 (오전 9시)</button>
			</div>
			<div class="alarm_expl3">
				<a class="alarm_expl4" href="">알림 설정</a>
			</div>
		</div>
	</div>
	
	<div class="home_layout">
	<nav class="home_sidebar">
	<div class="left-bar">
		<div class="home_top-row">
			<header class="home_header">
				<a class="collabee" href="">
					<svg xmlns="http://www.w3.org/2000/svg" width="112" height="27" viewBox="0 0 800 188" version="1.1"><title>Collabee</title><g id="collabee" stroke="none" stroke-width="1" fill="#d9ad2b" fill-rule="evenodd"><g id="collabee_logo" transform="translate(-2199.000000, -306.000000)" fill="#d9ad2b"><g id="Group-2" transform="translate(1900.000000, 0.000000)"><path d="M394.31736,411.192678 L417.772183,434.563735 C431.409272,448.147302 431.409272,470.20286 417.772183,483.79636 C404.271464,497.265165 382.447985,497.399853 368.790516,484.200424 L368.37917,483.79636 L330.119875,445.663888 C335.495266,451.009544 355.591986,449.437092 369.215732,436.194694 L369.62657,435.789832 L394.31736,411.192678 Z M958.789528,358 C972.762337,358 983.522145,361.558521 990.919865,368.785622 C998.141831,375.841021 1001.80953,385.861327 1001.99287,398.676013 L1002,400.068742 L1001.96144,404.945938 L1001.93,407.761854 C1000.22947,407.918136 997.711771,408.003156 994.376916,408.016913 C994.020503,408.018384 993.490522,408.019787 992.809816,408.021116 L992.333934,408.021991 C991.919175,408.022711 991.459464,408.023407 990.958717,408.024078 L990.338374,408.024872 C990.018605,408.025262 989.684627,408.025644 989.337286,408.026016 L988.625039,408.026747 C988.503445,408.026867 988.380429,408.026986 988.256022,408.027103 L987.287029,408.027973 C986.789723,408.028398 986.273584,408.028807 985.740315,408.029199 L984.651445,408.029961 C984.096097,408.03033 983.524756,408.030683 982.939128,408.031019 L981.141092,408.031971 L980.833804,408.032119 L980.833804,408.032119 L979.267568,408.032815 C979.055584,408.032903 978.842391,408.032988 978.628053,408.033071 L976.005067,408.03397 L975.670671,408.034068 L975.670671,408.034068 L971.917492,408.034921 C971.686564,408.03496 971.455123,408.034997 971.223231,408.035031 L961.392174,408.035042 L961.044317,408.034987 L961.044317,408.034987 L957.274365,408.034114 C957.049716,408.034046 956.825879,408.033976 956.602919,408.033902 L954.621625,408.033164 C954.404488,408.033073 954.188416,408.032979 953.973472,408.032883 L952.697858,408.03227 C952.487681,408.032162 952.278758,408.032051 952.071154,408.031937 L950.841848,408.031218 C950.639768,408.031093 950.439133,408.030964 950.240004,408.030832 L949.063829,408.030005 C948.225368,408.029379 947.417791,408.028694 946.646288,408.027951 L945.738132,408.027029 C943.364331,408.024495 941.381196,408.021342 939.958826,408.01751 C940.022181,411.542318 941.702566,415.234262 945.378473,417.846532 C949.05438,420.458802 955.681971,423.549841 963.527798,423.549841 C971.79489,423.549841 978.541852,422.700011 983.495419,421.057128 C987.517595,419.723146 991.333122,417.875032 994.604438,415.78136 L994.604859,434.581126 C992.937836,435.593133 990.896711,436.632681 988.415131,437.615306 C982.727235,439.867528 973.650163,442 964.823689,442 C955.997215,442 946.949276,440.787809 939.956585,437.934714 C932.805324,435.019982 924.735595,430.268372 920.456361,424.131336 C916.13993,417.937166 914,410.275826 914,401.224578 C914,387.29112 917.91971,376.500379 925.832175,369.054325 C933.690649,361.656092 944.723719,358 958.789528,358 Z M1055.78953,358 C1069.76234,358 1080.52214,361.558521 1087.91987,368.785622 C1095.14183,375.841021 1098.80953,385.861327 1098.99287,398.676013 L1099,400.068742 L1098.96144,404.945938 L1098.93,407.761854 C1097.22947,407.918136 1094.71177,408.003156 1091.37692,408.016913 C1091.0205,408.018384 1090.49052,408.019787 1089.80982,408.021116 L1089.33393,408.021991 C1088.91918,408.022711 1088.45946,408.023407 1087.95872,408.024078 L1087.33837,408.024872 C1087.0186,408.025262 1086.68463,408.025644 1086.33729,408.026016 L1085.62504,408.026747 C1085.50344,408.026867 1085.38043,408.026986 1085.25602,408.027103 L1084.28703,408.027973 C1083.78972,408.028398 1083.27358,408.028807 1082.74032,408.029199 L1081.65145,408.029961 C1081.0961,408.03033 1080.52476,408.030683 1079.93913,408.031019 L1078.14109,408.031971 L1077.8338,408.032119 L1077.8338,408.032119 L1076.26757,408.032815 C1076.05558,408.032903 1075.84239,408.032988 1075.62805,408.033071 L1073.00507,408.03397 L1072.67067,408.034068 L1072.67067,408.034068 L1068.91749,408.034921 C1068.68656,408.03496 1068.45512,408.034997 1068.22323,408.035031 L1058.39217,408.035042 L1058.04432,408.034987 L1058.04432,408.034987 L1054.27436,408.034114 C1054.04972,408.034046 1053.82588,408.033976 1053.60292,408.033902 L1051.62163,408.033164 C1051.40449,408.033073 1051.18842,408.032979 1050.97347,408.032883 L1049.69786,408.03227 C1049.48768,408.032162 1049.27876,408.032051 1049.07115,408.031937 L1047.84185,408.031218 C1047.63977,408.031093 1047.43913,408.030964 1047.24,408.030832 L1046.06383,408.030005 C1045.22537,408.029379 1044.41779,408.028694 1043.64629,408.027951 L1042.73813,408.027029 C1040.36433,408.024495 1038.3812,408.021342 1036.95883,408.01751 C1037.02218,411.542318 1038.70257,415.234262 1042.37847,417.846532 C1046.05438,420.458802 1052.68197,423.549841 1060.5278,423.549841 C1068.79489,423.549841 1075.54185,422.700011 1080.49542,421.057128 C1084.5176,419.723146 1088.33312,417.875032 1091.60444,415.78136 L1091.60486,434.581126 C1089.93784,435.593133 1087.89671,436.632681 1085.41513,437.615306 C1079.72724,439.867528 1070.65016,442 1061.82369,442 C1052.99721,442 1043.94928,440.787809 1036.95658,437.934714 C1029.80532,435.019982 1021.7356,430.268372 1017.45636,424.131336 C1013.13993,417.937166 1011,410.275826 1011,401.224578 C1011,387.29112 1014.91971,376.500379 1022.83217,369.054325 C1030.69065,361.656092 1041.72372,358 1055.78953,358 Z M838.290203,339 L838.288276,364.559952 L838.874395,364.200045 C840.805068,363.047969 842.879018,362.056406 845.094001,361.225292 L846.213235,360.823106 L847.211798,360.493128 C852.484469,358.819822 858.1,357.986006 864.051579,357.986006 C872.040986,357.986006 879.237636,359.764568 885.596484,363.331581 C891.978042,366.911333 896.994379,371.918 900.601213,378.309028 C904.20455,384.691148 906,391.986392 906,400.145571 C906,408.407933 904.204349,415.730693 900.596169,422.066232 C896.982907,428.414924 891.956395,433.348879 885.56268,436.824953 C879.210543,440.278422 872.026156,442 864.051579,442 C857.452369,442 851.716345,441.105452 846.845706,439.291702 C844.125935,438.278902 841.469434,436.907542 838.876688,435.181457 L837.907397,434.517556 L837.67136,434.348687 L837.673112,440 L813,440 L813,339 L838.290203,339 Z M762.228768,358 C768.80678,358 774.46643,358.553722 779.221413,359.675087 C784.113902,360.828069 788.200743,362.628219 791.455785,365.098567 C794.807784,367.640016 797.267738,370.936354 798.799986,374.933093 C800.176231,378.524376 800.899942,382.674684 800.99032,387.379044 L801,388.3956 L801,440 L777.861413,440 L777.860877,435.320792 L777.635758,435.452876 C775.666824,436.569192 773.38088,437.646087 770.700931,438.769555 L768.811734,439.543783 C764.46089,441.287981 759.601097,442 753.495282,442 L752.592885,441.997228 L750.886471,441.974001 C746.775313,441.88472 743.780251,441.552583 740.878265,440.781092 C736.936723,439.730138 733.491796,438.155705 730.557742,436.047153 C727.54528,433.882252 725.189409,431.176574 723.520106,427.955626 C721.832818,424.706444 721,420.961464 721,416.758128 C721,412.16806 722.068588,408.100907 724.221479,404.624065 C726.358833,401.169663 729.512016,398.350325 733.622011,396.16964 C737.587969,394.063845 742.441623,392.530495 748.185852,391.546555 C753.438778,390.646303 759.448905,390.168984 766.222007,390.109343 L767.685066,390.102953 L777.860877,390.101587 C777.846597,388.254385 777.766522,386.926757 777.62065,386.118702 C777.401843,384.906619 776.724942,383.398904 775.734159,382.604347 C774.743376,381.80979 773.569277,380.944377 770.72613,380.108291 C767.882982,379.272205 764.183274,378.804101 760.581054,378.804101 C756.978833,378.804101 753.975156,379.163396 750.67578,379.828022 C747.376403,380.492649 741.086683,382.580122 737.826344,384.157673 C735.652785,385.209373 733.210043,386.483274 730.498119,387.979376 L730.671609,364.934662 L733.286091,363.818251 L734.956755,363.130281 C737.445056,362.127557 739.825941,361.270624 741.724334,360.751904 C744.696726,359.939318 747.920628,359.279204 751.392657,358.771412 C754.89907,358.256896 758.511398,358 762.228768,358 Z M588.5,358 C597.610493,358 605.669636,359.69868 612.647815,363.118631 C619.702382,366.574517 625.214658,371.493118 629.130086,377.844946 C633.047866,384.199054 635,391.605065 635,399.99929 C635,408.593202 633.050102,416.100867 629.130423,422.459592 C625.208498,428.823499 619.683812,433.697719 612.614904,437.049071 C605.643787,440.357006 597.596467,442 588.5,442 C579.402293,442 571.354932,440.357074 564.384361,437.049399 C557.314972,433.69709 551.789438,428.822464 547.86832,422.459866 C543.949029,416.10177 542,408.594492 542,399.99929 C542,391.610492 543.92197,384.211023 547.781185,377.861805 C551.645398,371.500283 557.166612,366.574052 564.280213,363.114792 C571.308748,359.697636 579.390814,358 588.5,358 Z M500.553774,358 C512.585353,358 522.324314,360.376937 529.730212,365.206167 L529.730212,365.206167 L531.074122,366.082503 L531.074122,388.82923 L526.480214,385.601196 C520.326242,381.276942 512.374029,379.088557 502.558661,379.088557 C495.284852,379.088557 489.649129,380.847617 485.539475,384.300802 C481.59592,387.613225 479.585103,392.81295 479.585103,400.152543 C479.585103,407.383052 481.589492,412.501074 485.524958,415.76371 C489.640828,419.175906 495.178592,420.910024 502.249563,420.910024 C512.088664,420.910024 520.479358,418.611616 527.488589,414.034986 L527.488589,414.034986 L532,411.089291 L532,433.444216 L530.673368,434.322722 C526.690844,436.95998 522.199726,438.902023 517.211096,440.152056 C512.289594,441.38751 506.634353,442 500.246093,442 C491.206971,442 483.209197,440.38481 476.278951,437.133978 C469.244953,433.835194 463.745563,429.012495 459.842262,422.699464 C455.939479,416.387864 454,408.849911 454,400.152543 C454,391.450095 455.966396,383.885836 459.92296,377.522331 C463.874769,371.168944 469.39152,366.30028 476.4148,362.950823 C483.351217,359.642002 491.404005,358 500.553774,358 Z M711,340 L711,440 L686,440 L686,340 L711,340 Z M670,340 L670,440 L645,440 L645,340 L670,340 Z M358.420773,375.75774 L358.833922,376.161635 L383.624733,400.750275 L358.82392,425.368716 C345.146822,438.957959 322.947972,438.957959 309.270875,425.368716 C308.413555,424.534289 307.604818,423.641679 306.856092,422.720687 C295.633785,409.051975 296.431092,388.898003 309.270875,376.161635 C322.811201,362.69845 344.703697,362.563818 358.420773,375.75774 Z M778.333972,408.349946 C768.823424,408.38309 763.359884,408.415179 761.943351,408.44621 C759.818553,408.492758 757.893421,408.587913 754.811182,408.865258 C751.728944,409.142603 749.677839,410.020133 748.343937,410.775791 C747.124181,411.467238 746.304537,412.234192 745.820058,413.074348 C745.325469,413.930449 745.073302,414.932391 745.073302,416.135196 C745.073302,417.685936 746.1287,419.532685 748.288273,420.757862 C750.447845,421.983038 755.803965,422.516663 758.786797,422.516663 C761.769629,422.516663 766.469926,421.989625 769.204071,421.257959 C773.020038,420.236794 776.583297,418.794412 778.333972,416.466924 C778.332917,415.876062 778.332143,415.250361 778.331651,414.589821 L778.331651,410.801898 C778.332143,410.01942 778.332917,409.202103 778.333972,408.349946 Z M588.5,379.088557 C582.009111,379.088557 577.054758,380.925901 573.455067,384.568556 C569.857391,388.209193 568.036369,393.293225 568.036369,399.99929 C568.036369,406.299164 569.880852,411.296503 573.569425,415.160536 C577.225727,418.991988 582.136817,420.910024 588.5,420.910024 C594.861917,420.910024 599.772936,418.991895 603.429819,415.159835 C607.118291,411.297208 608.962205,406.300568 608.962205,399.99929 C608.962205,393.293225 607.141184,388.209193 603.543513,384.568562 C599.943901,380.925988 594.989625,379.088557 588.5,379.088557 Z M859.268059,379.078076 C854.295377,379.078076 849.909008,380.409416 846.030089,383.082175 C842.402497,385.581389 839.874744,388.818682 838.39086,392.862086 L838.288276,393.152711 L838.288276,406.957272 L838.388732,407.22812 C839.865266,411.048981 842.215777,414.133058 845.479572,416.534212 L846.102246,416.976439 C849.928629,419.59891 854.290038,420.90651 859.268059,420.90651 C865.528284,420.90651 870.558258,418.990059 874.519234,415.147837 C878.448305,411.336527 880.400542,406.401972 880.400542,400.145571 C880.400542,393.879473 878.440983,388.881828 874.49504,384.966287 C870.534613,381.035141 865.514934,379.078076 859.268059,379.078076 Z M958.86933,377.259139 C952.409234,377.259139 948.172734,378.737559 944.69436,381.979409 C942.101016,384.397342 940.616183,386.901255 940.027711,390.130031 L939.925487,390.754586 L977.510593,390.754586 L977.495877,390.609769 C977.050768,387.132523 975.780586,384.530721 973.513413,382.163422 L973.12629,381.770933 C970.114377,378.802492 965.413394,377.259139 958.86933,377.259139 Z M1055.86933,377.259139 C1049.40923,377.259139 1045.17273,378.737559 1041.69436,381.979409 C1039.10102,384.397342 1037.61618,386.901255 1037.02771,390.130031 L1036.92549,390.754586 L1074.51059,390.754586 L1074.49588,390.609769 C1074.05077,387.132523 1072.78059,384.530721 1070.51341,382.163422 L1070.12629,381.770933 C1067.11438,378.802492 1062.41339,377.259139 1055.86933,377.259139 Z M417.775041,316.198674 C431.402128,329.803527 431.41213,351.839217 417.775041,365.434137 L394.310216,388.806613 L369.627998,364.198106 C355.999482,350.593253 335.549563,348.914464 330.119875,354.343918 L368.380599,316.187321 C382.017689,302.602335 404.127949,302.602335 417.775041,316.198674 Z" id="Combined-Shape"></path></g></g></g></svg>
				</a>
				<button title="알림설정" class="alarm">
				<svg viewBox="0 0 24 24" width="22px" height="22px" class="alarm_svg"><path d="M11.65 21c.99 0 1.8-.81 1.8-1.8h-3.6c0 .99.81 1.8 1.8 1.8zm5.85-5.4v-4.95A5.848 5.848 0 0 0 13 4.962V4.35C13 3.603 12.397 3 11.65 3c-.747 0-1.35.603-1.35 1.35v.612a5.848 5.848 0 0 0-4.5 5.688v4.95L4 17.4v.9h15.3v-.9l-1.8-1.8z" color="#888888" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
				</button>
			</header>
	<!-- 골라진 거 menu클라스 옆에 chosen 클래스 붙이면 선택된 것처럼 나옴  name에는 bold를 붙이고-->		
			<div class="left-navigation">
				<h2 class="home_h2">전체 정보</h2>
				<a class="menu" href="Controller?command=Home">
					<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg1 fill_black"><path d="M12 3l9 7.412V21h-6.75v-7.412h-4.5V21H3V10.412L12 3z"></path></svg>
					<div class="name bold">홈</div>
					<button class="home_btn1" name="HOME">
						<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg2"><path d="M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
					</button>
				</a>
				
				<a class="menu" href="Controller?command=updatebar1">
					<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg1"><path d="M1 18v3h3c0-1.66-1.34-3-3-3zm0-4v2c2.76 0 5 2.24 5 5h2c0-3.87-3.13-7-7-7zm18-7H5v1.63c3.96 1.28 7.09 4.41 8.37 8.37H19V7zM1 10v2a9 9 0 0 1 9 9h2c0-6.08-4.93-11-11-11zm20-7H3c-1.1 0-2 .9-2 2v3h2V5h18v14h-7v2h7c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
					<div class="name">업데이트</div>
					<button class="home_btn1" name="ISSUE">
						<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg2"><path d="M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
					</button>
				</a>
				
				<a class="menu" href="">
					<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg1"><path d="M17 3H7c-1.1 0-1.99.9-1.99 2L5 21l7-3 7 3V5c0-1.1-.9-2-2-2z"></path></svg>
					<div class="name">북마크</div>
				</a>
				
				<a class="menu" href="MyPostCmt.jsp">
					<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg1"><path d="M2 12c0 5.52 4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2C6.47 2 2 6.48 2 12zm10 8.2c-4.53 0-8.2-3.67-8.2-8.2 0-4.53 3.67-8.2 8.2-8.2 4.53 0 8.2 3.67 8.2 8.2 0 4.53-3.67 8.2-8.2 8.2zm-2.588-7c.616 1.122 1.287 1.676 2.588 1.676 1.3 0 1.972-.554 2.588-1.676H16.5c-.703 1.933-2.452 3.3-4.5 3.3s-3.797-1.367-4.5-3.3zM8.65 8.4a1.35 1.35 0 110 2.7 1.35 1.35 0 010-2.7zm6.7 0a1.35 1.35 0 110 2.7 1.35 1.35 0 010-2.7z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
					<div class="name">내가 작성한 문서</div>
				</a>
				
				<a class="menu">
					<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg1"><path d="M22,16 L22,20 L14,20 C12.8954305,20 12,19.1045695 12,18 C12,16.8954305 12.8954305,16 14,16 L22,16 Z M17,10 C18.1045695,10 19,10.8954305 19,12 C19,13.1045695 18.1045695,14 17,14 L7,14 C5.8954305,14 5,13.1045695 5,12 C5,10.8954305 5.8954305,10 7,10 L17,10 Z M10,4 C11.1045695,4 12,4.8954305 12,6 C12,7.1045695 11.1045695,8 10,8 L2,8 L2,4 L10,4 Z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
					<div class="name">간트차트<span class="beta">Beta</span>
					</div>
				</a>
				
				<div class="menu">
					<button class="calendar_button"> 
					<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg1"><path d="M17 12h-5v5h5v-5zM16 1v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2h-1V1h-2zm3 18H5V8h14v11z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
					<div class="name">전체 캘린더</div>
					</button>
				</div>
				<button id="slide_chat_up" class="menu">
					<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg1"><path d="M2,11.0015412 C2,13.1876518 2.97777778,15.2766019 4.75555556,16.8311695 C4.91111111,16.9769102 5.06666667,17.0983608 5.22222222,17.2198114 L5.05263158,21.5 L9.26666667,19.1387307 C10.1555556,19.3573417 11.0666667,19.4545022 12,19.4545022 C17.5111111,19.4545022 22,15.6652438 22,10.9772511 C22,6.31354849 17.5111111,2.5 12,2.5 C6.48888889,2.5 2,6.31354849 2,11.0015412 Z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
					<div class="name">메신저</div>
				</button>
				<div id="right">
			        <div id="top">
			            <div style=" margin-bottom: 0px; padding-bottom:0px; margin:10px 0px;">
			             	<p style="margin:0px 0px 0px 13px; color:white;">
			             		<span id="chattingMainName">
				             		<%
				             			ChattingDao chattingDao = new ChattingDao();
				             			String chattinMainName = chattingDao.getChattingMainName(loginId);
				             			
				             			PartnerDao partnerDao = new PartnerDao();
				             		%>
				             		<%=chattinMainName%> 
			             		</span>
				                <button id="alarm"><img src="image/bell.svg"/></button>
			             	</p>
			            </div>
			            <div style="margin-top:0px; width:236px; margin-left: 13px; margin-bottom:10px;">
			            	<input id="chattingSearch" type="search" placeholder="대화방, 파트너 검색"/>
			            </div>
			        </div>
			        <div id="bottom">
			            <div id="workspaceM" class="chatting_title">
			                <div class="title">협업공간 대화  <button id="invietBtn"><img src="image/+.svg"/></button></div>
			                <div id="workspaceChattingName">
				                <%
				                	ArrayList<ChattingDto> workspaceChattingName = chattingDao.getWorkspaceChattingNameList(loginId);
				                	for(ChattingDto workspaceChattingNameList : workspaceChattingName) {
				                %>
									<div style="padding-right:10px;">
										<p class="chatting_room_name" chatting_room_id="<%=workspaceChattingNameList.getChatting_room_id()%>"><%=workspaceChattingNameList.getChatting_name() %></p>
									</div>                
				                <%
				                	}
				                %>
			                </div>
			            </div>
			            <div id="groupM" class="chatting_title">
			                <div class="title">그룹 대화</div>
			                <div id="groupChattingName">
				                <%
				                	ArrayList<ChattingDto> groupChattingName = chattingDao.getGroupChattingList(loginId);
				                	for(ChattingDto groupChattingNameList : groupChattingName) {
				                %>
									<div style="padding-right:10px;">
										<p class="chatting_room_name" chatting_room_id="<%=groupChattingNameList.getChatting_room_id()%>"><%=groupChattingNameList.getChatting_name() %></p>
									</div>                
				                <%
				                	}
				                %>
			                </div>
			            </div>
			            <%
			            	if(partnerDao.CompanyCheck(loginId)){
			            %>		
			            	<div id="corporationP" class="chatting_title">
			                <div class="title">회사 동료</div>
			                <div id="companyColleague">
				                <%
				               		ArrayList<PartnerDto> partnerList = partnerDao.getCompanyColleague(loginId);
				                	for(PartnerDto commpanyColleague : partnerList) {
				                %>
					            <div class="chatting_partner">
					                <div class="chattingMemberPicture" style="background-image: url(<%=commpanyColleague.getPicture()%>);">
					                	<img class="onOffImg" src="image/bell.svg"/>
					                </div><%=commpanyColleague.getName()%> <%=commpanyColleague.getEmail() %>
					            </div>
					            <div style="clear:both;"></div>
				                <%
				                	}
				                %>
			                </div>
			            </div>
			            <div id ="partner" class="chatting_title">
			                <div id="partnerOrExternalPartner" class="title">외부 협업자</div>
			                <div id="externalPartner">
				                <%
					            	ArrayList<PartnerDto> partnerList2 = partnerDao.getExternalPartner(loginId);
				                	for(PartnerDto externalPartner : partnerList2) {
				                %>
				                <div class="chatting_partner">
				                	<div class="chattingMemberPicture" style="background-image: url(<%=externalPartner.getPicture()%>);">
				                		<img class="onOffImg" src="image/bell.svg"/>
				                	</div><%=externalPartner.getName()%> <%=externalPartner.getEmail()%>
				                </div> 
				                <div style="clear:both;"></div>
				                <% 
				                	}
				                %>
			                </div>
			            </div>
			            <%		
			            	} else {
			            %>		
			            <%
			            	ArrayList<PartnerDto> partnerList3 = partnerDao.getPartner(loginId);
			            %>
			            <div id ="partner" class="chatting_title">
			                <div class="title">파트너</div>
			                <div id="chattingPartner">
					            <%
					               for(PartnerDto partner : partnerList3) {
					            %>
					                <div class="chatting_partner">
					                	<div class="chattingMemberPicture" style="background-image: url(<%=partner.getPicture()%>);">
					                		<img class="onOffImg" src="image/bell.svg"/>
					                	</div><%=partner.getName()%> <%=partner.getEmail()%>
					                </div> 
					                <div style="clear:both;"></div>
					            <% 
					               }
					            %>
					        </div>
					            <%		
					            }
					            %>
			            </div>
			        </div>
   		 		</div>
			</div>
			<div class="private">
				<h2 class="home_h2">개인공간</h2>
				<a class="menu" href="">
					<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg1"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
					<div class="name">프라이빗 공간</div>
				</a>
			</div>
			<button class="new_workspace">새 협업공간 만들기</button>
		</div>
		<div style="margin: 0px 16px 4px;">
			<div style="position: relative;">
				<svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" style="position: absolute; left: 6px; top: 6px;"><path fill="#888888" fill-rule="evenodd" d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"></path></svg>
				<input placeholder="협업공간 검색" class="w_search" value/>
			</div>
		</div>
		
		<div class="createFolder">
			<button type="button" class="home_btn2">
				<span class="contents">
					<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg3"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm5 11h-4v4h-2v-4H7v-2h4V7h2v4h4v2z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
					폴더 추가하기
				</span>
			</button>
			<input class="folder_namebox" type="text" placeholder="새 폴더(예시 : 프로젝트, 마케팅)" maxlength="20"/>
		</div>
	
	<div>
			<div class="folder1">


<%
	for(NoneFolderDto dto : listNone){
%>	
			
				<div class="f_container" workspaceId="<%= dto.getWorkspace_id()%>"> <!-- draggable="true" -->
					<svg viewBox="0 0 24 24" width="12px" height="12px" class="home_svg4"><path d="M8 5.4A2.2 2.2 0 1 1 8 1a2.2 2.2 0 0 1 0 4.4zm0 8.8a2.2 2.2 0 1 1 0-4.4 2.2 2.2 0 0 1 0 4.4zM8 23a2.2 2.2 0 1 1 0-4.4A2.2 2.2 0 0 1 8 23zm8-17.6A2.2 2.2 0 1 1 16 1a2.2 2.2 0 0 1 0 4.4zm0 8.8a2.2 2.2 0 1 1 0-4.4 2.2 2.2 0 0 1 0 4.4zm0 8.8a2.2 2.2 0 1 1 0-4.4 2.2 2.2 0 0 1 0 4.4z" color="#C1C1C1"></path></svg>
					<div class="f_continer2">
						<div class="f_container3">
							<div>
								<svg viewBox="0 0 24 24" width="16px" height="16px" class="home_svg5"><path d="M14.027 5L13.6 3H4v18h2v-7h6l.533 2H20V5z"></path></path></svg>
							</div>
							<div style="margin-top: 5px;" class="name" title="<%= dto.getWorkspace_name() %>"><%= dto.getWorkspace_name() %></div>
						</div>
					</div>
				</div>
				
<%
	}
%>	

			</div>	
			
		</div>
	
	<div class="sidebar-footer">
		<span>
		개인정보 처리방침<br/>
		이용 약관<br/>
		collabee Inc. © 2022
		</span>
	</div>
	</div>
	</nav>
	</div>
	<div style="postion:absolute; top:17%; left:13%; ">
        <div class="mainAlarm">
            <button class="mainAlarmBtn distrubMode" style="display: none">방해금지 모드 해제</button>
            <button class="mainAlarmBtn notDistrubMode">1시간 동안 알림 끄기</button>
            <button class="mainAlarmBtn notDistrubMode">2시간 동안 알림 끄기</button>
            <button class="mainAlarmBtn notDistrubMode">3시간 동안 알림 끄기</button>
            <button class="mainAlarmBtn notDistrubMode">다음날 이 시간까지 알림 끄기</button>
        </div>
        <div id="chattingOnOff">
            <div style="width:400px; height: 25px; border-bottom: 1px solid black;">
                <button id="xbutton">
                    <img src="image/x.svg" style="filter: brightness(0) saturate(100%) invert(0%) sepia(50%) saturate(4692%) hue-rotate(129deg) brightness(99%) contrast(96%);"/>
                </button>
            </div>
            
            <div id="chatting_top">
                <div class="chatting_name">
                        <button id="chattingRoomInformationBtn">
                            <img src="image/+.svg" style="width:18px; vertical-align:bottom"/>
                            <span id="chatting_room_name">방 제목</span>
                            <img id="down_button" src="image/down.svg"/>
                        </button>
                        <div id="chattingRoomInformation">
                            <div style="width:180px; height: 30px; padding:2xp 2px 2px 2px;">
                                <button id="alarmBtn">
                                    <span><img src="image/bell.svg" style="width:15px; margin-top: 0px; vertical-align: bottom; margin-left: 10px;"/></span>
                                    <span> 알 림 : </span>
                                    <span id="alarmText" style="color: #d9ad2b"> 모든 메세지 알림받기</span>
                                    <img src="image/down.svg" style="width:15px; vertical-align:bottom; margin-left:5px; filter: brightness(0) saturate(100%) invert(54%) sepia(0%) saturate(18%) hue-rotate(184deg) brightness(92%) contrast(81%);"/>
                                </button>
                                <div style="width:180px; height: 31px; border-top:1px solid gray; border-bottom: 1px solid rgb(128, 128, 128);">
                                    <button class="inviteChattingMemberBtn">
                                        <img src="image/+.svg" style="width:15px;"/>
                                        <span> 초대</span>
                                    </button>
                                </div>
        
                                <div id="participants">
                                    <p><b>참여자 <span id="countParticipantsMember"></span></b></p>
                                   	<div id="chattingparticipantsInformation">
	                                    <div>
	                                        <img class="participantsImg" src="image/comment.svg"/>
	                                        <span style="font-size: 10px; margin-top: 0px;">강태안</span>
	                                    </div>
                                   	</div>
                                </div>
                            </div>
							<div id="alarmSetting">
                                <p>대화방 알림 설정</p>
                                <button id="alarmOn"><img src="image/bell.svg"/>모든 메시지 알림받기</button>
                                <button id="alarmOff"><img src="image/bellOff.png"/>모든 알람 끄기</button>
                            </div>
						    <div class="inviteChattingRoom">
						    	<button class="closeInviteBox">
                    				<img src="image/x.svg"/>
                				</button>
						    	<h2><b>대화방 초대</b></h2>
						    	<p>대화상대를 선택하여 초대하세요.</p>
						    	<div>
							    	<input id="inviteSearchPartner" type="text" placeholder="이름, 이메일주소 입력"/>
							    	<input id="inviteBtn" type="button" value="초대하기"/>						    	
						    		<div id="invitePartnerList">
						    			<div>
						    				<img src="image/comment.svg"/> 강태안 <span>rkdxodks@naver.com</span>
						    			</div>
						    		</div>
						    	</div>
						    	<div id="chattingParticipantsInformation2">
							    	<div class="participantBox">
							    		<img src="image/comment.svg"/> 강태안
							    	</div>
						    	</div>
						    </div>
                        </div>
                </div>
                <div style="float:right; margin-top: 1px;">
                	<button id="documentwrite"><span>문서 작성</span></button>
                    <div style="float: right; margin-top: 6px; margin-left: 3px; margin-right: 3px;">
                    	<button id="chattingFileBtn"><img src="image/file.svg" class="file_link_img"/></button>
                        <div style="display: none"></div>
                        <button id="chattingLinkBtn"><img src="image/link.svg" class="file_link_img"/></button>
                        <div style="display: none"></div>
                    </div>
                </div>
                <div class="documentWriteClickAfterBanner">
                	<span>대화를 선택하여 문서로 작성해 보세요.</span>
                	<button class="xbutton">
                    	<img src="image/x.svg"/>
                	</button>
                </div>
            </div>
            <div style="width: 400px; height: 40px;"></div>
            <div id="chatting_middle">
                <div class="message">
                    <div>
                        <img class="messageProfile" src="image/bell.svg"/>
                    </div>
                    <div>
                        <div><span>이름</span><span> 시간</span></div>
                        <div>내용</div>
                    </div>
                </div>
                <div class="message">
                    <div>
                        <img class="messageProfile" src="image/bell.svg"/>
                    </div>
                    <div>
                        <div><span>이름</span><span> 시간</span></div>
                        <div class="messageFile">
                			<img src="image/file.svg"/>
                			<span>파일 이름dddd dddddddddddddd ddddddddddddddddddddddddd</span>
                		</div>
                		<div style="clear:both;"></div>
                    </div>
                </div>
                
               	<div class="message">
                    <div>
                        <img class="messageProfile" src="image/bell.svg"/>
                    </div>
                    <div>
                        <div><span>이름</span><span> 시간</span></div>
                        <a>링크</a>
                        <div class="messageLink">
                        	<div class="linkImgBox" style="background-image:url(image/bell.svg);"></div>
                        	<div class="linkContent">
	                			<p>링크제목ddddddddddddddddddddd</p>
								<p>부가설명</p>									                        	
                        	</div>
                		</div>
                		<div style="clear:both;"></div>
                    </div>
                </div>
                <!-- 링크 아이디, 링크 이름, 보낸사람, 시간, -->
                <div class="chattingDateTime">
                    <span><b>2022년 4월 29일</b></span>
                </div>
            </div>
            <div id="chatting_bottom">
            	<form id="fileUpload" action="ChattingFileUploadServlet" method="post" enctype="multipart/form-data">
	            	<label for="chattingFile">
	            		<img src="image/fileIcon.svg"/>
	            	</label>
	                <input type="file" id="chattingFile" name="chattingFile"/>
					<input type="hidden" id="loginIdInput" name="loginId" value=""/>
                	<input type="hidden" id="chattingRoomIdInput" name="chattingRoomId" value=""/>
            	</form>
                <input id="chattingInput" type="text" placeholder="여기에 입력해보세요." name="chattingText" style="float:left;"/>
                <button id="documentWriteBtn">새 문서 작성</button>
 				<%
 					System.out.println(request.getAttribute("fileName"));
 				%>
            </div>
        </div>
    </div>
    <div id="messengerFiles">
        <div style="padding: 10px 0px 0px 20px;">파일 
        	<button class="xBtn">
        		<img src="image/x.svg"/>
        	</button>
        </div>
        <input id="chattingFileSearch" type="search" placeholder="파일명 검색"/>
        <div id="chattingFiles">
            <div class="chattingFile">
                <div style="float:left;">
                    <img src="image/file.svg" style="width:30px"/>
                </div>
                <div style="float:left;">
                    <p class="fileInformation"><b>201202 DBMS</b></p>
                    <p class="fileInformation"><span>5월 31일 오전 11:51</span><span> 강태안</span></p>
                </div>
                <div style="float:right">
                    <img src="image/file.svg" style="width:20px; margin-top:3px; margin-right: 5px; border-radius: 35px; filter: brightness(0) saturate(100%) invert(0%) sepia(0%) saturate(7500%) hue-rotate(288deg) brightness(94%) contrast(108%); width:20px;"/>
                </div>
            </div>
        </div>
    </div>
    <div id="messengerLinks">
        <div style="padding: 10px 0px 0px 20px;">링크 <button class="xBtn" style="width:20px; height:20px; padding: 0px; float: right; margin-right:15px; margin-top: 2px; border:none; background-color: white;"><img src="image/x.svg" style="filter: brightness(0) saturate(100%) invert(0%) sepia(0%) saturate(7500%) hue-rotate(288deg) brightness(94%) contrast(108%); width:20px;"/></button></div>
        <input id="chattingLinkSearch" type="search" placeholder="링크 검색" style="margin-left:20px; margin-top: 10px; width: 250px;"/>
        <div id="chattingLinks">
            <div class="chattingLink">
                <div style="float:left;">
                    <img src="image/file.svg" style="width:30px"/>
                </div>
                <div style="float:left;">
                    <p class="fileInformation"><b>201202 DBMS</b></p>
                    <p class="fileInformation">asdssssssssssssssssssssss ssssssssssssssssss</p>
                    <a class="fileInformation" style="text-decoration: none; display: block;" href="www.naver.com" >www.naver.com</a>
                    <p class="fileInformation"><span>5월 31일 오전 11:51</span><span> 강태안</span></p>
                </div>
                <div style="float:right">
                    <img src="image/file.svg" style="width:20px; margin-top:3px; margin-right: 5px; border-radius: 35px; filter: brightness(0) saturate(100%) invert(0%) sepia(0%) saturate(7500%) hue-rotate(288deg) brightness(94%) contrast(108%); width:20px;"/>
                </div>
            </div>
        </div>
    </div>
 
    <!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
    <div id="new_chatting_room" class="overlay">
		<div>
			<form action="Controller?command=TodoInsert"  method="post">
				<div class="new_chatting_room_container">
					<button class="button_x_ncr" type="button">
						<svg viewBox="0 0 24 24" width="24px" height="24px" style="vertical-align: middle;">
							<path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z" class="button_x"></path>
						</svg>
					</button>
				
					<header class="header_for_resetPW">
						<h2 class="h2_for_resetPW">채팅방 만들기</h2>
						<span class="span_for_resetPW">대화상대를 선택하여 그룹대화를 만들어보세요. 그룹대화는 '나'를 포함하여 최대 8명까지 선택할 수 있습니다.</span>
					</header>
					
					<div>
						<input type="text" id="nc" class="ncr_input" placeholder="이름을 입력하여 검색" />
						<button class="ncr_btn" type="button">대화하기</button>
					</div>
					<div class="ncr_search">
						<ul>
							<%
								ArrayList<PartnerListDto> pL = (ArrayList<PartnerListDto>)request.getAttribute("pL");
								for(int i = 0; i<pL.size(); i++){
							%>
						
								<div>
										<div class="picture_nc_modal" style="background-image:<%=pL.get(i).getPicture() %>"></div>
										<div class="member_id_nc_modal" style="display: none"><%=pL.get(i).getMember_id() %></div>
										<li>
											<span style="color: black;"class="nc_select_name"><%=pL.get(i).getName() %></span>
											<span class="nc_select_email"><%=pL.get(i).getEmail() %></span>
								         </li>
								</div>
							<%
								}
							%>
						</ul>
					</div>
					<div>
						<div class="nc_people">	
							<input type="hidden" class=""/>
							
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	
	
</body>
</html>	 