<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%-- <%@ page import="com.yr.dto.*" %>
<%@ page import="com.yr.dao.*" %> --%>
<%@ page import="com.ta.dto.*" %>
<%@ page import="com.ta.dao.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	//session.setAttribute("id",4);
	//int loginId = (int)(session.getAttribute("id"));
	int loginId = 4;
	/* int member_id = (Integer)(session.getAttribute("member_id")); */
	//HomeDao hDao = new HomeDao();
	//int member_id = 4;
	int corporation_id = 5;
	//int corporation_id = (Integer)session.getAttribute("corporation_id");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>homehead1</title>
	<link rel="icon" href="Images/favicon.ico" type="image/x-icon">
	<script src="js/jquery-3.6.0.min.js"></script>
	<style>
	ul {
    	list-style-type: none;
	}
	a{
		text-decoration: none;
		color: black;
	}
	button{
		border: none;
	}
	.home_topright{
    	position: relative;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    -webkit-box-pack: end;
	    justify-content: flex-end;
	    padding-right: 60px;
    	margin-top: 11px;
    }
    .home_btn11{
    	width: 32px;
	    height: 32px;
	    border-radius: 50%;
	    padding: 1px;
	    background-color: rgba(0, 0, 0, 0.1);
        cursor: pointer;
        position: relative;
        z-index: 10;
        background-image: url(https://down.collabee.co/userProfile/-1);
	    border-radius: 50%;
	    background-size: cover;
	    background-position: center center;
	    content: "";
    }
    .home_btn21{
    	width: 32px;
	    height: 32px;
	    margin-left: 8px;
	    padding-top: 4px;
	    border-radius: 4px;
	    cursor: pointer;
	    background-color: white;
    }
    .home_btn21:hover{
    	background-color: #f2f2f2;
    }
    .home_btn31{
    	display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    margin-left: 8px;
	    padding: 0px 4px 0px 6px;
	    border-radius: 4px;
	    background-color: white;
	    color: rgb(34, 34, 34);
	    font-size: 13px;
	    line-height: 32px;
	    cursor: pointer;
    }
    .home_btn31:hover{
    	background-color: #f2f2f2;
    }
    .home_number{
    	display: inline-block;
	    padding-left: 4px;
	    padding-right: 4px;
    }
    .home_option{
		position: absolute;
	    display: none;
	    z-index: 101;
	}
	.home_option2{
		width: 290px;
	    border-radius: 4px;
	    box-shadow: rgb(0 0 0 / 10%) 0px 0px 8px 2px;
	    background-color: rgb(255, 255, 255);
	}
	.home_option_header{
		flex-shrink: 0;
	    margin-right: 16px;
	    display: flex;
	    flex-direction: row;
	}
	.home_option_btn1{
		margin-top: 17px;
	    margin-left: 27px;
		flex-shrink: 0;
	    position: relative;
	    width: 60px;
	    height: 60px;
	    border-radius: 50%;
	    padding: 1px;
	    background-color: rgba(0, 0, 0, 0.1);
	    content: "";
	    background-image: url(https://down.collabee.co/userProfile/-1);
	    background-size: cover;
	    background-position: center center;
	    transition: border-color 0.3s ease 0s;
	    cursor: pointer;
	}
	.home_option_btn1:after{
		position: absolute;
	    display: block;
	    top: -1px;
	    left: -1px;
	    width: 58px;
	    height: 58px;
	    border-radius: 50%;
	    content: "";
	    border: 2px solid rgba(0, 0, 0, 0);
	}
	.home_option_btn1:hover::after{
		border-color: rgb(217, 173, 43);
	}
	.home_option_ul{
		display: flex;
	    flex-direction: column;
	    -webkit-box-pack: center;
	    justify-content: center;
	    padding-left: 24px;
	}
	.home_option_btn2{
		width: 100%;
	    text-align: left;
	    font-size: 16px;
	    font-weight: bold;
	    line-height: 1.38;
	    margin-left: -7px;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    overflow-wrap: normal;
	    overflow: hidden;
	    background-color: transparent;
	    cursor: pointer;
	    transition: color 0.2s ease 0s, background-color 0.2s ease 0s;
	    color: rgb(34, 34, 34);
	    pointer-events: auto;
	}
	.home_option_btn2:hover{
		color: rgb(136, 136, 136);
	}
	.home_option_li{
		font-size: 12px;
	    line-height: 1.5;
	    color: rgb(136, 136, 136);
	    margin-top: 2px;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    overflow-wrap: normal;
	    overflow: hidden;
	}
	.home_option_container{
		border-top: 1px solid rgb(225, 225, 225);
	    padding: 18px 0px;
	    display: flex;
	    flex-direction: column;
	}
	.home_option_container2{
		display: block;
	    color: rgb(34, 34, 34);
	    font-size: 13px;
	    line-height: 1.54;
	    padding: 4px 4px 4px 18px;
	    background-color: rgb(255, 255, 255);
	    transition: background-color 0.2s ease 0s;
	}
	.home_option_container2:hover{
		background-color: rgb(242, 242, 242);
	    cursor: pointer;
	}
	.home_option_btn3{
		outline: 0;
		border: none;
	    box-sizing: border-box;
		text-align: left;
	    display: block;
	    color: rgb(34, 34, 34);
	    font-size: 13px;
	    line-height: 1.54;
	    padding: 4px 4px 4px 18px;
	    background-color: rgb(255, 255, 255);
	    transition: background-color 0.2s ease 0s;
	}
	.home_option_btn3:hover{
		background-color: rgb(242, 242, 242);
	    cursor: pointer;
	}
	.hidden{
		display: none;
	}
	
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
           border-radius: 4px;
           width:200px;
           display: none;
           transform: scale(1, 1) translateZ(0px);
	   		transition: opacity 386ms cubic-bezier(0.4, 0, 0.2, 1) 0ms, transform 257ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;
	       	box-shadow: 0px 5px 5px -3px rgb(0 0 0 / 20%), 0px 8px 10px 1px rgb(0 0 0 / 14%), 0px 3px 14px 2px rgb(0 0 0 / 12%);
	       	outline: none;
		    position: absolute;
		    overflow-y: auto;
		    overflow-x: hidden;
		    height: 662px;
		    background-color: #fff;
		    z-index: 101;
		    position: absolute;
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
           color: #aaa;
           font-size: 28px;
       	font-weight: bold;
       }
       .buttonImg:hover{
        color: black;
        text-decoration: none;
        cursor: pointer;
       }
       #partnerInviteBox {
          top: 10%;
    	  left: 20%;
          z-index: 1000;
    	  position: absolute;
          width: 850px;
		  height: 500px;
		  padding: 20px 32px 32px;
		  display: none;
		  flex-direction: column;
          border-radius: 4px;
          background-color: #fff;
          flex: 0 1 auto;
          box-shadow: 0px 11px 15px -7px rgb(0 0 0 / 20%), 0px 24px 38px 3px rgb(0 0 0 / 14%), 0px 9px 46px 8px rgb(0 0 0 / 12%);
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
       	box-shadow: rgb(217 173 43) 0px 0px 0px 1px inset, rgb(217 173 43 / 20%) 0px 0px 0px 4px;
       }
       #explanationP1 {
       	margin: 0px; clear: both;
       	font-size: 12px;
	    line-height: 1.5;
	    color: rgb(136, 136, 136);
       }
       #explanationP2 {
       	margin-top: 0px;
       	font-size: 12px;
	    line-height: 1.5;
	    color: rgb(136, 136, 136);
       }
       #explanationP3 {
       	margin: 10px 0px 0px 0px;
       	font-size: 12px;
	    line-height: 1.5;
	    color: rgb(136, 136, 136);
       }
       .explanationP4 {
        font-size: 12px;
	    color: rgb(136, 136, 136);
	    line-height: 1.5;
       }
       #partnerInviteListBox {
       	float:left; margin-left: 30px;
       }
       #partnerInviteListBox > div {
       	border: 1px solid rgb(225, 225, 225); border-radius:5px; height:300px;
       	padding-left : 20px;
       }
       #invitePartnerInputDiv {
       	float:left; border-right: 1px solid #e2e2e2; width:400px; height:350px;
       }
       .inviteList {
       		background-color: #fafafa;
       		border: 1px solid #e0ddd9;
  			border-radius: 15px;
  			width: 200px;
  			height: 20px;
  			padding: 5px;
  			margin-bottom: 5px;
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
   	.partnerMag{
	    display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(193, 193, 193);
	    margin-left: 5px;
   		margin-top: -3px;
   	}
   	.homehead_background1{
   		display: none;
		z-index: 110;
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom : 0;
		width: 100%;
		height: 100%;
		background-color: rgba(34, 34, 34, 0.8);
   	}
   	.homehead_background2{
		display: none;
		z-index: 100;
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom : 0;
		width: 100%;
		height: 100%;
		background-color: transparent;
	}
	</style>
	<script>
	
	$(function(){
		$("#makingsample, #language").click(function(){
			alert("?????? ????????????.");
		});
		
		$('.home_btn11').click(function (){
        	var px = $(this).offset().left - 210;
        	var py = $(this).offset().top + 30;
        	if($('.home_option').css('display')=='none') {
        		$('.home_option').css('display','block');
        		$('.home_option').css('left',px+'px');
            	$('.home_option').css('top',py+'px');
        		$('.homehead_background2').css('display', 'block');
        	} else {
        		$('.home_option').css('display','none');
        		$('.homehead_background2').css('display', 'none');
        	}
       });
		
		$('.homehead_background2').click(function() {
        	$('.homehead_background2').css('display', 'none');
      		if($('.home_option').css('display')!='none'){
       			$('.home_option').css('display','none');
      		}else if($('.alarm_expl').css('display')!='none'){
      			$('.alarm_expl').css('display','none');
      		}else if($('.folder_selection0').css('display')!='none'){
      			$('.folder_selection0').css('display','none');
      		}
      	});
		
		$( document ).ready( function() {
       	   //$('.btn11').attr("title", "${name}");
       	   $('.home_btn11').attr({
       		   title : "${name}",
       		   style: "background-image: url(${picture});"
       	   });
	       	$('.home_option_btn1').attr({
	    		   title : "${name}",
	    		   style: "background-image: url(${picture});"
	    	});
       	});
       	
       	$("#logout").click(function(){
			var result2 = confirm("??????????????? ?????????????????????????");
			if(result2){
				$.ajax({
					type: 'get',
					url: 'Controller?command=Option1MemberLogout',
					success: function(d){
						
					},
					error: function(r,s,e){
						alert("error");
					}
				});
			}
		});
       	//??????????????? ????????????
       	$("#alarmBtn").on("click", function(){ // ?????? ???????????? ??????
            $("#alarm").slideToggle("fast");
	    });
	    $("#commpanyColleagueBtn").on("click", function(){ // ????????????
	        $("#corporationP").slideToggle("fast");
	    });
	    $("#externalPartnerBtn").on("click", function(){ // ???????????????
	        $("#partner").slideToggle("fast");
	    });
	    $(document).on("click",".retryInvite",function(){
	        var mail = $(this).parent().children('.mail').text(); 
			$.ajax({
				type: 'get',
				url: 'PartnerInvitationAgainServlet',
				data: {"email":mail},
				datatype:'json',
				successs: function(data){
					
				},
				error: function(r,s,e){
					
				}
				
			});
			alert(mail+" ?????? ?????? ?????? ???????????????.");
	    });
	    $(".hideBtn").click(function(){
	        $(this).parent().parent().parent().css("display","none")
	    });
	    $(".home_btn31").click(function(){
	    	var px = $(this).offset().left -150;
        	var py = $(this).offset().top + 30;
        	$("#partners").css('left',px+'px');
        	$("#partners").css('top',py+'px');
        	$('.homehead_background2').css('display', 'block');
	    	
        	$("#partners").slideToggle("fast");
	        $("#alarm").html("");
	        $("#corporationP").html("");
	        $("#partner").html("");
	        $.ajax({
	        	type: 'get',
	        	url: 'PartnerContentServlet',
	        	data: {"loginId":<%=loginId%>},
	        	datatype: 'json',
	        	success: function(data){
	        		$.each(data, function(index, item){
	        			if(data.length==7){
	            			if(index==0){
	            				$("#countAlarm").text("?????? ("+item.alarm_count+")");
	            			} else if(index==1){
	            				$.each(item, function(index, item1){
	            					var inviteParterList = 
	            						"<div class='partnerAlarm' partner_id='"+item1.parter_id+"'>" +
	                               			 "<h6>????????? ?????? ?????????</h6>" +
	                               			 "<div>" +
	                                    		"<img src='image/partnerMail.svg'/>" +
	                                    		"<span  class='mail'>"+item1.invite_mail+"</span>" +
		                                        "<button class='inviteCancellationBtn'>?????? ??????</button>" +
		                                        "<button class='retryInvite'>?????? ??????</button>" +
		                                    "</div>" +
	                            		"</div>";
	                            	$("#alarm").append(inviteParterList);	
	            				});
	            			} else if(index==2) {
	            				$.each(item, function(index, item2){
	                				var inviteMeList = 
	            						"<div class='partnerAlarm' member_id='"+item2.member_id+"'>" +
	                               			 "<h6>????????? ?????? ?????????</h6>" +
	                               			 "<div>" +
	                                    		"<img class='partnerImg' src='image/"+item2.picture+"'/>" +
	                                    		"<span  class='mail'>"+item2.name+"</span>" +
	                                    		"<button class='refuseBtn'>??????</button>" +
		                                        "<button class='agreeBtn'>??????</button>" +
		                                    "</div>" +
	                            		"</div>";
	                            	$("#alarm").append(inviteMeList);
	            				});
	            			} else if(index==3){
								$("#countCorporationP").text("?????? ?????? ("+item.companyColleague_count+")");
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
								$("#countExternalP").text("?????? ????????? ("+item.externalPartner_count+")");
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
	            				$("#countAlarm").text("?????? ("+item.alarm_count+")");
	            			} else if(index==1){
	            				$.each(item, function(index, item1){
	            					var inviteParterList = 
	            						"<div class='partnerAlarm' partner_id='"+item1.parter_id+"'>" +
	                               			 "<h6>????????? ?????? ?????????</h6>" +
	                               			 "<div>" +
	                                    		"<img src='image/partnerMail.svg'/>" +
	                                    		"<span  class='mail'>"+item1.invite_mail+"</span>" +
		                                        "<button class='inviteCancellationBtn'>?????? ??????</button>" +
		                                        "<button class='retryInvite'>?????? ??????</button>" +
		                                    "</div>" +
	                            		"</div>";
	                            	$("#alarm").append(inviteParterList);	
	            				});
	            			} else if(index==2) {
	            				$.each(item, function(index, item2){
	                				var inviteMeList = 
	            						"<div class='partnerAlarm' member_id='"+item2.member_id+"'>" +
	                               			 "<h6>????????? ?????? ?????????</h6>" +
	                               			 "<div>" +
	                                    		"<img class='partnerImg' src='image/"+item2.picture+"'/>" +
	                                    		"<span  class='mail'>"+item2.name+"</span>" +
		                                        "<button class='agreeBtn'>??????</button>" +
		                                        "<button class='refuseBtn'>??????</button>" +
		                                    "</div>" +
	                            		"</div>";
	                            	$("#alarm").append(inviteMeList);
	            				});
	            				$("#jobless").css("display","none");
	            			} else if(index==3){
	        					$("#countCorporationP").text("????????? ("+item.partner_count+")");
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
	    $('.homehead_background2').click(function(){
	    	$('.homehead_background2').css('display', 'none');
	    	$("#partners").css('display', 'none');
	    });
	    $("#invitePartnerInput").focusin(function(){
	    	$(this).css("outline","none");
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
	        				alert("?????? ?????? ???????????? ????????? ???????????????.");
	        				$("#invitePartnerInput").val("");
	        				email="";
	        			}
	        		});
	        		if(email!=""){
	        			var inviteList =
	            			"<div class='inviteList'>" +
	                			"<svg style='padding-left: 4px; float: left;' xmlns='http://www.w3.org/2000/svg' width='17px' height='17px' viewBox='0 0 24 24'><path fill='#888888' fill-rule='evenodd' d='M20 4c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2l.01-12c0-1.1.89-2 1.99-2h16zM4 6v12h16V6H4zm15 3l-7 4-7-4V7l7 4 7-4v2z'></path></svg>" +
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
	    		url: 'PartnerInviteCancelServlet',
	    		data: {"loginId":<%=loginId%>,"inviteMail":mail},
	    		datatype:'json',
	    		success: function(data){
	    			$("#countAlarm").text("?????? ("+data.alarm_count+")");
	    		},
	    		error: function(r,s,e){
	    			alert("??????");
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
	        	alert("????????? ???????????? ????????? ????????? ??????????????????.");
	        } else {
	            $.ajax({
	            	type:'get',
	            	url: 'PartnerInviteServlet',
	            	data: {"inviteList":inviteList,"loginId":<%=loginId%>},
	            	datatype: 'json',
	            	traditional : true,
	            	success: function(data){
	            		alert("??????????????? ?????? ???????????????.");
	            		$("#partnerInviteBox").css("display","none");
	            		$("#partners").css("display","none");
	            		$("#inviteMails").html("");
	            	},
	            	error : function(r,s,e) {
	            		alert("??????");
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
	    		url:'PartnerInviteRefuseServlet',
	    		data: {"loginId":<%=loginId%>, "memberId":member_id},
	    		datatype: 'json',
	    		success: function(data){
	    			$("#countAlarm").text("?????? ("+data.alarm_count+")");
	    		},
	    		error: function(r,s,e){
	    			alert("??????");
	    		}
	    	});
	    });
	    $(document).on("click",".agreeBtn",function(){
	    	var member_id = $(this).parent().parent().attr("member_id");
	    	$("#partners").css("display","none");
	    	$.ajax({
	    		type: 'get',
	    		url:'PartnerInviteAgreeServlet',
	    		data: {"loginId":<%=loginId%>, "memberId":member_id},
	    		datatype: 'json',
	    		success: function(data){
	    			$("#countAlarm").text("?????? ("+data.alarm_count+")");
	    		},
	    		error: function(r,s,e){
	    			alert("??????");
	    		}
	    	});
	    });
	    $("#invitePartner").click(function(){
	        $("#partnerInviteBox").css("display","block");
	        $('.homehead_background1').css("display", "block");
	    });
	    $("#inviteXbtn").click(function(){
	        $("#partnerInviteBox").css("display","none");
	        $('.homehead_background1').css("display", "none");
	        $("#inviteMails").html("");
	    });
	    $('.homehead_background1').click(function(){
	    	var result = confirm('????????? ????????? ???????????? ??????????????????????');
	    	if(result){
	    		$("#partnerInviteBox").css("display","none");
		        $('.homehead_background1').css("display", "none");
	    	}
	    });
	    $("#search").keyup(function(key){
	        $(this).attr("value",$(this).val());
	        if(key.keyCode==13){
	            alert($(this).val());
	        }
	    });
       	$(".home_btn21").click(function(){
       		$("#partnerInviteBox").css("display","block");
       		$('.homehead_background1').css('display', 'block');
       	});
	});
	</script>
</head>

<body>
<div class="home_option">
		<div class="home_option2">
			<div class="home_option3">
				<div class="home_option_header">
					<button class="home_option_btn1" onClick="location.href='Controller?command=option1'"></button>
					<ul class="home_option_ul">
						<li>
							<button class="home_option_btn2" onClick="location.href='Controller?command=option1'">${name }</button>
						</li>
						<li class="home_option_li">${email }</li>
						<li class="home_option_li" style="color: rgb(204, 153, 0);">${corName }</li>
					</ul>
				</div>
				<div class="home_option_container">
					<a class="home_option_container2" href="Controller?command=option1">??????</a>
					<a class="home_option_container2" href="0option2.jsp">??????</a>
				 	<%
					if (corporation_id != 0){
					%>
					<a class="home_option_container2" href="0corporation1.jsp">?????? ??????</a>
					<%
					}else{
					%>
					<a class="home_option_container2" href="Controller?command=option1">?????? ?????? ??? ?????????</a>
					<% 
					}
					%>
					<a class="home_option_container2" href="partner_management.jsp">????????? ??????</a>
				</div>
				<div class="home_option_container">
					<a class="home_option_container2" href="setting_price.jsp">?????? ??? ??????</a>
					<button class="home_option_btn3" id="makingsample">?????? ??????, ?????? ?????????</button>
					<a class="home_option_container2" href="0help1.jsp" target="_blank">?????? ?????????</a>
					<a class="home_option_container2" onclick="alert('?????? ????????????.')">???????????? ??? ????????????</a>
				</div>
				<div class="home_option_container">
					<button class="home_option_btn3" id="language">Language</button>
				</div>
				<div class="home_option_container">
					<button class="home_option_btn3" id="logout">????????????</button>
				</div>
			</div>
		</div>
	</div>
	
	
<div class="home_topright">
		<button title="" class="home_btn11"></button>
		<button title="????????? ??????" class="home_btn21">
		<svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewBox="0 0 24 24"><path fill="#888888" fill-rule="evenodd" d="M15 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm-9-2V7H4v3H1v2h3v3h2v-3h3v-2H6zm9 4c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"></path></svg>
		</button>
		<button class="home_btn31">
		<span>?????????</span>
		<span class="home_number">${partnerN }</span>
		</button>
 </div>
 
 <div class="homehead_background2"></div>
 	<div id="partners">
        <button id="invitePartner">????????? ????????????</button>
        <div id="inviteAndSearchBox">
           <svg viewBox="0 0 24 24" width="17px" height="17px" class="partnerMag"><path d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z" color="#C1C1C1"></path></svg>
            <input id="search" type="search"  placeholder="?????? ?????? ?????????"/>
        </div>
        <div id="partnerSc">
            <div id='alarmDiv'>
                <span id='countAlarm'>?????? ()</span><button class='slideBtn'><img class="gray" id="bt1" src="image/down.svg"/></button>
            </div>
            <div id="alarm">
                <div class="partnerAlarm">
                    <h6>????????? ?????? ?????????</h6>
                    <div>
                        <img src="image/partnerMail.svg"/>
                        <span  class="mail">yura2704@gmail.coom</span>
                        <button class="inviteCancellationBtn">?????? ??????</button>
                        <button class="retryInvite">?????? ??????</button>
                    </div>
                </div>
            </div>    
            <div id="countCorporationPDiv">
                <span id="countCorporationP">?????? ?????? ()</span><button class='slideBtn'><img class="gray" id="bt2" src="image/down.svg"/></button>
            </div>
            <div id="corporationP">
                <div class='partnerBox'>
                    <div class='partnerPictureBox'>
                        <div class="chattingMemberPicture"><img class="onOffImg" src="image/bell.svg"/></div>
                    </div>
                    <div class='partnerInformation'>
                        <div class='partnerName'>?????????</div>
                        <div class='partnerEmail'>jm</div>
                    </div>
                </div>
            </div>
            
            <div id="jobless">
	            <div id="countExternalPDiv">
	                <span id="countExternalP">?????? ????????? ()</span><button class='slideBtn'><img class="gray" id="bt3" src="image/down.svg"/></button>
	            </div>
	            <div id="partner" style="display: block;">
	                <div class='partnerBox'>
	                    <div class='partnerPictureBox'>
	                        <div class="chattingMemberPicture"><img class="onOffImg" src="image/bell.svg"/></div>
	                    </div>
	                    <div class='partnerInformation'>
	                        <div class='partnerName'>?????????</div>
	                        <div class='partnerEmail'>jm</div>
	                    </div>
	                </div>
	            </div>
            </div>
        </div>
    </div>
<div class="homehead_background1"></div>    
    <div id="partnerInviteBox">
        <h4>????????? ??????</h4>
        <button id="inviteXbtn"><span class="buttonImg">&times;</span></button>
        <p id="explanationP1">??? ?????? ????????? ???????????? ????????? ?????????????????? ????????? ??????????????? ??????????????????.</p>
        <p id="explanationP2">?????? ???????????? ????????? ?????? ???????????? ???????????? ????????? ??? ????????????.</p>
        <div id="invitePartnerInputDiv">
            <p class="explanationP4"><b>????????? ??????</b></p>
            <input id="invitePartnerInput" type="search" placeholder="????????? ????????? ???????????? Enter?????? ???????????????"/>
            <p id="explanationP3">????????? ????????? ???????????? Enter?????? ?????? ???????????? ????????? ?????????.</p>
        </div>
        <div id="partnerInviteListBox">
            <p class="explanationP4"><b>?????? ?????????</b></p>
            <div id="inviteMailListBox">
                <p class="explanationP4">?????? ????????? ?????? ????????? ????????? ???????????? ????????? ??? ????????????.</p>
                <div id="inviteMails">                </div>
            </div>
            <button id="invitePartnerBtn">????????? ????????????</button>
        </div>
    </div>
</body>
</html>