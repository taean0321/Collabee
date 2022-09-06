<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
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
	.homehead_background2{
		display: none;
		z-index: 100;
		position: absolute;
		top: 0px;
	    left: -1600px;
	    right: 0;
	    bottom: 0;
	    width: 1899px;
	    height: 900px;
		background-color: transparent;
		background-color: black;
	}
	</style>
	<script>
	
	$(function(){
		$("#makingsample, #language").click(function(){
			alert("준비 중입니다.");
		});
		
		$('.home_btn11').click(function (){
        	var px = $(this).offset().left - 250;
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
			var result2 = confirm("로그아웃을 진행하시겠습니까?");
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
					<a class="home_option_container2" href="Controller?command=option1">설정</a>
					<a class="home_option_container2" href="0option2.jsp">알림</a>
				 	<%
					if (corporation_id != 0){
					%>
					<a class="home_option_container2" href="0corporation1.jsp">회사 관리</a>
					<%
					}else{
					%>
					<a class="home_option_container2" href="Controller?command=option1">회사 찾기 및 만들기</a>
					<% 
					}
					%>
					<a class="home_option_container2" href="partner_management.jsp">파트너 관리</a>
				</div>
				<div class="home_option_container">
					<a class="home_option_container2" href="setting_price.jsp">가격 및 결제</a>
					<button class="home_option_btn3" id="makingsample">샘플 공간, 문서 만들기</button>
					<a class="home_option_container2" href="0help1.jsp" target="_blank">사용 가이드</a>
					<a class="home_option_container2" onclick="alert('준비 중입니다.')">데스크탑 앱 다운로드</a>
				</div>
				<div class="home_option_container">
					<button class="home_option_btn3" id="language">Language</button>
				</div>
				<div class="home_option_container">
					<button class="home_option_btn3" id="logout">로그아웃</button>
				</div>
			</div>
		</div>
	</div>
	
	
<div class="home_topright">
		<button title="" class="home_btn11"></button>
		<button title="파트너 초대" class="home_btn21">
		<svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewBox="0 0 24 24"><path fill="#888888" fill-rule="evenodd" d="M15 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm-9-2V7H4v3H1v2h3v3h2v-3h3v-2H6zm9 4c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"></path></svg>
		</button>
		<button class="home_btn31">
		<span>파트너</span>
		<span class="home_number">${partnerN }</span>
		</button>
 </div>
 
 <div class="homehead_background2"></div>
 
</body>
</html>