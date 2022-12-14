<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.yr.dto.*" %>
<%@ page import="com.yr.dao.*" %>
<%
	/* int member_id = (Integer)(session.getAttribute("member_id")); */
	ArrayList<MyWorkspaceDto> list2 = (ArrayList<MyWorkspaceDto>)request.getAttribute("list2");
	ArrayList<MyPartnerDto> list1 = (ArrayList<MyPartnerDto>)request.getAttribute("list1");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>dm1</title>
	<link rel="icon" href="images/favicon.ico" type="image/x-icon">
	<script src="js/jquery-3.6.0.min.js"></script>
	<style>
	* {
		font-family: -apple-system,BlinkMacSystemFont,Malgun Gothic,Hiragino Kaku Gothic ProN,Hiragino Sans,Meiryo,MS PGothic,sans-serif,Dotum;
	}
	button {
	    border: none;
	    box-sizing: border-box;
	    outline: 0;
	}
	/* The Modal (background) */
    .dm1_modal { /* modal --> dm1_modal */
        display: block; /* Hidden by default */
        position: fixed; /* Stay in place */
        margin:0;
        z-index: 50; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.7); /* Black w/ opacity */
        box-shadow: 0px 11px 15px -7px rgb(0 0 0 / 20%), 0px 24px 38px 3px rgb(0 0 0 / 14%), 0px 9px 46px 8px rgb(0 0 0 / 12%);
        align-items: center;
    }
    .dm1_modal-content {
        background-color: #fff;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 580px;
        min-height: 180px;
    	padding: 20px 20px 22px;
        border-radius: 4px;
        position: relative;
    }
    .dm1_close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        margin-top: -15px;
    }
    .dm1_close:hover, .dm1_close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
	.dm1_modal_header{
		padding-left: 4px;
		font-size: 12px;
	    font-weight: bold;
	    line-height: 1.5;
	    color: rgb(136, 136, 136);
	}
	.dm1_modal_body{
		padding-top: 20px;
	}
	.dm1{
		display: flex;
    	flex-direction: row;
	}
	.dm1_textbox{
		height: 32px
		overflow-wrap: break-word;
	    flex: 0 0 auto;
	    white-space: break-spaces !important;
	    min-height: 32px;
	    max-height: 132px;
	    resize: none;
	    border: none;
	    width: 520px;
	    margin-left: 5px;
	    font-size: 22px;
	    color: rgb(34, 34, 34);
	    line-height: 1.45;
	}
	.dm1_textbox::-webkit-scrollbar {
		width:4px;
	}
	.dm1_textbox::-webkit-scrollbar-thumb {
	    height: 70%; /* ??????????????? ?????? */
	    background: #e1e1e1; /* ??????????????? ?????? */
	    border-radius: 2px;
	}
	.dm1_textbox:focus {
  		outline: none;
	}
	.dm1_textbox::placeholder {
		color: lightgray;
	}
	.dm1_textbox::-webkit-input-placeholder {
  		color: gray;
	}
	.dm1_textbox:-ms-input-placeholder {
		color: gray;
	}
	.dm1_btn20{
		display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    cursor: pointer;
	    text-decoration: none;
	    border: none;
	    background-color: transparent;
	}
	ul,li{list-style:none;} 
	
	.dm1_modal_footer{
		display: flex;
	    align-items: flex-end;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    padding-top: 45px;
	}
    .dm1_btn21{
    	color: rgb(255, 255, 255);
	    font-size: 12px;
	    font-weight: 500;
	    line-height: 1.5;
	    border-radius: 4px;
	    text-align: center;
	    padding: 5px 18px;
	    background-color: rgb(217, 173, 43);
	    border: 1px solid rgb(217, 173, 43);
	    cursor: pointer;
    }
    .dm1_btn21:hover{
		filter: brightness(80%);
		/* transition: transform 10s; */
	}
	.dm1_selection{
		display: none;
		width: 190px;
	    flex-direction: column;
	    border-radius: 4px;
	    box-shadow: rgb(0 0 0 / 10%) 0px 0px 6px 2px;
	    background-color: rgb(255, 255, 255);
	    padding: 12px 0px;
	    margin-top: -1px;
    	margin-left: 6px;
    	position: absolute;
	}
	.dm1_file1{
		display: block;
		border: none;
		font-size: 13px;
	    line-height: 1.54;
	    color: rgb(34, 34, 34);
	    background-color: rgb(255, 255, 255);
	    padding: 5px 0px 5px 18px;
	    text-align: left;
	    cursor: pointer;
	    width: 100%;
	}
	.dm1_file1:hover{
		filter: brightness(80%);
		/* transition: transform 10s; */
	}
	.dm1_ff{
		display: block;
	    font-size: 12px;
	    line-height: 1.5;
	    color: rgb(136, 136, 136);
	    padding-bottom: 4px;
	    padding-left: 18px;
	}
	.dm1_pic_btn{
		background-color: white;
		color: rgb(193, 193, 193);
	    position: absolute;
	    margin-left: -1px;
	    margin-top: 5px;
	    border: none;
	    background-color: transparent;
	}
	.dm1_modal_mid{
		padding-bottom: 30px;
	}
	.dm1_list{
	    color: rgb(34, 33, 32);
	    font-size: 14px;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    align-items: center;
	    cursor: pointer;
	    padding: 4px 10px;
	}
	.dm1_list:hover{
		background-color: rgb(242,242,242);
	}
	.dm1_name{
		white-space: nowrap;
	    text-overflow: ellipsis;
	    overflow: hidden;
	    position: absolute;
	}
	.pi{
		position: relative;
	    width: 20px;
	    height: 20px;
	    border-radius: 50%;
	    padding: 5px;
	    content: "";
	    cursor: pointer;
	    float: left;
	    margin-right: 5px;
	    vertical-align: middle;
	    background-image: url(https://down.collabee.co/userProfile/1);
	    background-size: cover;
	    background-position: center center;
	}
	.pi::after{
		position: absolute;
	    display: block;
	    top: -1px;
	    left: -1px;
	    width: 18px;
	    height: 18px;
	    border-radius: 50%;
	    content: "";
	    border: 2px solid rgba(0, 0, 0, 0);
	    transition: border-color 0.3s ease 0s;
	}
	.pi:hover::after{
		border-color: rgb(217, 173, 43);
	}
	.select_pic{
		display: none;
		width: 150px;
		padding: 4px;
		border: 1px solid lightgray;
		background-color: rgb(255, 255, 255);
		border-radius: 4px;
		margin-top: -3px;
	    z-index: 10;
	    margin-left: 48px;
	    position: absolute;
	}
	.dm1_pii{
		position: relative;
	    width: 20px;
	    height: 20px;
	    border-radius: 50%;
	    content: "";
	    cursor: pointer;
	    float: left;
	    vertical-align: middle;
	    margin-top: 6px; 
	    margin-left: 25px;
	    margin-right: 5px;
    	background-size: cover;
    	background-position: center center;
    	display: block;
	}
	.dm1_pii::after{
		position: absolute;
	    top: -1px;
	    left: -1px;
	    width: 18px;
	    height: 18px;
	    border-radius: 50%;
	    content: "";
	    border: 2px solid rgba(0, 0, 0, 0);
	    transition: border-color 0.3s ease 0s;
	}
	.dm1_pii:hover::after{
		border-color: rgb(217, 173, 43);
	}
	#dm1_svg111{
		flex-shrink: 0;
	    margin-left: 128px;
    	margin-top: 11px;
	    display: none;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(0,0,0);
	}
	#dm1_svg111:hover{
		fill: #adacac;
	}
	.dm1_svg_box{
		float: right;
	    margin-top: -30px;
	    margin-right: 468px;
	}
	.dm1_hidden{
		visibility: hidden;
	}
	.dm1_file_container0{
		display: inline-block;
	    margin-left: 10px;
	    font-size: 14px;
	    color: rgb(133, 111, 46);
	    white-space: nowrap;
	    text-overflow: ellipsis;
	    overflow: hidden;
	}
	.dm1_file_container1{
		display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    min-width: 0px;
	}
	.dm1_file_container2{
		display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    height: 24px;
	    cursor: pointer;
	}
	.dm1_file_container2:hover{
		background-color: rgb(251, 250, 244);
	}
	.dm1_file_container3{
		border-top: 1px solid rgb(225, 225, 225);
	    padding-top: 20px;
	    max-height: 110px;
	    overflow-y: auto;
	}
	.dm1_file_container3::-webkit-scrollbar {
		width:4px;
	}
	.dm1_file_container3::-webkit-scrollbar-thumb {
	    height: 70%; /* ??????????????? ?????? */
	    background: #e1e1e1; /* ??????????????? ?????? */
	    border-radius: 2px;
	}
	.dm1_file_container4{
		position: relative;
	    margin-left: 8px;
	    opacity: 0;
	    transition: opacity 0.2s ease 0s;
	    background-color: transparent;
	}
	.file_svg1{
		transform: translateY(2px);
		display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    transition: fill 0.2s ease 0s;
	    fill: #b3b3b3;
	}
	.file_svg1:hover{
		fill: #5e5d5d;
	}
	/* ???????????? ?????? */
	#dm1_div_background {
		display: none;
		z-index: 2000;
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom : 0;
		width: 100%;
		height: 100%;
		/* background-color: rgba(0,0,0,0.5); */
		background-color: transparent;
	}
	.workspace_list{ /* ????????? ????????? ?????? ??????*/
		position: absolute;
		z-index: 2100;
		justify-content: right;
		margin-right:90px;
		display : none;
	}
	.workspace_list ul{ /* ????????? ????????? ?????? ??????*/
		position: absolute;
		list-style: none;
		background-color: rgb(255, 255, 255);
		border-radius: 4px;
		width: 132px;
		height:270px;
		border:1px solid #e1e1e1;
		font-size: 14px;
		font-weight: 500;
		color:rgb(34, 34, 34);
		padding:5px 12px;
		line-height: 2.5;
		display:flex;
		flex-direction: column;
		align-items: center;
		overflow-y: auto;
		overflow-x: hidden;
	}
	.workspace_list ul li:nth-child(1){
		color:rgb(136, 136, 136); 
		font-size: 10.5px; 
		pointer-events: none;
	}
	.workspace_list li{
		display: block;
		width: 135px;
		height: 35px;
		text-overflow: ellipsis;
	}
	.workspace_list li span{
		margin-left:7px;
	}
	.icon_color{
		fill:rgb(136, 136, 136);
	}
	#dm1_ul::-webkit-scrollbar {
		width:4px;
	}
	#dm1_ul::-webkit-scrollbar-thumb {
		height: 70%; /* ??????????????? ?????? */
		background: #e1e1e1; /* ??????????????? ?????? */
		border-radius: 2px;
	}
	#dm1_ul::-webkit-scrollbar-track {
		background-color: white;
		border-radius:2px;
	}
	.dm1_bottom_box{
		display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    position: relative;
	    padding-left: 4px;
	}
	.dm1_bottom_box2{
		position: relative;
    	margin-right: 12px;
	}
	.dm1_dropdown{
		position: relative;
    	box-sizing: border-box;
    	width: 160px;
	    border-width: 1px;
	    border-style: solid;
	    border-radius: 4px;
	    background-color: rgb(255, 255, 255);
	    border-color: rgb(217, 173, 43);
	}
	.dm1_bottom_box3{
		-webkit-box-align: center;
	    cursor: default;
	    display: flex;
	    flex-wrap: wrap;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    position: relative;
	    transition: all 100ms ease 0s;
	    box-sizing: border-box;
	    outline: 0px !important;
	    padding-left: 8px;
	    font-size: 13px;
	    background-color: transparent !important;
	    border: none !important;
	    border-radius: 0px !important;
	    box-shadow: none !important;
	    min-height: 28px !important;
	}
	.dm1_bottom_box4{
		-webkit-box-align: center;
	    align-items: center;
	    display: flex;
	    flex: 1 1 0%;
	    flex-wrap: wrap;
	    padding: 2px 8px;
	    position: relative;
	    overflow: hidden;
	    box-sizing: border-box;
	}
	.dm1_bottom_box5{
		max-width: calc(100% - 8px);
	    overflow: hidden;
	    position: absolute;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    top: 50%;
	    transform: translateY(-50%);
	    box-sizing: border-box;
	    width: 100%;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    margin: 0px !important;
	    color: rgb(204, 153, 0) !important;
	}
	.dm1_bottom_box_svg1{
		flex-shrink: 0;
	    margin-left: 8px;
	    margin-right: 8px;
	    display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(217, 173, 43);
	}
	</style>
	
	<script>
	$(function (){
		$('#dm1_textarea').height(1).height( $(this).prop('scrollHeight') );
		$(document).click(function(e){
        	if(e.target.id != 'dm1_pic_btn') {   
		       	if($(".select_pic").has(e.target).length==0) {
		       		$('.select_pic').css('display', 'none');
		       	}
        	}
        });
		
       	$('.dm1_btn20').click(function (){
        	if($(".dm1_selection").css('display')=='none') {
        		$('.dm1_selection').css('display','block');
        	} else {
        		$('.dm1_selection').css('display','none');
        	}
      	});
		
       	var textEle = $('#dm1_textarea');
    	textEle.on('keydown', function() {
    		$(this).height(1).height( $(this).prop('scrollHeight') );	
      	});
    	
    	$(document).on("click", '.dm1_list', function(){ //????????? ???????????? ???????????? ????????? ????????? ??????
            var name = $(this).text();
    		var picture = $(this).find('.pi').attr("style");
    		var memberId = $(this).attr("memberId");
            $("#pic_sel").removeClass("dm1_hidden");
            $("#pic_sel").attr("style", picture);
            $("#pic_sel").css("display", "block");
            $("#pic_sel").attr("memberId", memberId);
            $('.dm1_pic_btn').html(name).css("color", "rgb(0, 0, 0)");
            $('.select_pic').css('display', 'none');
            $("#dm1_svg111").css("display", "block");
        });
    	
    	$(document).on("click", '.dm1_pic_btn', function (e){
    		if($('.select_pic').css('display')=='none') {
	        	$('.select_pic').css('display', 'block');
	        	$('.dm1_pic_btn').html("????????? ??????").css("color", "rgb(193, 193, 193)");
	        	$("#dm1_svg111").css("display", "none");
	        	$("#pic_sel").addClass("dm1_hidden");
    		} else {
        		$('.select_pic').css('display','none');
    		}
      	});
    	
    	
    	$("#dm1_file2").click(function(){
    		alert("??????????????????.");
    	});
    	
    	$('#dm1_file0').click(function(e){
    		e.preventDefault();
    		$('.dm1_selection').css('display','none');
    		$('#dm1_file').click();
    	});
    	
    	
    	$('.dm1_file_container2').hover(function(){
    		$('.dm1_file_container4').css('opacity', '1');
    	}, function(){
    		$('.dm1_file_container4').css('opacity', '0');
    	});

    	
    	//???????????? ????????? ?????? 
	   $(".dm1_dropdown").click(function() {
        	var px = $(this).offset().left;	// ????????? ???????????? ?????? 
        	var py = $(this).offset().top+ 25;
        	$(".workspace_list").css('left',px+'px');
        	$(".workspace_list").css('top',py+'px');
			$(".workspace_list").css('display', 'block');
			$("#dm1_div_background").css('display', 'block');
	        $(".dm1_bottom_box5>span").html("?????? ??????").css("color", "rgb(136, 136, 136)");
	        $("dm1_bottom_box_svg1").css({visibility:"hidden", opacity:0});
		});

      	$("#dm1_div_background").click(function() {
        	$("#dm1_div_background").css('display', 'none');
      		$(".workspace_list").css('display', 'none');
      	});
	    $(".workspace_list > ul > li ").click(function(){ //????????? ???????????? ???????????? ????????? ????????? ??????
	        // .input_workspace_name ??? workspace_name ??????
	        var workspace1 = $(this).find("span").text();
	        //alert(workspace1);
	        //$(".input_workspace_name").val(workspace1);
	        // workspace_id input??? ??????
	        var workspace_id = $(this).find(".workspace_id_dm1_modal").text();
	        //alert(workspace_id);
	        $(".input_workspace_id").val(workspace_id);
	        //var workspace = $(this).text();
	        if(workspace1=="???????????? ??????"){ //???????????? ???????????? ??? ??????. 
	           $(".dm1_bottom_box5>span").html("???????????? ??????").css('color', 'rgb(217, 173, 43)');
	           $(".dm1_dropdown").css('border', "1px solid rgb(217, 173, 43)");
	           $(".dm1_btn21").css({border:"1px solid rgb(217, 173, 43)", 'background-color':"rgb(217, 173, 43)"});
	           $(".dm1_bottom_box_svg1").css("fill","rgb(217, 173, 43)");
	        } else{
	        	$(".dm1_bottom_box5>span").html(workspace1).css('color', 'rgb(51, 132, 108)');
	        	$(".dm1_dropdown").css('border', "1px solid rgb(51, 132, 108)");
	            $(".dm1_btn21").css({border:"1px solid rgb(51, 132, 108)", 'background-color':"rgb(51, 132, 108)"});
	            $(".dm1_bottom_box_svg1").css("fill","rgb(51, 132, 108)");
	        }
	        $("#dm1_div_background").css('display', 'none');
      		$(".workspace_list").css('display', 'none');
	        $("#workspace_container_arrow").css({visibility:"visible", opacity:1});
	    });

	    $(".workspace_list li").hover(function (){
	        $(this).css("background-color", "rgb(242,242,242)");
	    }, function(){
	        $(this).css("background-color", "rgb(255, 255, 255)");
	    });
	});
	</script>
