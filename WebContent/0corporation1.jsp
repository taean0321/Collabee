<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>corporation</title>
	<link rel="icon" href="Images/favicon.ico" type="image/x-icon">
	<script src="js/jquery-3.6.0.min.js"></script>
	<style>
		a{
			text-decoration: none;
			color: black;
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
		.chosen{
			font-weight: bold;
			color: color: rgb(34, 34, 34);
			fill: rgb(34, 34, 34);
			background: rgb(242, 242, 242);
		}
		.title{
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
		.menu{
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
		.btn1{
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
		.btn1:hover::after{
			border: 1px solid rgb(204, 153, 0);
		}
		.btn1::before{
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
		.btn1::after{
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
		.btn2{
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
		.btn2::before{
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
		.btn2::after{
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
		.btn2:hover::after{
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
		.section1{
			flec-direction: column;
			padding: 40px 40px 0;
			margin-top: 70px;
			margin-left: 200px;
			position: absolute;
			max-width: 820px;
		}
		.container1{
			dispaly: flex;
			flex-direction: row;
		}
		.square{
			float: left;
			border-radius: 4px;
			border: 1px solid lightgray;
			width: 114px;
			height: 114px;
			cursor: pointer;
			background-color: transparent;
			background-repeat: no-repeat;
			background-size: cover;
    		background-position: center center;
			background-image: url(https://down.collabee.co/companyLogoNo/3104738);
		}
		.square::after{
			width: 114px;
		    height: 114px;
		    position: absolute;
		    inset: 41px 41px;
		    content: "";
		    display: block;
		    border-radius: 4px;
		    box-sizing: border-box;
    		background-image: linear-gradient(rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.05) 29%, rgba(0, 0, 0, 0.2) 61%, rgba(0, 0, 0, 0.6));
    	}
		.btn3{
			position: absolute;
		    margin-left: 40px;
		    margin-top: 40px;
		    border: none;
		    z-index: 2;
		    inset: 0px;
		    width: 114px;
		    height: 114px;
		    cursor: pointer;
		    display: flex;
		    flex-direction: column;
		    -webkit-box-pack: end;
		    justify-content: flex-end;
		    -webkit-box-align: center;
		    align-items: center;
		    border-radius: 4px;
		    background-color: transparent;
		    transition: border-color 0.2s ease 0s, background-color 0.3s ease 0s;
		}
		.square:hover::after{
			background-color: rgba(0, 0, 0, 0.03);
    		border: 1px solid rgb(217, 173, 43);
		}
		.spam{
			padding-bottom: 10px;
		    font-size: 14px;
		    color: rgb(255, 255, 255);
		    text-shadow: rgb(0 0 0 / 50%) 1px 1px 2px;
		    box-sizing: border-box;
		}
		.container2{
			font-weight: bold;
			display: flex;
			flex-direction: row;
			font-size: 14px;
    		line-height: 1.3;
    		color: rgb(136, 136, 136);
    		padding-top: 10px;
		}
		.container2_0{
			padding-left: 140px;
			padding-top: 10px;
			
		}
		.h2{
			font-size: 28px;
    		line-height: 1.0;
    		color: rgb(34, 34, 34);
    		word-break: break-word;
    		font-weight: bold;
		}
		.container2_1{
			display: flex;
			flex-direction: row;
			overflow: hidden;
			margin-top: 4px;
		}
		.btn4{
			width: 150px;
			height: 30px;
			font-size: 13px;
			font-weight: 500;
    		border-radius: 4px;
    		text-align: center;
    		color: rgb(204, 153, 0);
    		background-color: transparent;
    		border: 1px solid rgb(217, 173, 43);
    		cursor: pointer;
		}
		.btn4:hover{
			background-color: transparent;
		    color: rgb(179, 142, 34);
		    border-color: rgb(179, 142, 34);
		}
		.section2{
    		flex-direction: column;
			padding: 40px 40px 0;
			margin-top: 250px;
			margin-left: 200px;
			position: absolute;
			max-width: 820px;
		}
		.section2_1{
			display: flex;
		    flex-direction: row;
		    -webkit-box-align: center;
		    align-items: center;
		    border-bottom: 1px solid rgb(225, 225, 225);
		}
		label{
			color: rgb(136, 136, 136);
    		font-weight: bold;
    		font-size: 12px;
    		padding-left: 10px;
		}
		.cname{
    		width: 100%;
		    border: none;
		    border-radius: 0px;
		    padding: 10px;
		    font-size: 16px;
		    line-height: 1.5;
		    color: rgb(34, 34, 34);
		}
		.btns{
			dispaly: flex;
			flex-direction: row;
			margin-bottom: -21px;
		}
		.btn10{
			font-size: 14px;
	    	line-height: 1.57;
	    	padding: 8px 10px;
			background-color: transparent;
		    cursor: pointer;
		    transition: color 0.2s ease 0s, background-color 0.2s ease 0s;
		    color: rgb(204, 153, 0);
		    pointer-events: auto;
		    border: none;
		    box-sizing: border-box;
		}
		.btn10_1{
			font-size: 14px;
	    	line-height: 1.57;
	    	padding: 8px 10px;
			background-color: transparent;
		    cursor: pointer;
		    transition: color 0.2s ease 0s, background-color 0.2s ease 0s;
		    color: rgb(136, 136, 136);
		    pointer-events: auto;
		    display: none;
		    border: none;
		    box-sizing: border-box;
		    float:left;
		}
		.selection{
			padding-top: 10px;
			padding-bottom: 10px;
			padding-left: 20px;
			border: 1px solid lightgray;
			width: 773px;
		}
		.area{
			overflow: hidden; 
			overflow-wrap: break-word; 
			height: 50px;
			max-height: 160px;
			border-radius: 4px;
			border: 1px solid lightgray;
			font-size: 14px;
			color: black;
			resize: none;
			width: 750px;
			padding: 10px;
		}
		
		input:focus {outline: none;}
		textarea:focus{outline: none; border: 1px solid rgb(204, 153, 0);}
		
		.hidden{
			visibility: hidden;
		}
	
	</style>
	
	
	<script>
	$(function(){
		$('.btn3').click(function (e) {
			e.preventDefault();
			$("#cor_picture").click();
		});
		
		$("#cor_expl_change").click(function(){
			$("#textbox").focus();
		});
		
		$("#textbox").blur(function(){
			$("#count").addClass("hidden");
			$("#counter").addClass("hidden");
			$("#btns1").find('.btn10_1').css("display", "none");
			$("#btns1").find('.btn10').html("수정");
		});
	
		$("#textbox").focus(function(e){
			$("#count").removeClass("hidden");
			$("#counter").removeClass("hidden");
			$("#btns1").find('.btn10_1').css("display", "block");
			$("#btns1").find('.btn10').html("저장");
			var content = $(this).val();
			$("#count").html(content.length);
		});
		
		$("#textbox").keyup(function(e){	
			var content = $(this).val();
			$("#count").html(content.length);
			
			if(content.length >= 100){
				alert("최대 100자까지 입력 가능합니다.");
				$(this).val(content.substring(0,100));
				$("#count").html("100");
			}
		});
		
		$("#cor_name_change").click(function(){
			$("#name").focus();
		});
		
		$("#name").focus(function(){
			$('.section2_1').css("border-bottom","1px solid rgb(217, 173, 43)");
			$("#count0").removeClass("hidden");
			$("#counter0").removeClass("hidden");
			$('.section2_1').find('.btn10_1').css("display", "block");
			$('.section2_1').find('.btn10').html("저장");
			var content = $(this).val();
			$("#count0").html(content.length);
		});
		
		$("#name").keyup(function(e){
			var content = $(this).val();
			$("#count0").html(content.length);
			
			if(content.length == 0){
				$("#count0").css("color", "red");
				$('.section2_1').css("border-bottom","1px solid red");
			}else{
				$("#count0").css("color", "rgb(204, 153, 0)");
				$('.section2_1').css("border-bottom","1px solid rgb(217, 173, 43)");
			}
			if(content.length > 100){
				$(this).val(content.substring(0,100));
				$("#count0").html("100");
			}
		});
	
		$("#name").blur(function(){
			$('.section2_1').css("border-bottom","1px solid rgb(225, 225, 225)");
			$("#count0").addClass("hidden");
			$("#counter0").addClass("hidden");
			$('.section2_1').find('.btn10_1').css("display", "none");
			$('.section2_1').find('.btn10').html("수정");
		});
	
		
	});
	</script>
</head>
<body>
	<header>
	<div>
	<button class="btn1 samsung" onClick=""></button><a href=""><h1>샘숭</h1></a>
	</div>
	<div class="menu">
		<div class="menu_item"><a class="menu_item1" href="help1.html" target="_blank">도움말</a></div>
		<div class="menu_item"><a class="menu_item1" href="">가격 안내</a></div>
		<div class="menu_item"><a href="main.html" class="direct">콜라비로 바로가기</a></div>
	</div>
	</header>
	
	<main>
	<div class="sidebar">
	<div class="profile">
	<button class="btn2 yr" onClick=""></button>
	<div><a class="nickname" href="0option1.jsp" style="padding-left:10px;">유라짱짱<br/>
	<span style="color: rgb(204, 153, 0); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 12px;">샘숭</span></a></div>
	<div style="padding: 10px;">
	</div>
	</div>
	
	<div>
	<ul>
		<li><p class="title">메뉴</p></li>
		<li class="chosen"><a href="0corporation1.jsp">
		<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M12 7V3H2v18h20V7H12zM6 19H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm4 12H8v-2h2v2zm0-4H8v-2h2v2zm0-4H8V9h2v2zm0-4H8V5h2v2zm10 12h-8v-2h2v-2h-2v-2h2v-2h-2V9h8v10zm-2-8h-2v2h2v-2zm0 4h-2v2h2v-2z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
		회사 정보</a></li>
		<li><a href="0corporation2.jsp">
		<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
		동료 관리</a></li>
		<li><a href="0corporation3.jsp">
		<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M14.027 5L13.6 3H4v18h2v-7h6l.533 2H20V5z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
		협업공간 관리</a></li>
		<li><a href="0corporation4.jsp">
		<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1.41 16.09V20h-2.67v-1.93c-1.71-.36-3.16-1.46-3.27-3.4h1.96c.1 1.05.82 1.87 2.65 1.87 1.96 0 2.4-.98 2.4-1.59 0-.83-.44-1.61-2.67-2.14-2.48-.6-4.18-1.62-4.18-3.67 0-1.72 1.39-2.84 3.11-3.21V4h2.67v1.95c1.86.45 2.79 1.86 2.85 3.39H14.3c-.05-1.11-.64-1.87-2.22-1.87-1.5 0-2.4.68-2.4 1.64 0 .84.65 1.39 2.67 1.91s4.18 1.39 4.18 3.91c-.01 1.83-1.38 2.83-3.12 3.16z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
		결제</a></li>
		<li><p class="title">보안</p></li>
		<li><a href="0corporation5.jsp">
		<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M20,19 L20,21 L4,21 L4,19 L20,19 Z M15,3.1 C15.4970563,3.1 15.9,3.50294373 15.9,4 L15.9,4 L15.9,9.1 L19,9.1 C19.7653683,9.1 20.1660329,9.98330088 19.7077601,10.5567165 L19.7077601,10.5567165 L19.6363961,10.6363961 L12.6363961,17.6363961 C12.2849242,17.987868 11.7150758,17.987868 11.3636039,17.6363961 L11.3636039,17.6363961 L4.3636039,10.6363961 C3.79663552,10.0694277 4.19818563,9.1 5,9.1 L5,9.1 L8.1,9.1 L8.1,4 C8.1,3.54117882 8.44333667,3.16254822 8.88710591,3.10701228 L8.88710591,3.10701228 L9,3.1 Z M14.1,4.9 L9.9,4.9 L9.9,10 C9.9,10.4588212 9.55666333,10.8374518 9.11289409,10.8929877 L9.11289409,10.8929877 L9,10.9 L7.173,10.9 L12,15.727 L16.826,10.9 L15,10.9 C14.5411788,10.9 14.1625482,10.5566633 14.1070123,10.1128941 L14.1070123,10.1128941 L14.1,10 L14.1,4.9 Z" class="Beecon__Path-sc-3x6pq4-1 jRUwgg"></path></svg>
		파일 다운로드 이력</a></li>
	</ul>
	<div class="foot">개인정보 처리방침<br/>
		이용 약관<br/>
		collabee Inc. © 2022</div>
	</div>
	</div>
	
	<div class="section1">
	<div class="container1">
	<div class="square">
	<input type="file" style="display: none;" id="cor_picture"/>
	<button class="btn3">
		<span class="spam">변경</span>
	</button>
	</div>
	<div class="container2_0">
	<div class="h2">샘숭</div>
	<div class="container2">
	<span>Free</span>
	<hr style="margin-left: 10px; margin-right: 15px; margin-top: 0px; height: 2vh; width:.1vw; border-width: 0;" color="lightgray" noshade>
	<svg xmlns="http://www.w3.org/2000/svg" width="18px" height="18px" viewBox="0 0 24 24"><g fill="none" fill-rule="evenodd"><path fill="#888888" d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z"></path></g></svg>
	<span style="margin-left: 5px;">4명 이용 중</span>
	</div>
	<div class="container2_1">
	<button class="btn4">요금제 변경하기</button>
	<button class="btn4" style="margin-left: 10px;">동료 초대하기</button>
	</div>
	</div>
	</div>
	
	</div>
	<div class="section2">
	<div class="section2_1">
		<form style="float: left">
		<label>회사 이름</label><br/>
		<input id="name" type="text" minlength="1" maxlength="100" placeholder="회사 이름을 입력해 주세요." value="샘숭" class="cname">
		</form>
		<div class="btns">
			<button class="btn10_1">취소</button>
			<button class="btn10" id="cor_name_change">수정</button>
		</div>
	</div>
	<div>
	<div class="hidden" id="count0" style="float: left; margin-left: 10px; margin-top: 4px; font-size: 12px; color: rgb(204, 153, 0);">0</div>
	<span class="hidden" id="counter0" style="margin-left: 3px; margin-top: 10px; color: rgb(136, 136, 136); font-size: 12px;">/100</span>
	</div>
	<div style="padding: 10px;">
	</div>
	
	<div>
	<label>회사 규모</label><br/>
	<div style="padding: 5px;">
	</div>
	<select class="selection">
		<option value="1">1~5명</option>
		<option value="2">1~10명</option>
		<option value="3">1~50명</option>
		<option value="4">1~100명</option>
		<option value="5">1~300명 이상</option>
	</select>
	</div>
	
	<div style="padding: 30px;">
	</div>
	
	<div>
	<label>회사 설명</label><br/>
	<div style="padding: 5px;">
	</div>
	<textarea id="textbox" class="area" rows="3" maxlength="100" placeholder="회사 설명을 입력해 주세요.">샘송설계팀</textarea>
	<div style="margin-top: -5px; margin-left: 10px;">
	<span class="hidden" id="count" style="font-size: 12px; color: rgb(204, 153, 0);">0</span>
	<span class="hidden" id="counter" style="color: rgb(136, 136, 136); font-size: 12px;">/100</span></div>
		<div class="btns" style="float:right; margin-top: -20px;" id="btns1">
			<button class="btn10_1">취소</button>
			<button class="btn10" id="cor_expl_change">수정</button>
		</div>
	</div>
	</div>
	</main>
</body>
</html>