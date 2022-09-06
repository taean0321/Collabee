<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>corporation2</title>
	<link rel="icon" href="Images/favicon.ico" type="image/x-icon">
	<script src="js/jquery-3.6.0.min.js"></script>
	<style>
		a{
			text-decoration: none;
			color: black;
		}
		.chosen{
			font-weight: bold;
			color: color: rgb(34, 34, 34);
			fill: rgb(34, 34, 34);
			background: rgb(242, 242, 242);
		}
		body{
			font-family: -apple-system,BlinkMacSystemFont,Malgun Gothic,Hiragino Kaku Gothic ProN,Hiragino Sans,Meiryo,MS PGothic,sans-serif,Dotum;
		}
		ul{
			padding-left: 20px;
			list-style-type: none;
			font-size: 13px;
			z-index: 1;
		}
		form{
			flex: 1 0 auto;
		}
		li a{
			text-decoration: none;
			display: block;
			line-height: 2.0;
			color: rgb(34, 34, 34);
			fill: rgb(117, 114, 111);
		}
		li a:hover{
			font-weight: bold;
			color: color: rgb(34, 34, 34);
			fill: rgb(34, 34, 34);
			background: rgb(242, 242, 242);
		}
		.cor1_title{
			font-size: 11px;
    		color: rgb(136, 136, 136);
		}
		.foot{
			font-size: 13px;
			color: rgb(136, 136, 136);
			z-index: 3;
			margin-left: 20px;
			bottom: 30px;
			position: fixed;
		}
		.sidebar{
			margin-top: 60px;
			background-color: rgb(250, 250, 250);
			border-right: 1px solid rgb(225, 225, 225);
			box-sizing: border-box;
			width: 200px;
    		height: 100%;
			position: fixed;
			display: fixed;
			float: left;
			flex-direction: column;
			z-index: 0;
			float: left;
		}
		header{
			position: fixed;
			top: 0px;
			width: 100%;
    		height: 68px;
    		background-color: #FFFFFF;
    		border-bottom: 1px solid rgb(225, 225, 225);
    		z-index: 5;
		}
		.cor_menu{
			padding-top: 20px;
			right: 20px;
			position: fixed;
		}
		.menu_item{
			float: left;
			font-weight: bold;
			font-size: 14px;
			padding: 6px 12px;
		}
		.menu_item1{
			color: gray;
		}
		.menu_item1:hover{
			color: rgb(34, 34, 34);
		}
		.direct{
			color: rgb(204, 153, 0);
		}
		.direct:hover{
			color: rgb(179, 142, 34);
		}
		.cor1_btn1{
			width: 30px;
			height: 30px;
			border-radius: 4px;
			cursor: pointer;
			border: lightgrey;
			float: left;
			margin-top: 20px;
			margin-left: 20px;
			background-color: rgba(0, 0, 0, 0.1);
			transition: border-color 0.3s ease 0s;
			position: relative;
		}
		.cor1_btn1:hover::after{
			border: 1px solid rgb(204, 153, 0);
		}
		.cor1_btn1::before{
			position: absolute;
			width: 30px;
			height: 30px;
    		display: block;
		    inset: 0px;
		    background-color: rgb(255, 255, 255);
		    border-radius: 4px;
		    background-image: url(https://down.collabee.co/companyLogoNo/0);
		    background-size: cover;
		    background-position: center center;
		    content: "";
		}
		.samsung::before{
			background-image: url(https://down.collabee.co/companyLogoNo/3104738);
		}
		.cor1_btn1::after{
			position: absolute;
			width: 30px;
			height: 30px;
		    display: block;
		    inset: 0px;
		    border-radius: 4px;
		    content: "";
		    border: 1px solid rgba(0, 0, 0, 0.1);
		    background-color: transparent;
		    transition: border-color 0.3s ease 0s, background-color 0.3s ease 0s;
		}
		h1{
			margin-top: 20px;
			float: left;
			font-size: 18px;
			color: rgb(34, 34, 34);
			margin-left: 8px;
    		white-space: nowrap;
    		overflow: hidden;
    		text-overflow: ellipsis;
		}
		.cor1_btn2{
			flex-shrink: 0;
		    position: relative;
		    width: 38px;
		    height: 38px;
		    border-radius: 50%;
		    padding: 1px;
		    background-color: rgba(0, 0, 0, 0.1);
		    content: "";
		    transition: border-color 0.3s ease 0s;
		    cursor: pointer;
		    border: none;
		}
		.cor1_btn2::before{
			position: absolute;
		    display: block;
		    top: 0px;
		    left: 0px;
		    background-color: rgb(255, 255, 255);
		    transform: translate(1px, 1px);
		    width: 38px;
		    height: 38px;
		    background-image: url(https://down.collabee.co/userProfile/-1);
		    border-radius: 50%;
		    background-size: cover;
		    background-position: center center;
		    content: "";
		}
		.yr::before{
			background-image: url(https://down.collabee.co/userProfile/2972613);
		}
		.cor1_btn2::after{
			position: absolute;
		    display: block;
		    top: 0px;
		    left: 0px;
		    width: 36px;
		    height: 36px;
		    border-radius: 50%;
		    content: "";
		    border: 2px solid rgba(0, 0, 0, 0);
		    transition: border-color 0.3s ease 0s;
		}
		.cor1_btn2:hover::after{
			border-color: rgb(217, 173, 43);
		}
		.nickname{
			display: inline-block;
		    font-size: 14px;
		    font-weight: bold;
		    transition: color 0.2s ease 0s;
		    color: rgb(136, 136, 136);
		    padding-top: 2px;
		    padding-bottom: 2px;
		}
		.nickname:hover{
			color: rgb(34, 34, 34);
		}
		.profile{
			display: flex;
		    flex-direction: row;
		    margin: 22px 22px 0px 24px;
		    padding-bottom: 22px;
		    border-bottom: 1px solid rgb(225, 225, 225);
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
		.section1{
			width: 820px;
			padding: 40px 40px 0;
			flex-direction: column;
			padding-top: 90px;
			margin-left: 200px;
			position: absolute;
		}
		.section2{
			width: 820px;
			flex-direction: column;
			position: absolute;
			padding: 40px 40px 0;
			margin-left: 200px;
			margin-top: 150px;
		}
		.btn1{
			float: right;
			color: rgb(255, 255, 255);
			text-align: center;
			border: 1px solid rgb(217, 173, 43);
			background-color: rgb(217, 173, 43);
			cursor: pointer;
			font-size: 14px;
    		line-height: 1.57;
    		margin-top: 14px;
    		padding: 10px 18px;
    		border-radius: 4px;
		}
		.btn1:hover{
			filter: brightness(80%);
			transition: transform 10s;
		}
		h2{
			font-size: 14px;
    		font-weight: bold;
    		line-height: 1.57;
    		color: rgb(34, 34, 34);
		}
		.expl{
			display: block;
    		margin-top: 4px;
    		font-size: 12px;
    		line-height: 1.5;
    		color: rgb(83, 83, 83);
		}
		.search{
			width: 800px;
			border: 1px solid rgb(225, 225, 225);
    		font-size: 14px;
    		color: rgb(34, 34, 34);
    		border-radius: 4px;
    		padding: 10px;
    		transition: border-color 0.2s ease 0s;
    		height: 20px;
		}
		.search:focus {outline: none; border: 1px solid rgb(204, 153, 0);}
		table{
			width: 800px;
			margin-top: 42px;
			table-layout: fixed;
			border-collapse: collapse;
		}
		th{
    		text-align: left;
    		border-bottom: 1px solid rgb(225, 225, 225);
    		font-size: 12px;
    		font-weight: bold;
    		line-height: 1.5;
    		color: rgb(34, 34, 34);
    		padding: 6px 6px 8px 8px;
		}
		td{
			padding: 10px 0px 10px 8px;
    		border-bottom: 1px solid rgb(225, 225, 225);
    		text-align: left;
    		font-size: 14px;
    		line-height: 1.57;
    		color: rgb(34, 34, 34);
		}
		.picture{
			position: relative;
			width: 34px;
    		height: 34px;
    		border-radius: 50%;
    		padding: 1px;
    		cursor: pointer;
    		border: 1px solid rgba(0, 0, 0, 0.1);
    		content: "";
    		flex-shrink: 0;
		}
		.picture::after{
			position: absolute;
		    display: block;
		    top: 0px;
		    left: 0px;
		    background-color: rgb(255, 255, 255);
		    transform: translate(2px, 2px);
		    width: 32px;
		    height: 32px;
		    border-radius: 50%;
		    background-image: url(https://down.collabee.co/userProfile/-1);
		    background-size: cover;
		    background-position: center center;
		    content: "";
		}
		.picture:hover::after {
			transform: translate(1px, 1px);
		}
		/* .picture::after{
			position: absolute;
		    display: block;
		    top: 0px;
		    left: 0px;
		    width: 32px;
		    height: 32px;
		    border-radius: 50%;
		    content: "";
		    transition: border-color 0.3s ease 0s;
		} */
		.picture:hover{
			border: 2px solid rgb(217, 173, 43);
			width: 32px;
    		height: 32px;
		}
		.yr::after{
			background-image: url(https://down.collabee.co/userProfile/2972613);
		}
		.jh::after{
			background-image: url(https://down.collabee.co/userProfile/2972655);
		}
		.ta::after{
			background-image: url(https://down.collabee.co/userProfile/2972573);
		}
		.name{
			display: block;
		    font-size: 14px;
		    line-height: 1.57;
		    color: rgb(136, 136, 136);
		}
		.email{
			overflow: hidden;
		    display: block;
		    font-size: 12px;
		    line-height: 1.5;
		    color: rgb(83, 83, 83);
		    text-overflow: ellipsis;
		}
		.blank{
			padding: 10px 0px 10px 8px;
		    border-bottom: 1px solid rgb(225, 225, 225);
		    text-align: right;
		    font-size: 14px;
		    line-height: 1.57;
		}
		.btn2{
			line-height: 1.5;
		    background-color: transparent;
		    cursor: pointer;
		    transition: color 0.2s ease 0s, background-color 0.2s ease 0s;
		    color: rgb(204, 153, 0);
		    font-size: 14px;
    		padding: 5px;
    		border: none;
    		box-sizing: border-box;
		}
		.btn3{
			cursor: pointer;
			background-color: transparent;
		    text-decoration: none;
		    display: inline-block;
		    vertical-align: middle;
		    shape-rendering: inherit;
		    fill: rgb(136, 136, 136);
		    border: none;
		}
		.btn3:hover{
			filter: brightness(80%);
			transition: transform 10s;
		}
		.selection{
			width: 190px;
		    flex-direction: column;
		    border-radius: 4px;
		    box-shadow: rgb(0 0 0 / 10%) 0px 0px 6px 2px;
		    background-color: rgb(255, 255, 255);
		    padding: 12px 0px;
		}
		.menubar{
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
		.menubar:hover{
			filter: brightness(90%);
			transition: transform 10s;
		}
		#divToggle1 {
			display: none;
			position: absolute;
			background-color: white;
		    z-index: 101;
		}
		#div_background {
			display: none;
			z-index: 100;
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
		.modal_background{
			top: 0;
		    left: 0;
		    right: 0;
		    bottom: 0;
		    z-index: 1300;
		    position: fixed;
		    background-color: rgba(0,0,0,0.5);
		    height: 100%;
		    outline: none;
		    display: none;
		    align-items: center;
		    justify-content: center;
		}
		.cor2_modal{
			position: absolute;
		    inset: 50% auto auto 50%;
		    border: 1px solid rgb(204, 204, 204);
		    background: rgb(255, 255, 255);
		    overflow: auto;
		    border-radius: 4px;
		    outline: none;
		    padding: 0px;
		    margin-right: -50%;
		    transform: translate(-50%, -50%);
		}
		.cor2_modal_body{
			display: flex;
		    flex-direction: column;
		    width: 540px;
		    min-height: 229px;
		    padding: 27px 28px;
		    z-index: 110;
	    }
	    .cor2_modal_title{
		    font-size: 16px;
		    font-weight: bold;
		    line-height: 1.5;
		    color: rgb(34, 34, 34);
		    display: flex;
		    flex-direction: row;
	    }
	    .close {
	        color: #aaa;
	        float: right;
	        font-size: 28px;
	        font-weight: bold;
	        margin-top: -15px;
	    }
	    .close:hover, .close:focus {
	        color: black;
	        text-decoration: none;
	        cursor: pointer;
	    }
	    .cor2_modal_header{
		    font-weight: bold;
		    color: rgb(136, 136, 136);
		    display: flex;
		    flex-direction: row;
		    -webkit-box-pack: justify;
		    justify-content: space-between;
		    -webkit-box-align: center;
		    align-items: center;
		}
		.cor2_modal_content_title{
			margin-top: 32px;
		    color: rgb(34, 34, 34);
		    font-size: 12px;
		    line-height: 1.5;
		    overflow-wrap: break-word;
		}
		.cor2_modal_date{
			font-size: 12px;
		    line-height: 18px;
		    color: #888;
		}
		.modal_content_text{
			height: 100%;
		    display: flex;
		    flex-direction: column;
		    -webkit-box-pack: start;
		    justify-content: flex-start;
		}
		.modal_box1{
			position: relative;
		    padding-top: 32px;
		    padding-bottom: 0px;
		}
		.will_changePW{
			font-size: 12px;
		    font-weight: bold;
		    line-height: 1.5;
		    color: rgb(136, 136, 136);
		}
		.changePW_input{
			width: 100%;
		    border-top: none;
		    border-right: none;
		    border-left: none;
		    border-image: initial;
		    border-radius: 0px;
		    transition: border-bottom-color 0.2s ease 0s;
		    border-bottom: 1px solid #d9d9d9;
		    font-size: 14px;
		    line-height: 1.5;
		    color: rgb(34, 34, 34);
		    padding-top: 10px;
		    padding-bottom: 10px;
		    margin-bottom: 0px;
		}
		.changePW_input:focus{
			outline: none;
		}
		.changePW_warning{
			padding-top: 4px;
		    position: absolute;
		    font-size: 12px;
		    line-height: 1.5;
		    color: rgb(237, 84, 84);
		    opacity: 0;
		}
		.modal_footer{
			display: flex;
		    flex-direction: row;
		    -webkit-box-align: center;
		    align-items: center;
		    -webkit-box-pack: end;
		    justify-content: flex-end;
		    margin-top: 55px;
		}
		.changePW_btn{
			font-size: 14px;
		    line-height: 1.57;
		    padding: 10px 32px;
		    position: relative;
		    min-height: inherit;
		    color: rgb(255, 255, 255);
		    font-weight: 500;
		    border-radius: 4px;
		    text-align: center;
		    transition: background-color 0.2s ease 0s, color 0.2s ease 0s, border-color 0.4s ease 0s, fill 0.2s ease 0s, opacity 0.2s ease 0s;
		    border-width: 1px;
		    border-style: solid;
		    border-color: rgb(217, 173, 43);
		    background-color: rgb(217, 173, 43);
		    cursor: pointer;
		    opacity: 1;
		    width: auto;
		    box-shadow: none;
		}
		.changePW_btn:hover{
			background-color: rgb(179, 142, 34);
    		border-color: rgb(179, 142, 34);
		}
	</style>
	<script>
		$(function(){
			$("#changePW_input1").keyup(function(){
				var content = $(this).val();
				if(content.length == 0){
					//alert("1");
					$("#changePW_warning1").css("opacity", "1");
					$(this).css("border-bottom", "1px solid red");
					$("#changePW_warning1").html("비밀번호를 입력해주세요.");
				}else if(1 <= content.length < 6){
					//alert("3");
					$("#changePW_warning1").css("opacity", "1");
					$("#changePW_warning1").html("비밀번호는 영문, 숫자 혼합하여 6자 이상 입력해 주세요.");
					$(this).css("border-bottom", "1px solid red");
				}else{
					//alert("4");
					$("#changePW_warning1").css("opacity", "0");
					$(this).css("border-bottom", "1px solid #d9d9d9");
					$("#changePW_warning1").html("비밀번호를 입력해주세요.");
				}
			});
			
			$("#changePW_input1").focusout(function(){
				var content = $(this).val();
				if(content.length == 0){
					//alert("1");
					$("#changePW_warning1").css("opacity", "1");
					$(this).css("border-bottom", "1px solid red");
					$("#changePW_warning1").html("비밀번호를 입력해주세요.");
				}else if(1 <= content.length < 6){
					//alert("3");
					$("#changePW_warning1").css("opacity", "1");
					$("#changePW_warning1").html("비밀번호는 영문, 숫자 혼합하여 6자 이상 입력해 주세요.");
					$(this).css("border-bottom", "1px solid red");
				}else{
					//alert("4");
					$("#changePW_warning1").css("opacity", "0");
					$(this).css("border-bottom", "1px solid #d9d9d9");
					$("#changePW_warning1").html("비밀번호를 입력해주세요.");
				}
			});
			
			$('.btn2').click(function(){
				var emailMe = $(this).parent().parent().find(".email").text();
 				if(confirm(emailMe + "님의 회사초대를 취소하시겠습니까?")==true){
					alert(emailMe + "님의 초대취소가 처리되었습니다.");
				}else{
					return;
				}
 			});
		
          	$('.btn3').click(function (){
            	//$("#divToggle").toggle();  --> class
            	//$(this).parent().find(".divToggle").css('display','block');
            	var px = $(this).offset().left;
            	var py = $(this).offset().top + 30;
            	$("#divToggle1").css('left',px+'px');
            	$("#divToggle1").css('top',py+'px');
            	//$("#divToggle1").offset({left:px, top:py});
            	$("#div_background").css('display', 'block');
				$("#divToggle1").css('display', 'block');
				
				var email = $(this).parent().parent().find(".email").text();
				var name = $(this).parent().parent().find(".name").text();
				//alert(email);
				$("#divToggle1").attr('email', email);
				$("#divToggle1").attr('name', name);
           });
          	$("#div_background").click(function() {
            	$("#div_background").css('display', 'none');
          		$("#divToggle1").css('display', 'none');
          	});
          	$(".menubar").click(function() {
          		var idx = $(this).index();
          		var emailMe = $(this).parent().attr('email');
          		var myName = $(this).parent().attr('name');
          		$("#div_background").css('display', 'none');
          		$("#divToggle1").css('display', 'none');
          		//alert(myName);
          		if(idx==0) {
          			// 회사관리자해제 혹은 회사관리자설정 alert("회사 관리자로 설정하시겠습니까?");
          			alert("회사 관리자 권한을 해제하시겠습니까? 해제 시, 회사를 관리할 수 없게 됩니다.");
          		} else if(idx==1) {
          			// 회원탈퇴
          			alert(emailMe + "를 회원탈퇴!");
          		} else if(idx==2) {
          			// 비밀번호초기화
          			$('.modal_background').css("display", 'block');
    	        	$('.cor2_modal_content_title').html("<b>" + myName + "(" + emailMe + ")</b> 님의 새 비밀번호를 설정해 주세요. 새 비밀번호 설정 시 기존에 로그인 된 모든 기기에서 로그아웃됩니다. 비밀번호는 영문과 숫자 조합으로 6자 이상 입력해 주세요.");
          		}
          	});
       	});
	</script>
</head>
<body>
	<div id="div_background"></div>
<header>
<div>
<button class="cor1_btn1 samsung" onClick=""></button><a href=""><h1>샘숭</h1></a>
</div>
<div class="cor_menu">
	<div class="menu_item"><a class="menu_item1" href="help1.html" target="_blank">도움말</a></div>
	<div class="menu_item"><a class="menu_item1" href="">가격 안내</a></div>
	<div class="menu_item"><a href="main.html" class="direct">콜라비로 바로가기</a></div>
</div>
</header>
	<main>
		<div class="selection" id="divToggle1">
			<button class="menubar">회사 관리자 해제</button>
			<button class="menubar">회원 탈퇴</button>
			<button class="menubar">비밀번호 초기화</button>
		</div>
	
	<div class="sidebar">
	<div class="profile">
	<button class="cor1_btn2 yr" onClick=""></button>
	<div><a class="nickname" href="0option1.jsp" style="padding-left:10px;">유라짱짱<br/>
	<span style="color: rgb(204, 153, 0); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 12px;">샘숭</span></a></div>
	<div style="padding: 10px;">
	</div>
	</div>
	
	<div>
	<ul>
		<li><p class="cor1_title">메뉴</p></li>
		<li><a href="0corporation1.jsp">
		<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M12 7V3H2v18h20V7H12zM6 19H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm4 12H8v-2h2v2zm0-4H8v-2h2v2zm0-4H8V9h2v2zm0-4H8V5h2v2zm10 12h-8v-2h2v-2h-2v-2h2v-2h-2V9h8v10zm-2-8h-2v2h2v-2zm0 4h-2v2h2v-2z" ></path></svg>
		회사 정보</a></li>
		<li class="chosen"><a href="0corporation2.jsp">
		<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z"></path></svg>
		동료 관리</a></li>
		<li><a href="0corporation3.jsp">
		<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M14.027 5L13.6 3H4v18h2v-7h6l.533 2H20V5z"></path></svg>
		협업공간 관리</a></li>
		<li><a href="0corporation4.jsp">
		<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1.41 16.09V20h-2.67v-1.93c-1.71-.36-3.16-1.46-3.27-3.4h1.96c.1 1.05.82 1.87 2.65 1.87 1.96 0 2.4-.98 2.4-1.59 0-.83-.44-1.61-2.67-2.14-2.48-.6-4.18-1.62-4.18-3.67 0-1.72 1.39-2.84 3.11-3.21V4h2.67v1.95c1.86.45 2.79 1.86 2.85 3.39H14.3c-.05-1.11-.64-1.87-2.22-1.87-1.5 0-2.4.68-2.4 1.64 0 .84.65 1.39 2.67 1.91s4.18 1.39 4.18 3.91c-.01 1.83-1.38 2.83-3.12 3.16z"></path></svg>
		결제</a></li>
		<li><p class="cor1_title">보안</p></li>
		<li><a href="0corporation5.jsp">
		<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M20,19 L20,21 L4,21 L4,19 L20,19 Z M15,3.1 C15.4970563,3.1 15.9,3.50294373 15.9,4 L15.9,4 L15.9,9.1 L19,9.1 C19.7653683,9.1 20.1660329,9.98330088 19.7077601,10.5567165 L19.7077601,10.5567165 L19.6363961,10.6363961 L12.6363961,17.6363961 C12.2849242,17.987868 11.7150758,17.987868 11.3636039,17.6363961 L11.3636039,17.6363961 L4.3636039,10.6363961 C3.79663552,10.0694277 4.19818563,9.1 5,9.1 L5,9.1 L8.1,9.1 L8.1,4 C8.1,3.54117882 8.44333667,3.16254822 8.88710591,3.10701228 L8.88710591,3.10701228 L9,3.1 Z M14.1,4.9 L9.9,4.9 L9.9,10 C9.9,10.4588212 9.55666333,10.8374518 9.11289409,10.8929877 L9.11289409,10.8929877 L9,10.9 L7.173,10.9 L12,15.727 L16.826,10.9 L15,10.9 C14.5411788,10.9 14.1625482,10.5566633 14.1070123,10.1128941 L14.1070123,10.1128941 L14.1,10 L14.1,4.9 Z"></path></svg>
		파일 다운로드 이력</a></li>
	</ul>
	<div class="foot">개인정보 처리방침<br/>
		이용 약관<br/>
		collabee Inc. © 2022</div>
	</div>
	</div>
	<div class="section1">
	<div class="top">
	<div style="float: left">
	<h2>동료 관리</h2>
	<p class="expl">회사에 소속된 동료를 관리할 수 있습니다.</p>
	</div>
	<button class="btn1">동료 초대하기</button>
	</div>
	</div>

	<div class="section2">
	<input type="text" placeholder="이름 또는 이메일 주소로 동료 검색" autocomplete="off" class="search"/>
	<table>
	<tr>
		<th style="width: 42px;"></th>
		<th style="width: 320px;">이름</th>
		<th style="width: 150px;">유형</th>
		<th style="width: 200px;">회사가입일</th>
		<th style="width: 36px;"></th>
	</tr>
	<tr>
		<td>
			<div class="picture"></div>
		</td>
		<td>
			<span class="name">정**</span>
			<span class="email">jminb1a4@gmail.com</span>
		</td>
		<td>가입 대기 중</td>
		<td colspan="2" class="blank">
		<button class="btn2">초대 취소</button>
		</td>
	</tr>
	<tr>
		<td>
			<div class="picture"></div>
		</td>
		<td>
			<span class="name"></span>
			<span class="email">yula2766@naver.com</span>
		</td>
		<td>가입 대기 중</td>
		<td colspan="2" class="blank">
		<button class="btn2">초대 취소</button>
		</td>
	</tr>
	<tr>
		<td>
			<div class="picture yr"></div>
		</td>
		<td>
			<span class="name">유라짱짱</span>
			<span class="email">yula27660@gmail.com</span>
		</td>
		<td>회사 관리자</td>
		<td>2022.4.11</td>
		<td>
			<button class="btn3">
			<svg viewBox="0 0 24 24" width="24px" height="24px"><path d="M6 10c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm12 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm-6 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"></path></svg>
			</button>
		</td>
	</tr>
	<tr>
		<td>
			<div class="picture jh"></div>
		</td>
		<td>
			<span class="name">강지현</span>
			<span class="email">twekyaak@gmail.com</span>
		</td>
		<td>동료</td>
		<td>2022.4.25</td>
		<td>
		<button class="btn3">
		<svg viewBox="0 0 24 24" width="24px" height="24px"><path d="M6 10c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm12 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm-6 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"></path></svg>
		</button>
		</td>
	</tr>
	<tr>
		<td>
			<div class="picture ta"></div>
		</td>
		<td>
			<span class="name">강태안</span>
			<span class="email">taean0321@gmail.com</span>
		</td>
		<td>동료</td>
		<td>2022.4.25</td>
		<td>
		<button class="btn3">
		<svg viewBox="0 0 24 24" width="24px" height="24px"><path d="M6 10c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm12 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm-6 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"></path></svg>
		</button>
		</td>
	</tr>
	<tr>
		<td>
			<div class="picture"></div>
		</td>
		<td>
			<span class="name">깡</span>
			<span class="email">rkdxodks1@naver.com</span>
		</td>
		<td>동료</td>
		<td>2022.5.24</td>
		<td>
		<button class="btn3">
		<svg viewBox="0 0 24 24" width="24px" height="24px"><path d="M6 10c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm12 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm-6 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"></path></svg>
		</button>
		</td>
	</tr>
	</table>
	</div>
	</main>
	
	<div class="modal_background">
		<div class="cor2_modal">
			<div class="cor2_modal_body">
				<div class="cor2_modal_header">
					<span class="cor2_modal_title">비밀번호 초기화</span>
					<span class="close">&times;</span>
				</div>
				<div class="cor2_modal_content">
					<div class="cor2_modal_content_title"></div>
					<div class="modal_content_text">
						<div class="modal_box1">
							<label class="will_changePW">변경할 비밀번호</label>
							<input type="password" id="changePW_input1" class="changePW_input" size="14" placeholder="숫자, 영문 조합 최소 6자 이상" autocomplete="new-password"/>
							<div class="changePW_warning" id="changePW_warning1">비밀번호를 입력해주세요.</div>
						</div>
						<div class="modal_box1">
							<label class="will_changePW">비밀번호 재입력</label>
							<input type="password" id="changePW_input2" class="changePW_input" size="14" placeholder="비밀번호를 다시 한 번 입력해주세요" autocomplete="new-password"/>
							<div class="changePW_warning">비밀번호를 입력해주세요.</div>
						</div>
						<div class="modal_footer">
							<button class="changePW_btn" id="changePW_warning2">비밀번호 초기화하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	<script>
		var modal_background = document.getElementsByClassName("modal_background")[0];
		var close = document.getElementsByClassName("close")[0];
		
		close.onclick = function(e){
	        modal_background.style.display = "none";
	    }
		window.onclick = function(e){
			if(e.target == modal_background){
				modal_background.style.display = "none";
			}
		}
	</script>	
	
</body>
</html>