</head>
<body style="overflow-y: hidden">
	<div class="workspace_list">
		<ul class="left-bar icon_color" id="dm1_ul">
			<li style="margin-bottom: 0px;">?????? ??????</li>
			<%
				for(int i = 0; i<list2.size(); i++){
			%>
			<li>
				<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M14.027 5L13.6 3H4v18h2v-7h6l.533 2H20V5z"></path></svg>
				<span><%=list2.get(i).getWorkspace_name() %></span>
				<div style="display: none;" class="workspace_id_dm1_modal"><%=list2.get(i).getWorkspace_id() %></div>
			</li>
			<%
				}
			%>
		</ul>
	</div>
	<div id="dm1_div_background"></div>


    <div id="myModal" class="dm1_modal">
      <div class="dm1_modal-content">
      <div class="dm1_modal_header">
      	<span>???????????? ??????</span>
        <span class="dm1_close">&times;</span>       
      </div> 
      <form action="Controller?command=dm1_write_action">                                                     
      <div class="dm1_modal_body">
      	<div class="dm1">
      		<svg style="margin-top: 4px; margin-right: 4px; fill: rgb(193, 193, 193);" viewBox="0 0 24 24" width="24px" height="24px"><path d="M2.833 4h13.75c.633 0 1.128.32 1.458.807L23 12.25l-4.96 7.434c-.33.486-.888.816-1.52.816H2.832A1.839 1.839 0 0 1 1 18.667V5.833C1 4.825 1.825 4 2.833 4zm11.917 9.625c.76 0 1.375-.614 1.375-1.375 0-.76-.614-1.375-1.375-1.375-.76 0-1.375.614-1.375 1.375 0 .76.614 1.375 1.375 1.375zm-4.583 0c.76 0 1.375-.614 1.375-1.375 0-.76-.614-1.375-1.375-1.375s-1.375.614-1.375 1.375c0 .76.614 1.375 1.375 1.375zm-4.584 0c.761 0 1.375-.614 1.375-1.375 0-.76-.614-1.375-1.375-1.375-.76 0-1.375.614-1.375 1.375 0 .76.614 1.375 1.375 1.375z" color="#C1C1C1" class="Beecon__Path-sc-3x6pq4-1 dBeMQs"></path></svg>
      		<textarea id="dm1_textarea" name = "dm_title" maxlength="1001" placeholder="?????? ?????? ??????????????????. @?????????" class="dm1_textbox"></textarea>
      	</div>
      	<div class="dm1_modal_mid">
      	<div class="dm1_pii" id="pic_sel">
      	</div>
      	<div>
      		<button type="button" class="dm1_pic_btn" id="dm1_pic_btn" memberId="">????????? ??????</button>
      	</div>
      	<div class="dm1_svg_box">
      		<svg viewBox="0 0 24 24" width="16px" height="16px" id="dm1_svg111"><path d="M17.0278306,8 C18.1356358,8 18.40014,8.63354932 17.6171348,9.41655445 L13.4502437,13.5834455 C12.6679023,14.365787 11.40014,14.3664507 10.6171348,13.5834455 L6.45024373,9.41655445 C5.66790231,8.63421303 5.93074941,8 7.03954794,8 L17.0278306,8 Z"></path></svg>
      	</div>
      	</div>
      <div class="select_pic" id="selectpic">
	<%
		for(int i = 0; i<list1.size(); i++){
			if(list1.get(i).getPicture() != null){
			%>   	
			   	<div class="dm1_list" memberId="<%= list1.get(i).getMy_partner() %>">
			   		<button class="pi" style="background-image : url(<%= list1.get(i).getPicture() %>)"></button><span class="dm1_name"><%=list1.get(i).getName() %></span>
			   	</div>
			<%
			}else{
			%>   	
			   	<div class="dm1_list" memberId="<%= list1.get(i).getMy_partner() %>">
			   		<button class="pi" style="background-image : url(https://down.collabee.co/userProfile/1)"></button><span class="dm1_name"><%=list1.get(i).getName() %></span>
			   	</div>
			<%
			}
		}
	%>   	
	</div>
