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
        $(function(){
            $("#alarmBtn").on("click", function(){ // 알림 펼쳐보기 버튼
                    $("#alarm").slideToggle("fast");
            });
            $("#commpanyColleagueBtn").on("click", function(){ // 회사동료
                    $("#corporationP").slideToggle("fast");
            });
            $("#externalPartnerBtn").on("click", function(){ // 외부협업자
                    $("#partner").slideToggle("fast");
            });
            $(document).on("click",".retryInvite",function(){
                var mail = $(this).parent().children('.mail').text(); 
				$.ajax({
					type: 'get',
					url: 'Controller?command=PartnerInvitationAgainAction',
					data: {"email":mail},
					datatype:'json',
					successs: function(data){
						
					},
					error: function(r,s,e){
						
					}
					
				});
				alert(mail+" 님을 다시 초대 하였습니다.");
            });
            $(".hideBtn").click(function(){
                $(this).parent().parent().parent().css("display","none")
            });
            $("#partnerBtn").click(function(){
                $("#partners").slideToggle("fast");
                $("#alarm").html("");
                $("#corporationP").html("");
                $("#partner").html("");
                $.ajax({
                	type: 'get',
                	url: 'Controller?command=PartnerContentAction',
                	data: {"loginId":<%=loginId%>},
                	datatype: 'json',
                	success: function(data){
                		$.each(data, function(index, item){
                			if(data.length==7){
	                			if(index==0){
	                				$("#countAlarm").text("알림 ("+item.alarm_count+")");
	                			} else if(index==1){
	                				$.each(item, function(index, item1){
	                					var inviteParterList = 
	                						"<div class='partnerAlarm' partner_id='"+item1.parter_id+"'>" +
	                                   			 "<h6>파트너 수락 대기중</h6>" +
	                                   			 "<div>" +
	                                        		"<img src='image/partnerMail.svg'/>" +
	                                        		"<span  class='mail'>"+item1.invite_mail+"</span>" +
			                                        "<button class='inviteCancellationBtn'>초대 취소</button>" +
			                                        "<button class='retryInvite'>다시 초대</button>" +
			                                    "</div>" +
	                                		"</div>";
	                                	$("#alarm").append(inviteParterList);	
	                				});
	                			} else if(index==2) {
	                				$.each(item, function(index, item2){
		                				var inviteMeList = 
		            						"<div class='partnerAlarm' member_id='"+item2.member_id+"'>" +
		                               			 "<h6>파트너 수락 대기중</h6>" +
		                               			 "<div>" +
		                                    		"<img class='partnerImg' src='image/"+item2.picture+"'/>" +
		                                    		"<span  class='mail'>"+item2.name+"</span>" +
		                                    		"<button class='refuseBtn'>거절</button>" +
			                                        "<button class='agreeBtn'>수락</button>" +
			                                    "</div>" +
		                            		"</div>";
		                            	$("#alarm").append(inviteMeList);
	                				});
	                			} else if(index==3){
									$("#countCorporationP").text("회사 동료 ("+item.companyColleague_count+")");
								} else if(index==4){
									$.each(item, function(index, item3){
										var corporationP = 
											"<div class='partnerBox' member_id='"+item3.member_id+"'>" +
					                    		"<div class='partnerPictureBox'>" +
					                        		"<div class='chattingMemberPicture' style='background-image: url('image/"+item3.picture+"');'></div>" +
					                    		"</div>" +
							                    "<div class='partnerInformation'>" +
							                        "<div class='partnerName'>"+item3.name+"</div>" +
							                        "<div class='partnerEmail'>"+item3.email+"</div>" +
							                    "</div>" +
							                "</div>";
							            $("#corporationP").append(corporationP);    
									});
									$("#jobless").css("display","block");
								} else if(index==5){
									$("#countExternalP").text("외부 협업자 ("+item.externalPartner_count+")");
								} else if(index==6){
									$.each(item, function(index, item4){
										var corporationP = 
											"<div class='partnerBox' member_id='"+item4.member_id+"'>" +
					                    		"<div class='partnerPictureBox'>" +
					                        		"<div class='chattingMemberPicture' style='background-image: url('image/"+item4.picture+"');'></div>" +
					                    		"</div>" +
							                    "<div class='partnerInformation'>" +
							                        "<div class='partnerName'>"+item4.name+"</div>" +
							                        "<div class='partnerEmail'>"+item4.email+"</div>" +
							                    "</div>" +
							                "</div>";
							            $("#partner").append(corporationP);    
									});
								}
                			} else {
                				if(index==0){
	                				$("#countAlarm").text("알림 ("+item.alarm_count+")");
	                			} else if(index==1){
	                				$.each(item, function(index, item1){
	                					var inviteParterList = 
	                						"<div class='partnerAlarm' partner_id='"+item1.parter_id+"'>" +
	                                   			 "<h6>파트너 수락 대기중</h6>" +
	                                   			 "<div>" +
	                                        		"<img src='image/partnerMail.svg'/>" +
	                                        		"<span  class='mail'>"+item1.invite_mail+"</span>" +
			                                        "<button class='inviteCancellationBtn'>초대 취소</button>" +
			                                        "<button class='retryInvite'>다시 초대</button>" +
			                                    "</div>" +
	                                		"</div>";
	                                	$("#alarm").append(inviteParterList);	
	                				});
	                			} else if(index==2) {
	                				$.each(item, function(index, item2){
		                				var inviteMeList = 
		            						"<div class='partnerAlarm' member_id='"+item2.member_id+"'>" +
		                               			 "<h6>파트너 수락 대기중</h6>" +
		                               			 "<div>" +
		                                    		"<img class='partnerImg' src='image/"+item2.picture+"'/>" +
		                                    		"<span  class='mail'>"+item2.name+"</span>" +
			                                        "<button class='agreeBtn'>수락</button>" +
			                                        "<button class='refuseBtn'>거절</button>" +
			                                    "</div>" +
		                            		"</div>";
		                            	$("#alarm").append(inviteMeList);
	                				});
	                				$("#jobless").css("display","none");
	                			} else if(index==3){
                					$("#countCorporationP").text("파트너 ("+item.partner_count+")");
                				} else if(index==4){
									$.each(item, function(index, item3){
										var partner = 
											"<div class='partnerBox' member_id='"+item3.member_id+"'>" +
					                    		"<div class='partnerPictureBox'>" +
					                        		"<div class='chattingMemberPicture' style='background-image: url('image/"+item3.picture+"');'></div>" +
					                    		"</div>" +
							                    "<div class='partnerInformation'>" +
							                        "<div class='partnerName'>"+item3.name+"</div>" +
							                        "<div class='partnerEmail'>"+item3.email+"</div>" +
							                    "</div>" +
							                "</div>";
							            $("#corporationP").append(partner);    
									});
								}
                			}
                		});
                	},
                	error : function(r,s,e){
                		
                	}
                	
                });
            });
            $("#invitePartnerInput").focusin(function(){
            	$(this).css("outline","2px solid #d9ad2b");
            });
            $("#invitePartnerInput").focusout(function(){
            	$(this).css("outline","none");
            });
            $("#invitePartnerInput").keyup(function(e){
            	$(this).attr("value",$(this).val());
            	if(e.keyCode == 13){
            		var email = $(this).val();
            		if(email.includes("@") && email.includes(".")){
	            		$(".inviteEmail").each(function(index, item){
	            			if($(item).text()==email){
	            				alert("이미 초대 리스트에 추가된 사람입니다.");
	            				$("#invitePartnerInput").val("");
	            				email="";
	            			}
	            		});
	            		if(email!=""){
	            			var inviteList =
		            			"<div class='inviteList'>" +
		                			"<img src='image/partnerMail.svg'/>" +
		                			"<span class='inviteEmail'>"+$(this).val()+"</span>" +
		                			"<button id='xbutton'>x</button>" +
		               			 "</div>";
	            			$("#inviteMails").append(inviteList);
	            			$("#invitePartnerInput").val("");
	            		}
            		}
            	}
            });
            $(document).on("click",".inviteCancellationBtn",function(){
            	var mail = $(this).parent().find(".mail").text();
            	$(this).parent().parent().remove();
            	$.ajax({
            		type: 'get',
            		url: 'Controller?command=PartnerInviteCancelAction',
            		data: {"loginId":<%=loginId%>,"inviteMail":mail},
            		datatype:'json',
            		success: function(data){
            			$("#countAlarm").text("알림 ("+data.alarm_count+")");
            		},
            		error: function(r,s,e){
            			alert("실패");
            		}
            	});
            });
            $(document).on("mouseenter",".inviteCancellationBtn",function(){
            	$(this).css("border","1px solid gray");
            });
            $(document).on("mouseleave",".inviteCancellationBtn",function(){
            	$(this).css("border","1px solid rgb(193,193,193)");
            });
            $(document).on("mouseenter",".retryInvite",function(){
            	$(this).css("border","1px solid rgb(179,142,34)");
            });
            $(document).on("mouseleave",".retryInvite",function(){
            	$(this).css("border","1px solid #d9ad2b");
            });
            $(document).on("mouseenter",".agreeBtn",function(){
            	$(this).css("border","1px solid rgb(179,142,34)");
            });
            $(document).on("mouseleave",".agreeBtn",function(){
            	$(this).css("border","1px solid #d9ad2b");
            });
            $(document).on("mouseenter",".refuseBtn",function(){
            	$(this).css("border","1px solid gray");
            });
            $(document).on("mouseleave",".refuseBtn",function(){
            	$(this).css("border","1px solid rgb(193,193,193)");
            });
            $(document).on("click","#xbutton",function(){
            	$(this).parent().remove();
            });
            $("#invitePartnerBtn").mouseenter(function(){
            	$(this).css("background-color","rgb(197,142,34)");
            });
            $("#invitePartnerBtn").mouseleave(function(){
            	$(this).css("background-color","#dab547");
            });
            $("#invitePartner").mouseenter(function(){
            	$(this).css("background-color","rgb(197,142,34)");
            });
            $("#invitePartner").mouseleave(function(){
            	$(this).css("background-color","#dab547");
            });
            $("#invitePartnerBtn").click(function(){
                var inviteList = new Array();
                $(".inviteEmail").each(function(index, item){
                	inviteList.push($(item).text());
                });
                if(inviteList.length==0){
                	alert("초대할 파트너의 이메일 주소를 입력해주세요.");
                } else {
	                $.ajax({
	                	type:'get',
	                	url: 'Controller?command=PartnerInviteAction',
	                	data: {"inviteList":inviteList,"loginId":<%=loginId%>},
	                	datatype: 'json',
	                	traditional : true,
	                	success: function(data){
	                		alert("성공적으로 초대 되었습니다.");
	                		$("#partnerInviteBox").css("display","none");
	                		$("#partners").css("display","none");
	                		$("#inviteMails").html("");
	                	},
	                	error : function(r,s,e) {
	                		alert("실패");
	                	}
	                });
                }
            });
            $("#search").focusin(function(){
            	$(this).css("outline","none");
            });
            $("#search").keyup(function(){
            	$(this).attr("value",$(this).val());
            	var search = $(this).val();
            	$(".mail").each(function(index, item){
            		if($(item).text().includes(search)){
            			$(item).parent().parent().css("display","block");
            		} else {
            			$(item).parent().parent().css("display","none");
            		}
            	});
            	$(".partnerName").each(function(index, item){
            		if($(item).text().includes(search)){
            			$(item).parent().parent().css("display","block");
            		} else {
            			$(item).parent().parent().css("display","none");
            		}
            	});
				$(".partnerEmail").each(function(index, item){
					if($(item).text().includes(search)){
            			$(item).parent().parent().css("display","block");
            		} else {
            			$(item).parent().parent().css("display","none");
            		}
            	});           	
            });
            $(document).on("click",".refuseBtn",function(){
            	var member_id = $(this).parent().parent().attr("member_id");
            	$(this).parent().parent().remove();
            	$.ajax({
            		type: 'get',
            		url:'Controller?command=PartnerInviteRefuseAction',
            		data: {"loginId":<%=loginId%>, "memberId":member_id},
            		datatype: 'json',
            		success: function(data){
            			$("#countAlarm").text("알림 ("+data.alarm_count+")");
            		},
            		error: function(r,s,e){
            			alert("실패");
            		}
            	});
            });
            $(document).on("click",".agreeBtn",function(){
            	var member_id = $(this).parent().parent().attr("member_id");
            	$("#partners").css("display","none");
            	$.ajax({
            		type: 'get',
            		url:'Controller?command=PartnerInviteAgreeAction',
            		data: {"loginId":<%=loginId%>, "memberId":member_id},
            		datatype: 'json',
            		success: function(data){
            			$("#countAlarm").text("알림 ("+data.alarm_count+")");
            		},
            		error: function(r,s,e){
            			alert("실패");
            		}
            	});
            });
            $("#invitePartner").click(function(){
                $("#partnerInviteBox").css("display","block");
            });
            $("#inviteXbtn").click(function(){
                $("#partnerInviteBox").css("display","none");
                $("#inviteMails").html("");
            });
            $("#search").keyup(function(key){
                $(this).attr("value",$(this).val());
                if(key.keyCode==13){
                    alert($(this).val());
                }
            });
            // 자바메일 api
        });
    </script>
    <style>
    	#inviteMailListBox {
    		height:300px;
    		overflow: auto;
    	}
    	#inviteMailListBox::-webkit-scrollbar {
            width:5px;
        }
         #inviteMailListBox::-webkit-scrollbar-thumb {
            background-color: #e1e1e1;
            border-radius: 5px;
        }
        #inviteMailListBox::-webkit-scrollbar-track {
            background-color: white;
            border-radius: 5px;
        }    
    	.inviteEmail {
    		font-size: 13px; float:left; margin-top: 3px; margin-left: 8px;
    	}
    	.partnerImg {
    		border-radius: 35px;
    	}
    	.agreeBtn{
    		background-color: white;
            width: 80px; height: 25px;  border: 1px solid #d9ad2b; border-radius: 5px; color:#d9ad2b;
    	}
    	.refuseBtn {
    		background-color: white;
            margin-top: 30px; margin-left: -75px; clear:both; padding: 0px; width: 80px; height: 25px; border-radius: 5px; border: 1px solid rgb(193,193,193); color:gray;
    	}
        .parentsAlarm {
            display: block;
        }
        #partners {
            float: right;
            border-radius: 5px;
            width:200px;
            height: 890px;
            border: 1px solid #888888;
            display: none;
            overflow:auto;
        }
        #partners::-webkit-scrollbar {
        	width:4px;
        }
        #partners::-webkit-scrollbar-trace {
        	background-color: white;
            border-radius: 5px;
        }
        #partners::-webkit-scrollbar-thumb {
        	background-color: rgb(225,225,225);
            border-radius: 5px;
        }
        #partnerSc{
            width:190x;
            height:785px;
            margin-top: 15px;
        }
       
        #invitePartner {
            width: 180px;
            height: 30px;
            margin-left: 10px;
            margin-top: 10px;
            border-radius: 5px;
            background-color: #d9ad2b;
            color: white;
            border: none;
        }
        .gray {
            filter: brightness(0) saturate(100%) invert(57%) sepia(1%) saturate(0%) hue-rotate(282deg) brightness(94%) contrast(88%);
        }
        .hideBtn, #inviteXbtn {
            float: right;
            width: 20px;
            height: 20px;
            padding: 0px;
            border:none;
            background-color:white;
        }
        .buttonImg{
            width: 20px;
            filter: brightness(0) saturate(100%) invert(0%) sepia(86%) saturate(2941%) hue-rotate(215deg) brightness(85%) contrast(110%);
        }
        #partnerInviteBox {
            width: 900px;
            height: 530px;
            border: 1px solid black;
            border-radius: 5px;
            float: right;
            display: none;
            padding: 20px 30px 20px 30px;
        }
        .inviteCancellationBtn {
            background-color: white;
            margin-top: 15px; margin-left: -25px; clear:both; padding: 0px; width: 80px; height: 25px; border-radius: 5px; border: 1px solid rgb(193,193,193); color:gray;
        }
        .retryInvite {
            background-color: white;
            width: 80px; height: 25px;  border: 1px solid #d9ad2b; border-radius: 5px; color:#d9ad2b;
        }
        .chattingMemberPicture {
             
            width: 32px; 
            height: 32px;
            float: left; 
            border-radius: 35px; 
        }
        .onOffImg {        
            width:8px; 
            float: right;
            border-radius: 35px;
            border: 1px solid gray;
            filter: brightness(0) saturate(100%) invert(92%) sepia(82%) saturate(4726%) hue-rotate(30deg) brightness(112%) contrast(97%);
            background-color: #96fc1f;
            display: block;
        }
        #alarm {
        	display: block;
        }
        .partnerAlarm {
        	margin-left: 10px; margin-top:5px;
        }
        .partnerAlarm > h6 {
        	padding:0px; margin-top: 0px; margin-bottom: 5px;
        }
        .partnerAlarm > div {
        	width: 178px; height:70px; border-bottom:1px solid #c1c1c1;
        }
        .partnerAlarm > div > img{
        	width:25px; float: left; margin-left: 5px;
        }
        .mail {
        	font-size: 13px; float:left; margin-top: 3px; margin-left: 8px; color:#888888;
        }
        #countCorporationP {
        	font-size: 12px; color: gray;"
        }
        #countCorporationP > img {
        	width:14px; height:14px; vertical-align: bottom; margin: 0px; padding: 0px;
        }
        #corporationP {
        	display: block;
        }
        .partnerBox {
       		margin-top: 5px; clear: both; margin-left: 5px; height:40px;
        }
        .partnerPictureBox {
        	float: left; margin-left: 5px; margin-top: 3px;
        }
        .partnerName {
        	font-size: 12px; float: left; width:128px ;
        }
        .partnerEmail {
        	font-size: 12px; color:#888888;
        }
        .partnerInformation{
        	float:left; margin-left: 2px;
        }
        #countAlarm {
        	font-size: 12px; color: gray;
        }
        #countAlarm > button {
        	width: 15px; height: 15px; padding: 0px; vertical-align: center; border:none; background-color: white;
        }
        .gray {
        	width:14px; height:14px; vertical-align: bottom; margin: 0px; padding: 0px;
        }
        #countExternalP {
        	font-size: 12px; color: gray;
        }
        .slideBtn {
        	width: 15px; height: 15px; padding: 0px; vertical-align: center; border:none; background-color: white;
        }
        #partnerMag {
        	width:20px; height:20px; margin-top: 2px; margin-left: 2px; margin-right: 0; filter: brightness(0) saturate(100%) invert(78%) sepia(3%) saturate(0%) hue-rotate(222deg) brightness(99%) contrast(85%);
        }
        #search {
        	width:150px; height:25px; border:none; vertical-align: top; border-radius: 5px; padding: 0px;
        }
        #inviteAndSearchBox {
        	width:178px; height: 25px;border:1px solid #c1c1c1; margin-top: 10px; margin-left: 10px; border-radius: 5px; padding: 0px;
        }
        #alarmDiv {
        	margin-left: 10px;
        }
        #countCorporationPDiv {
        	margin-left: 10px; margin-top: 15px;
        }
        #countExternalPDiv {
        	margin-left: 10px; margin-top: 15px; clear:both;
        }
        #invitePartnerBtn {
        	margin-top: 40px; height:30px; width:385px; border:none; border-radius:5px; color:white; background-color:#dab547
        }
        #partnerInviteBox > h4 {
        	margin-top: 0px; color:#dab547; margin-bottom: 10px; float: left;
        }
        #invitePartnerInput {
        	width:380px; height:35px; border:1px solid #d9ad2b; border-radius: 5px;
        	padding-left:5px;
        }
        #explanationP1 {
        	font-size: 12px; margin: 0px; clear: both;
        }
        #explanationP2 {
        	margin-top: 0px; font-size: 12px;
        }
        #explanationP3 {
        	margin: 10px 0px 0px 0px; font-size:12px;
        }
        .explanationP4 {
	        font-size: 12px;
        }
        #partnerInviteListBox {
        	float:left; margin-left: 20px;
        }
        #partnerInviteListBox > div {
        	border: 1px solid black; border-radius:5px; height:300px;
        	padding-left : 20px;
        }
        #invitePartnerInputDiv {
        	float:left; border-right: 1px solid gray; width:410px; height:350px;
        }
        .inviteList {
        	background-color: #fafafa;
        	border: 1px solid #e0ddd9;
   			border-radius: 10px;
   			width: 200px;
   			height: 20px;
   			padding: 5px;
   			margin-bottom: 5px;
   			overflow: auto;
        }
        .inviteList::-webkit-scrollbar {
        	width: 3px;
        }
        .inviteList::-webkit-scrollbar-track {
       		background-color: white;
            border-radius: 5px;
        }
        .inviteList::-webkit-scrollbar-thumb {
        	background-color: rgb(225,225,225);
            border-radius: 5px;
        }
        .inviteList > img {
        	width: 15px;
        	float:left;
        	margin-left: 5px;
        	margin-top : 2px;
        	filter: brightness(0) saturate(100%) invert(59%) sepia(10%) saturate(15%) hue-rotate(81deg) brightness(90%) contrast(88%);
        }
        .inviteList > span {
        	font-size:12px;
        	color: black;
        	margin-top:0px;
        }
        .inviteList > button {
        	width: 20px;
        	height:19px;
        	margin: 0px 5px 0px 0px;
        	float: right;
        	background-color: #fafafa;
        	border:none;
        	
        }
    </style>
	</head>
