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
    <script src="https://malsup.github.io/jquery.form.js"></script>
    <script>
        $(function(){
            $("#btn3").click(function(){
                $("#hidePartnerManagementOn").css("display","block");
                $.ajax({
                	type: 'get',
                	url: 'PartnerHiddenServlet',
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
                		//"<button type='button' class='partnerBlockBtn'>숨김 해제</button>" +
                	}
                });
            });
            $(document).on("click",".partnerBlockBtn",function(){
                $(this).parent().parent().remove();
                var member_id = $(this).parent().parent().attr("loginId");
                $(this).parent().parent().find(".loginId").val(<%=loginId%>);
                $(this).parent().parent().find(".memberId").val(member_id);
                alert($(this).parent().html());
                $(this).parent().submit();
            });
        });
    </script>
    <style>
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
	</head>
<body>
	<button>파트너 관리</button>
    <div id="partnerManagementCategory"> 
        <button class="btn" id="btn1">협업공간 일괄 초대</button>
        <button class="btn" id="btn2">멤버 일괄 탈퇴</button>
        <button class="btn" id="btn3"> 숨긴 파트너 관리</button>
    </div>
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
</body>
</html>