<!-- ?????????????????????????????? -->
      </div>
      
     <div class="dm1_modal_footer">
     <button type="button" class="dm1_btn20" id="dm1_btn20">
     <svg fill="rgb(136, 136, 136)" viewBox="0 0 24 24" width="21px" height="21px"><path d="M16.5 6v11.5c0 2.21-1.79 4-4 4s-4-1.79-4-4V5a2.5 2.5 0 0 1 5 0v10.5c0 .55-.45 1-1 1s-1-.45-1-1V6H10v9.5a2.5 2.5 0 0 0 5 0V5c0-2.21-1.79-4-4-4S7 2.79 7 5v12.5c0 3.04 2.46 5.5 5.5 5.5s5.5-2.46 5.5-5.5V6h-1.5z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
     </button>
     <div class="dm1_bottom_box">
     <div class="dm1_bottom_box2">
     	<div class="dm1_dropdown">
     		<div class="dm1_bottom_box3">
     			<div class="dm1_bottom_box4">
     				<div class="dm1_bottom_box5">
     				<input type="hidden" class="input_workspace_id" name="workspaceId"/>
     					<span>???????????? ??????</span>
     					<svg viewBox="0 0 24 24" width="16px" height="16px" class="dm1_bottom_box_svg1"><path d="M17.0278306,8 C18.1356358,8 18.40014,8.63354932 17.6171348,9.41655445 L13.4502437,13.5834455 C12.6679023,14.365787 11.40014,14.3664507 10.6171348,13.5834455 L6.45024373,9.41655445 C5.66790231,8.63421303 5.93074941,8 7.03954794,8 L17.0278306,8 Z"></path></svg>
     				</div>
     			</div>
     		</div>
     	</div>
     </div>
     <button type="submit" class="dm1_btn21">??????</button>
     </div>
     </div>
     </form>  
     
     
     <div class="dm1_selection" id="dm1_selection">
      <span class="dm1_ff">?????? ??????</span>
      <form method="post" enctype="multipart/form-data">
      	<input type="file" id="dm1_file" name="file" onchange="uploadFile(this)" style="display: none;" multiple/>
      	<button class="dm1_file1" id="dm1_file0">??? ??????????????? ??????</button></form>
     	<button class="dm1_file1" id="dm1_file2">?????? ?????????????????? ??????</button>
     </div>
     
      </div>
    </div>
    
	<script>
	    var modal = document.getElementById('myModal');
	    var span = document.getElementsByClassName("dm1_close")[0];
	    var piclist = document.getElementById("selectpic");
	    var filelist = document.getElementById("dm1_selection");
	    	
	    btn.onclick = function(e){
	        modal.style.display = "block";
	    }
	    span.onclick = function(e){
	        modal.style.display = "none";
	        piclist.style.display = "none";
            filelist.style.display = "none";
	    }
	    window.onclick = function(event) {
	        if (event.target == modal) {
	        	alert("?????? ?????? ??????????????? ???????????? ?????? ??????????????????????");
	            modal.style.display = "none";
	            piclist.style.display = "none";
	            filelist.style.display = "none";
	        }
	    }
	</script>
      	<!-- <ul class="dm1_file_container3">
      		<li class="dm1_file_container2">
      			<div class="dm1_file_container1">
      				<svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewBox="0 0 24 24"><g fill="none" fill-rule="evenodd"><path fill="#888888" d="M6 2c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6H6zm7 7V3.5L18.5 9H13z"></path></g></svg>
      				<span class="dm1_file_container0">Zoom</span>
      			</div>
      			<div class="dm1_file_container4">
      				<button type="button" style="background-color: transparent">
      					<svg viewBox="0 0 24 24" width="20px" height="20px" class="file_svg1"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"></path></svg>
      				</button>
      			</div>
      		</li>
      	</ul> -->	
</body>
</html>