<body>
	 <button id="partnerBtn" style="float: right;">파트너</button>
    <div id="partners">
        <button id="invitePartner">파트너 초대하기</button>
        <div id="inviteAndSearchBox">
            <img id="partnerMag" src="image/magnifier.svg"/>
            <input id="search" type="search"  placeholder="이름 또는 이메일"/>
        </div>
        <div id="partnerSc">
            <div id='alarmDiv'>
                <span id='countAlarm'>알림 ()</span><button class='slideBtn'><img class="gray" id="alarmBtn" src="image/down.svg"/></button>
            </div>
            <div id="alarm">
                <div class="partnerAlarm">
                    <h6>파트너 수락 대기중</h6>
                    <div>
                        <img src="image/partnerMail.svg"/>
                        <span  class="mail">yura2704@gmail.coom</span>
                        <button class="inviteCancellationBtn">초대 취소</button>
                        <button class="retryInvite">다시 초대</button>
                    </div>
                </div>
            </div>    
            <div id="countCorporationPDiv">
                <span id="countCorporationP">회사 동료 ()</span><button class='slideBtn'><img class="gray" id="commpanyColleagueBtn" src="image/down.svg"/></button>
            </div>
            <div id="corporationP">
                <div class='partnerBox'>
                    <div class='partnerPictureBox'>
                        <div class="chattingMemberPicture"><img class="onOffImg" src="image/bell.svg"/></div>
                    </div>
                    <div class='partnerInformation'>
                        <div class='partnerName'>강태안</div>
                        <div class='partnerEmail'>jm</div>
                    </div>
                </div>
            </div>
            
            <div id="jobless">
	            <div id="countExternalPDiv">
	                <span id="countExternalP">외부 협업자 ()</span><button class='slideBtn'><img class="gray" id="externalPartnerBtn" src="image/down.svg"/></button>
	            </div>
	            <div id="partner" style="display: block;">
	                <div class='partnerBox'>
	                    <div class='partnerPictureBox'>
	                        <div class="chattingMemberPicture"><img class="onOffImg" src="image/bell.svg"/></div>
	                    </div>
	                    <div class='partnerInformation'>
	                        <div class='partnerName'>강태안</div>
	                        <div class='partnerEmail'>jm</div>
	                    </div>
	                </div>
	            </div>
            </div>
        </div>
    </div>
    <div id="partnerInviteBox">
        <h4>파트너 초대</h4>
        <button id="inviteXbtn"><img class="buttonImg" src="image/x.svg"/></button>
        <p id="explanationP1">더 많은 사람을 초대하여 원활한 의사소통으로 업무를 효율적으로 처리해보세요.</p>
        <p id="explanationP2">회사 동료뿐만 아니라 외부 협업자도 파트너로 초대할 수 있습니다.</p>
        <div id="invitePartnerInputDiv">
            <p class="explanationP4"><b>파트너 초대</b></p>
            <input id="invitePartnerInput" type="search" placeholder="이메일 주소를 입력하고 Enter키를 눌러주세요"/>
            <p id="explanationP3">이메일 주소를 입력하고 Enter키를 눌러 동료들을 초대해 보세요.</p>
        </div>
        <div id="partnerInviteListBox">
            <p class="explanationP4"><b>초대 리스트</b></p>
            <div id="inviteMailListBox">
                <p class="explanationP4">초대 메일을 보낼 이메일 주소를 여기에서 확인할 수 있습니다.</p>
                <div id="inviteMails">                </div>
            </div>
            <button id="invitePartnerBtn">파트너 초대하기</button>
        </div>
    </div>
</body>
</html>