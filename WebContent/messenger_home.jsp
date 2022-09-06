<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="collabee.Collabee"%>
<%@ page import="com.ta.dto.*" %>
<%@ page import="com.ta.dao.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.jm.dao.*" %>
<%@ page import="com.jm.dto.*" %>
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
    function f1(_this){
	    var chatting_room_id = _this.attr("chatting_room_id");
	    $.ajax({
   			type: 'get',
   			url: 'Controller?command=ChattingMessageAction',
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
		       			       		url: 'Controller?command=ChattingFileMessageAction',
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
									url : 'Controller?command=ChattingLinkMessageAction',
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
   				$('#chatting_middle').scrollTop($('#chatting_middle')[0].scrollHeight);	
   			},
   			error: function(r,s,e){
   				alert("실패222222222222");
   			}
        });  
	}
    	$(function(){
		    var webSocket = new WebSocket("ws://localhost:9090/Collabee/broadcasting");
	       	webSocket.onmessage = function(e) {
				if(e.data=="file"){
					f1($("#chatting_room_name"));
				} else {
		       		var arr = e.data.split(" ");
		       		if($("#chatting_room_name").attr("chatting_room_id")==arr[0]){
			   			$.ajax({
			   				type: 'get',
			   				url:'Controller?command=ChattingContentAction',
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
			       			       		url: 'Controller?command=ChattingFileMessageAction',
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
										url : 'Controller?command=ChattingLinkMessageAction',
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
			   					$('#chatting_middle').scrollTop($('#chatting_middle')[0].scrollHeight);	
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
							url: 'Controller?command=ChattingLinkOrMessageAction',
							data: {"loginId":<%=loginId%>,"message":message,"chattingRoomId":chattingRoomId},
							datatype: 'json',
							success: function(data) {
								webSocket.send(chattingRoomId+" "+data.message_id);
								if(data.link_id>0){
									$.ajax({
										type:'get',
										url : 'Controller?command=ChattingLinkMessageAction',
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
								$('#chatting_middle').scrollTop($('#chatting_middle')[0].scrollHeight);	
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
					url: 'Controller?command=ChattingListAndPartnerAction',
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
			       		url: 'Controller?command=ChattingParticipantsAction',
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
		       		url: 'Controller?command=ChattingFileAction',
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
		       		url: 'Controller?command=ChattingLinkAction',
		       		data : {"chatting_room_id": chatting_room_id },
		       		datatype: "json",
		       		success: function(data) {
		       			$.each(data,function(index,item){
							var links =
								"<div class='chattingLink' link_id='"+item.link_id+"'>" +
			                		"<div style='float:left;'>" +
			                    		"<img class='linkImg'src='"+item.link_picture+"' style='width:30px'/>" +
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
            		url : 'Controller?command=ChattingInvitePartnerListAction',
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
    					url : 'Controller?command=ChattingInviteMemberAction',
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
    	.linkImg {
    		border-radius:5px;
    	}
    	#companyColleague, #externalPartner, #chattingPartner {
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
            float:left;
            width:236px;
            height:400px;
            margin: 0px;
           	display:none;
        }
        #top {
            position:fixed;
            width:236px;
            background-color: #393731;
            margin: 0px;
        }
        #bottom {
            margin-top: 76px;
            float:left;
            width:236px;
            background-color: #393731;
            height:400px;
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
        /* ////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
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
    </style>
</head>
<body>
	<button id="slide_chat_up">채팅</button>
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
    <div style="float: left;">
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
            	<form id="fileUpload" action="Controller?command=ChattingFileUploadAction" method="post" enctype="multipart/form-data">
	            	<label for="chattingFile">
	            		<img src="image/fileIcon.svg"/>
	            	</label>
	                <input type="file" id="chattingFile" name="chattingFile"/>
					<input type="hidden" id="loginIdInput" name="loginId" value=""/>
                	<input type="hidden" id="chattingRoomIdInput" name="chattingRoomId" value=""/>
            	</form>
                <input id="chattingInput" type="text" placeholder="여기에 입력해보세요." name="chattingText" style="float:left;"/>
                <button id="documentWriteBtn">새 문서 작성</button>
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
     <%-- <div id="new_chatting_room" class="overlay">
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
	</div>  --%>
</body>
</html>