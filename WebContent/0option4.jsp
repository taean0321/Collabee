<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.yr.dto.*" %>
<%@ page import="com.yr.dao.*" %>
<%
	Collabee_newinfoDao infoDao = new Collabee_newinfoDao();
	ArrayList<Collabee_newinfoDto> listAll = infoDao.getAllBoardList();
	/*ArrayList<NoneFolderDto> listNone = (ArrayList<NoneFolderDto>)request.getAttribute("list2");*/
	int loginId = 4;
	int corporation_id = 5;
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>option4</title>
	<link rel="icon" href="images/favicon.ico" type="image/x-icon">
	<script src="js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
  	<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
	<style>
	body{
		font-family: -apple-system,BlinkMacSystemFont,Malgun Gothic,Hiragino Kaku Gothic ProN,Hiragino Sans,Meiryo,MS PGothic,sans-serif,Dotum;
		font-size: 13px;
    	color: #222;
    	margin: 0px;
	}
	a{
		text-decoration: none;
	}
	.update_layout{
		display: flex;
	    flex-direction: row;
	    width: 100vw;
	    height: 100vh;
	    background-color: rgb(255, 255, 255);
	}
    #searchbar::placeholder{
        color: rgb(193, 193, 193);
    }
    #searchbar { /*상단 검색창  / 클릭하면 길어지면서 문서작성 버튼 없어짐(할지말지 고민중) */
        will-change: transform;
        background-color: rgba(255, 255, 255, 0);
        height:28px;
        width:144px;
        font-size:13px;
        border-radius:4px;
        border: 1px solid rgb(225, 225, 225);
        transition: border-color 0.2s ease 0s, background-color 0.2s ease 0s;
        margin-right:16px;
        padding:0px 32px;
    }
    #searchbar:hover{
        border-color:rgb(136, 136, 136);
    }
    #searchbar:focus{
        background-color: rgba(255, 255, 255, 0.2);
        border-color:rgb(136, 136, 136);
        border: 1px;
        width:269px;
        z-index: 10;
    }
    #searchbar::placeholder:hover{
        color:rgb(136, 136, 136);
    }
    #search_icon{
        fill:rgb(224, 221, 217);
        position: absolute;
        transition: fill 0.2s ease 0s;
        -webkit-box-align: center;
        border:none;
        display:flex;
        align-items:center;
        padding-left:10px;
        padding-top:2px;
    }
    #search_icon:hover{
        fill:rgb(136, 136, 136);
    }
    #posting_bnt {/* 상단 문서작성버튼*/
        color: rgb(255, 255, 255);
        font-size: 12px;
        font-weight: 500;
        border-radius: 4px;
        border: 1px solid rgb(217, 173, 43);
        background-color: rgb(217, 173, 43);
        cursor: pointer;
        width: 105px;
        height:28px;
        border:1px solid rgba(255, 255, 255, 0.2);
        transition: background-color 0.2s ease 0s, color 0.2s ease 0s, border-color 0.4s ease 0s, fill 0.2s ease 0s, opacity 0.2s ease 0s;
    }
    #posting_bnt:hover{
        background-color: rgb(179, 142, 34);
        border-color: rgb(179, 142, 34);
    }
    .posting_icon{ /*svg 색지정은 fill로!!*/
        fill: rgb(255, 255, 255);
        width:13px;
        height:13px;
    }
    .micro{
    	margin-top: 5px;
    }
    .infoupdate_main{
	    flex: 1 1 auto;
	    display: flex;
	    flex-direction: column;
	    height: 100vh;
	    overflow-y: hidden;
	    overflow-x: hidden;
	    min-width: 690px;
    }
    .content{
    	flex: 1 1 auto;
    	height: 100vh;
	    overflow-x: hidden;
	    overflow-y: hidden;
	    padding: 40px;
	    margin-top: -30px;
    }
    .infoupdate_header{
    	width: 100%;
    	height: 106px;
    	position: relative;
    }
    .infoupdate_top{
    	position: relative;
	    height: 68px;
	    display: flex;
	    flex-direction: row;
    }
    .infoupdate_title{
    	flex: 1 1 auto;
    	display: flex;
	    flex-direction: row;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    -webkit-box-align: center;
	    align-items: center;
	    margin-right: 20px;
    }
    .h1{
    	font-size: 22px;
	    font-weight: bold;
	    color: rgb(34, 34, 34);
	    text-shadow: none;
	    margin-top: 10px;
	    margin-left: 40px;
    }
    .mastersearchbar{
    	display: flex;
	    flex-direction: row;
	    position: relative;
	    align-items: flex-start;
    }
    button{
    	border: none;
    }
    .header_mid{
    	display: flex;
	    flex-direction: row;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    position: relative;
	    z-index: 2;
	    height: 25px;
	    margin: 0px 20px;
	    border: none;
	    border-bottom: 1px solid lightgray;
    }
    .sort{
    	margin-left: 6px;
	    display: flex;
	    flex-direction: row;
    }
    .m{
    	margin: 0px 16px;
    	font-size: 12px;
    	cursor: pointer;
    	color: rgb(136,136,136);
    }
    .m:hover{
    	color: black;
    	font-weight: bold;
    }
    .selected{
    	color: black;
    	font-weight: bold;
    	border: none;
    	border-bottom: 1px solid black;
    }
    .content_header{
    	padding-left: 10px;
    	padding-top: 20px;
	    height: 85px;
	    margin-right: 40px;
	    border-bottom: 1px solid rgb(225, 225, 225);
	    width: 100%;
    }
    .p1{
    	display: block;
	    font-size: 12px;
	    line-height: 1.5;
	    color: rgb(136, 136, 136);
    }
    .h2{
    	font-size: 18px;
	    font-weight: bold;
	    line-height: 1.2;
	    color: rgb(34, 34, 34);
	    margin-left: -20px;
    }
    .content_body{
    	height: calc(100vh - 231px);
	    overflow-y: scroll;
	    overflow-x: hidden;
    }
    .content_body::-webkit-scrollbar{
    	width:4px;
    }
    .content_body::-webkit-scrollbar-thumb{
    	height: 70%; /* 스크롤바의 길이 */
	    background: #e1e1e1; /* 스크롤바의 색상 */
	    border-radius: 2px;
    }
    .divtable{
    	width: 100%;
    }
    .updatebox{
    	display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    padding: 14px 10px;
	    border-bottom: 1px solid rgb(225, 225, 225);
	    font-size: 14px;
	    color: rgb(34, 34, 34);
	    cursor: pointer;
	    width: 100%;
    }
    .updatecontent{
    	display: flex;
	    flex-direction: row;
	    min-width: 0px;
	    flex: 1 1 0%;
	    padding-right: 12px;
    }
    .updatespan1{
    	color: rgb(136, 136, 136);
	    word-break: break-all;
	    white-space: nowrap;
	    text-overflow: ellipsis;
	    overflow: hidden;
	    transition: color 0.2s ease 0s;
	    display: inline;
    }
    .updatespan1::before{
    	display: inline-block;
	    content: "-";
	    padding-left: 5px;
	    padding-right: 5px;
    }
    .updatespan2{
    	color: rgb(34, 34, 34);
    	font-size: 14px;
    	padding-right: 30px;
    }
    .nowrap{
    	white-space:nowrap;
    }
    /* 모달 시작 */
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
	.update_modal{
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
	.update_modal_body{
		display: flex;
	    flex-direction: column;
	    width: 580px;
	    min-height: 229px;
	    padding: 27px 28px;
	    z-index: 110;
    }
    .update_modal_title{
	    color: rgb(136, 136, 136);
	    font-size: 12px;
	    line-height: 18px;
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
    .update_modal_header{
	    font-weight: bold;
	    color: rgb(136, 136, 136);
	    display: flex;
	    flex-direction: row;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    -webkit-box-align: center;
	    align-items: center;
	}
	.update_modal_content_title{
		margin-top: 20px;
	    font-size: 16px;
	    font-weight: 700;
	    line-height: 24px;
	    margin-bottom: 0px;
	}
	.update_modal_date{
		font-size: 12px;
	    line-height: 18px;
	    color: #888;
	}
	.modal_content_text{
		overflow-y: auto;
	    max-height: 538px;
	    margin-top: 20px;
	    padding-top: 20px;
	    font-size: 14px;
	    line-height: 22px;
	    border-top: 1px solid #e1e1e1;
	}
	 #partnerManagementCategory {
            width: 1640px;
            height: 40px;
            background-color: #fafafa;
        }
        .btn {
            font-size: 12px;
            background-color: #fafafa;
            margin-top: 10px;
            border: none;
            padding: 0px 15px;
        }
        #hidePartnerManagement {
            width:820px;
            height:80px;
            border-bottom: 1px solid #e1e1e1;
            margin-left: 30px;
            margin-top: 30px;
        }
        #hidePartnerList {
            width: 840px;
            height: 710px;
            overflow: auto;
            padding: 10px 0px 40px;
            margin-left: 20px;
        }
        #hidePartnerList::-webkit-scrollbar{
            width: 5px;
        }
        #hidePartnerList::-webkit-scrollbar-thumb{
            background-color: #e1e1e1;
            border-radius: 5px;
        }
        #hidePartnerList::-webkit-scrollbar-track{
            background-color: white;
            border-radius: 5px;
        }
        .hidePartnerBox {
            display: flex;
            width:390px;
            height:80px;
            border: 1px solid #e1e1e1;
            margin-left: 20px;
            margin-top: 10px;
            float: left;
            border-radius: 5px;
        }
        .partnerBlockBtn {
            margin-top: 26px;
            margin-right: 0px;
            background-color: white;
            border: none;
            font-size: 15px;
            color: #d9ad2b;
        }
        #hidePartnerManagementOn {
            display: none;
            margin-top: 15px;
        }
        #btn1 {
        	margin-left: 150px;
        }
        #btn2 {
        	border-left:1px solid #c1c1c1;
        }
        #btn3 {
        	border-left:1px solid #c1c1c1;
        }
        #hidePartnerManagement > h3 {
        	margin: 0px;
        }
        #hidePartnerManagement > p {
        	margin-top: 5px; font-size:12px;
        }
        .hidePartnerBox > div > img {
        	width: 60px; height:60px; border-radius: 35px; border: 1px solid black; margin: 10px 12px; float: left;
        }
        .memberName {
        	margin-bottom: 0px; font-size: 14px; margin-top: 25px;
        }
        .memberMail {
        	margin:0px; font-size: 12px; color: gray;
        }
        .hiddenMemberDiv {
        	float: left;
        	width: 221px;
        }
	</style>
	<script>
	$(function(){
		$("#btn1").click(function(){
			alert("준비중입니다.")
		});
		$("#btn2").click(function(){
			alert("준비중입니다.")
		});
		$(".btn").mouseenter(function(){
			$(this).css("color","gray");
		});
		$(".btn").mouseleave(function(){
			$(this).css("color","black");
		});
		$("#btn3").click(function(){
            $("#hidePartnerManagementOn").css("display","block");
            $.ajax({
            	type: 'get',
            	url: 'Controller?command=PartnerHiddenAction',
            	data: {"login_id":<%=loginId%>},
            	datatype: 'json',
            	success: function(data){
            		$.each(data, function(idex,item){
            			var hiddenPartentInformation =
            				"<div class='hidePartnerBox' loginId='"+item.member_id+"'>" +
                        		"<div><img src='image/"+item.picture+"'/></div>" +
                       			"<div class='hiddenMemberDiv'>" +
                           			"<p class='memberName'>"+item.name+"</p>" +
                            		"<p class='memberMail'>"+item.email+"</p>" +
                        		"</div>" +
                        		"<form action='PartnerBlockServlet' method='post'>" +
                        			"<input type='button' class='partnerBlockBtn' value='숨김 해제'/>" +
                        			"<input type='hidden' class='loginId' name='loginId'/>" +
                        			"<input type='hidden' class='memberId' name='memberId'/>" +
                        		"</form>" +
                    		"</div>";
                    	$("#hidePartnerList").append(hiddenPartentInformation);
            		});
            	},
            	error: function(r,s,e){
            		
            	}
            });
        });
        $(document).on("click",".partnerBlockBtn",function(){
            $(this).parent().parent().remove();
            var member_id = $(this).parent().parent().attr("loginId");
            $(this).parent().parent().find(".loginId").val(loginId);
            $(this).parent().parent().find(".memberId").val(member_id);
            alert($(this).parent().html());
            $(this).parent().submit();
        });
		
		$("#ready1, #ready2").click(function(){
			alert("서비스가 준비 중입니다.");
		});
		
		$('.updatebox').mouseenter(function() {
            $(this).find('.updatespan1').css("color","rgb(83, 83, 83)");
		});
        $('.updatebox').mouseleave(function() {
        	$(this).find('.updatespan1').css("color","rgb(136, 136, 136)");
        });
        $('.updatebox').click(function() {
        	var order = $(this).attr("title");
        	
        	
        	$.ajax({
        		type: 'get',
        		url: 'Controller?command=Board',
        		data: { "newinfo" : order},
        		datatype: "json",
        		success: function(d){
        			$('.modal_background').css("display", 'block');
        			var title = d.title;
        			var content = d.content;
        			var creation_date = d.creation_date;
        			$("#title").text(title);
        			$("#content").text(content);
        			$("#date").text(creation_date);
        		},
        		error: function(r,s,e){
        			alert("error!");
        		}
        	});
        });
        
        $("#searchbar").keypress(function(e){
     	   if(e.keyCode == 13){
     		   var search = $(this).val();
     		   var member_id = 4;
     		   location.href="Controller?command=SearchP1&search="+search+"&member_id="+member_id;
     	   }
 	    });
 		
 		$("#posting_bnt").on("click", function(){ 
 			$.ajax({   //-->화면 안에서 변할때 사용. 화면 전환해주지 않음.
 				type:"post",
 				url:"Controller?command=getPrivateId", //프라이빗 공간 찾기
 				data:{
 					"loginId": 4
 				},
 				datatype:"json",
 				success:function(data){
 					location.href="Controller?command=writedocument&loginId=4&workspaceId="+data.workspaceId;
 				},
 				error:function(r,s,e){
 					alert("error!");
 				}
 			}); 			
 		});
	});
	</script>
	<!-- 태안부분 추가한거 -->
	<script>
	
	$(function(){
		$(".home_btn21").on("click", function(){
			$("#partnerInviteBox").css("display","block");
			$('.homehead_background1').css('display', 'block');
		});
		
		$('.homehead_background1').click(function(){
			var result = confirm('파트너 초대를 그만하고 나가시겠습니까?');
			if(result){
				$("#partnerInviteBox").css("display","none");
		        $('.homehead_background1').css("display", "none");
			}
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
	});
	
	</script>
</head>
<body style="overflow-y: hidden; overflow-x: hidden;">
<%@ include file="WEB-INF/include/include_PartnerModal.jspf" %>
	<div class="update_layout">
	<%@ include file="HomeSidebar2.jspf" %>		
		<main class="infoupdate_main">
			<header class="infoupdate_header">
				<div class="infoupdate_top">
					<div class="infoupdate_title">
						<div>
							<h1 class="h1">설정</h1>
						</div>
						<div>
				    		<div class="mastersearchbar">
						        <div id="search_icon" class="bnt_base"><svg class="micro" viewBox="0 0 24 24" width="16px" height="16px"><path d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"></path></svg></div>
						        <input type ="text" id=searchbar placeholder="검색"/>
						        <button id="posting_bnt">
						            <svg viewBox="0 0 24 24" width="13px" height="13px" ><path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04a.996.996 0 0 0 0-1.41l-2.34-2.34a.996.996 0 0 0-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z" class="posting_icon" ></path></svg>
						            <span>문서 작성</span>
						        </button>
				        	</div>
			        	</div>
			    	</div>
			    	<div class="infoupdate_topright">
			    		<%@ include file="homehead13.jspf" %>
			    	</div>
		    	</div>
		    	<div class="header_mid">
		    		<nav class="sort">
		    			<a class="m" href="Controller?command=option1">내 정보</a>
		    			<a class="m" href="Controller?command=option1">알림</a>
		    			<a class="m selected" href="Controller?command=option4">파트너 관리</a>
		    			<a class="m" id="ready1">외부 서비스</a>
		    			<a class="m" href="setting_price.jsp">가격 및 결제</a>
		    			<a class="m" href="">업데이트</a>
		    			<a class="m" id="ready2">Webhook &#946;</a>
		    		</nav>
		    	</div>
		    	<div id="partnerManagementCategory"> 
			        <button class="btn" id="btn1">협업공간 일괄 초대</button>
			        <button class="btn" id="btn2">멤버 일괄 탈퇴</button>
			        <button class="btn" id="btn3"> 숨긴 파트너 관리</button>
		    	</div>
			</header>
			<div id="hidePartnerManagementOn">
        		<div id="hidePartnerManagement">
		            <h3>숨긴 파트너 관리</h3>
		            <p>파트너를 '숨김 해제' 하면, 프라이빗 공간 내 문서에서 해당 파트너를 공유자로 추가할 수 있습니다.</p>
		        </div>
		        <div id="hidePartnerList">
		            <!-- <div class="hidePartnerBox">
		                <div><img src="image/bell.svg"/></div>
		                <div class="hiddenMemberDiv">
		                    <p class="memberName">강지현</p>
		                    <p class="memberMail">twekyaak@gmail.com</p>
		                </div>
		                <form action="PartnerBlockServlet" method="post">
			                <button class="partnerBlockBtn">숨김 해제</button>
		                </form
		            </div> -->
		        </div>
		    </div>
		</main>
	</div>	
</body>
</html>