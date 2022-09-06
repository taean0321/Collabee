<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.one.dto.*" %>
<%@ page import="com.one.dao.*" %>
<%@ page import="mvc.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
	

<%
	ArrayList<MyWorkspaceListDto> workspacePostList = (ArrayList<MyWorkspaceListDto>)request.getAttribute("workspacePostList");
	int corporation_id = (Integer)session.getAttribute("corporation_id");
	int loginId =(Integer)session.getAttribute("loginId");
	int workspaceId = (Integer)request.getAttribute("workspaceId");//클릭한 공간id
	String workspaceName = (String)request.getAttribute("workspaceName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- 22.8.14 수정 by 강지현 -->
<!-- 협업공간 메인 페이지  협업공간 게시글과 공간 설정 모달-->
<!-- include_SettingWorkspace.jspf(설정) / include_InviteMembers.jspf(멤버초대)/ Aside.jspf(위젯) / HomeSidebar.jspf(사이드바) / homehead4.jspf(개인 설정)-->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <title>협업공간 메인 페이지</title>
    
    <style>
        body, *{
            font-family: -apple-system,BlinkMacSystemFont,Malgun Gothic,Hiragino Kaku Gothic ProN,Hiragino Sans,Meiryo,MS PGothic,sans-serif,Dotum;
            box-sizing: border-box;
            margin:0;
            padding:0;
            outline: none;
        }
        a{
            text-decoration:none;
            color: rgb(34, 34, 34);
        }
        input, button{
            border:none;
        }
        .icon1_color{
            fill:rgb(136, 136, 136);
        }
        .icon2_color{
            fill:#fff;
        }
        #workspace_index{
            display: flex;
            flex-direction: row;
            width: 100vw;
            height: 100vh;
            overflow: hidden;
            background-color: rgb(255, 255, 255);
        }
        #space_main_wi{
            flex: 1 1 auto;
            display: flex;
            flex-direction: column;
            height: 100vh;
            overflow:hidden;
            min-width: 600px;
            /* 600px 적절한지 확인 해야됨 */
        }
        #space_main_wi > header{
            position: relative;
            display: flex;
            flex-direction: row;
            min-height: 150px;
            padding-bottom: 24px;
            background-color: rgb(42, 88, 74);
        }
        #head1_wi{
            display:flex; 
            flex: 1 1 auto; 
            flex-direction: column; 
            z-index: 2; 
            margin-top: 20px; 
            min-width: 0px; 
        }
        #bnt1_wi{
            display: flex;
            flex-direction: row;
            align-items:center;
            margin: 2px 16px 0px 6px;
        }
        #title_wi{
            word-break: break-all;
            font-size: 22px;
            font-weight: bold;
            line-height: 28px;
            color: rgb(255, 255, 255);
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
            padding-left:40px;
        }
        #bnt3_wi{
            display:flex;
            overflow:hidden;
            justify-content: space-between;
        }
        #bnt3_wi button{
            background-color: rgb(42, 88, 74);
        }
        #textarea_wi{
            position: relative;
            padding-left: 40px;
        }
        #summary_wi{
            width:600px;
            background-color: transparent;
            max-width: 100%;
            text-align: left;
            color: rgba(255, 255, 255, 0.8);
            font-size: 12px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            resize:none;
            border:none;
            margin-top:10px;
        }
        #summary_wi::placeholder{
        	color:rgba(255,255,255,0.8);
        	fonr-size:12px;
        }
        #bnt2_wi{
            position: relative;
            display: flex;
            flex-direction: row;
            -webkit-box-align: center;
            align-items: center;
            margin-left: 35px;
            height: 32px;
        }
        #document_bnt_wi:hover{
            background-color: rgb(63, 149, 123);
            border-color: rgba(255, 255, 255, 0.2);
        }
        #bnt2_wi button:not(#document_bnt_wi){
            position: relative;
            flex: 1 1 100px;
            height: 32px;
            margin: 0px 6px 0px 0px;
            padding: 5px 4px;
            min-width: 60px;
            border-radius: 4px;
            cursor: pointer;
            box-shadow: rgb(0 0 0 / 20%) 0px 1px 2px 0px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            background-color: rgba(255, 255, 255, 0.12);
            color:#fff;
            margin-left: 4px;
            font-size: 13px;
            display: flex;
            justify-content: center;
        }
        #bnt2_wi button:not(#document_bnt_wi):hover{
        	box-shadow : rgb(0 0 0 / 20%) 0px 1px 2px 0px !important;
        	border: 1px solid rgba(255, 255, 255, 0.1) !important;
    		background-color: rgba(255, 255, 255, 0.05) !important;
        }
        #document_bnt_wi{
            min-width: 144px;
            flex: 1 1 100px;
            height: 32px;
            display: flex;
            flex-direction: row;
            -webkit-box-align: center;
            align-items: center;
            -webkit-box-pack: center;
            justify-content: center;
            border-radius: 4px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: rgb(255, 255, 255);
            font-weight: 500;
            transition: background-color 0.2s ease 0s, color 0.2s ease 0s, border-color 0.4s ease 0s, fill 0.2s ease 0s, opacity 0.2s ease 0s;
            background-color: rgb(51, 132, 108);
            cursor: pointer;   
        }
        #tab_wi{
            display:flex;
            -webkit-box-pack: justify;
            position: relative;
            z-index: auto;
            height: 38px;
            margin: 0px 20px;
        }
        /* 클릭하면 글씨색이랑 밑줄 생기기 */
        #tab_wi::after{
            position: absolute;
            bottom: 0px;
            left: 0px;
            right: 0px;
            content: "";
            height: 1px;
            background-color: rgb(225, 225, 225);
        }
        #container1_pi{
            position: absolute;
        }
        #container1_wi, #container1_pi{
            margin-left: 0px;
            margin-right: 0px;
            flex: 1 1 auto;
            display: flex;
            flex-direction: row;
            -webkit-box-pack: justify;
            -webkit-box-align: center;
            white-space: nowrap;
        }
        #container1_wi button, #container1_pi button{
            position: relative;
            display: flex;
            flex-direction: row;
            -webkit-box-pack: center;
            height: 38px;
            margin: 0px 16px;
            font-size: 12px;
            font-weight: normal;
            background-color: transparent;
            cursor: pointer;
            color: rgb(136, 136, 136);
            align-items: center;
        }
        #container1_wi span:hover, #container1_pi span:hover{
            color: rgb(34, 34, 34);
        }
        #container1_wi a, #container1_pi a{
            color: rgb(136, 136, 136);
            
        }
        #container1_wi a:after, #container1_pi a:after{
            position: absolute;
            bottom: 0px;
            left: 0px;
            right: 0px;
            content: "";
            height: 1px;
            background-color: transparent;
            z-index: 1;
        }
        #container2_wi{
            position: relative;
            flex: 0 0 auto;
            width: 250px;
            display: flex;
            -webkit-box-pack: end;
            -webkit-box-align: center;
            padding-right: 20px;
            flex-direction: row;
            justify-content: flex-end;
            align-items: center;
            overflow:hidden;
        }
        .tab1_bnt{
            display: inline-block;
            cursor: pointer;
            font-size: 12px;
            line-height: 1.5;
            padding: 10px;
            margin: 0px 3px;
            color: rgb(34, 34, 34);
            transition: color 0.2s ease 0s;
            background-color: transparent;
        }
        .tab1_bnt2{
            background-color: transparent;
            display: inline-block;
            cursor: pointer;
            flex-direction: row;
            -webkit-box-align: center;
            align-items: center;
            font-size: 12px;
            color: rgb(34, 34, 34);
            line-height: 1.5;
            padding: 10px 0px 10px 10px;
            margin: 0px 0px 0px 3px;
        }
        #bnt3_wi button{
            min-width: inherit;
            min-height: inherit;
            padding-left: 0px;
            padding-right: 0px;
            transition: fill 0.2s ease 0s;
            cursor: pointer;
            pointer-events: auto;
            background-color: transparent;
            text-decoration: none;
        }
        #container3_wi {
            position: relative;
            display: flex;
            flex-direction: row;
            -webkit-box-align: center;
            align-items: center;
            align-self: stretch;
            margin-right:40px;
        }
        #container3_wi button{
            min-width: inherit;
            min-height: inherit;
            transition: fill 0.2s ease 0s;
            cursor: pointer;
            width: auto;
            background-color: transparent;
            text-decoration: none;
            position: relative;
            display: flex;
            flex-direction: row;
            -webkit-box-align: center;
            align-items: center;
            align-self: stretch;
        }
        .container3_bnt1_wi{
            position: relative;
            padding: 0px;
            margin: 9px;
            align-self: stretch;
            flex: 0 1 auto;
        }
        .container3_bnt2_wi{
            position: relative;
            padding: 0px;
            margin: 9px;
            margin-left: 4px;
            align-self: stretch;
            flex: 0 1 auto;
        }
        #container4_wi{
            display: flex;
            flex-direction: column;
            flex: 1 1 auto;
            padding: 0px 20px 0px 40px;
            overflow-y: auto;
            height: calc((100vh - 126px) - 38px);
        }
        .post_wi{
            border-bottom: 1px solid rgb(225, 225, 225);
            display: flex;
            flex-direction: row;
            -webkit-box-align: center;
            align-items: center;
            font-size: 14px;
        }
        .post__sec{
            min-width: 0px;
            width: 100%;
        }
        .post_writer_wi{
            flex: 0 0 136px;
            padding: 0px 16px 0px 24px;
            font-size: 14px;
            line-height: 1.54;
            font-weight: normal;
            width: 104px;
            display: flex;
            flex-direction: row;
            overflow:hidden;
            background-color: transparent;
            cursor: pointer;
            transition: color 0.2s ease 0s, background-color 0.2s ease 0s;
            color: rgb(34, 34, 34);
            pointer-events: auto;
        }
        .post_title_wi{
            display: flex;
            flex-direction: row;
            -webkit-box-align: center;
            align-items: center;
            min-width: 0px;
            flex: 1 1 0%;
            padding: 4px 0px;
            width: 100%;
            line-height: 1.54;
            color: rgb(34, 34, 34);
            transition: color 0.2s ease 0s;
            white-space: nowrap;
            text-overflow: ellipsis;
            padding: 6px 0px 6px 8px; 
        }
        .post_title_wi > a{
            margin-left: 5px;
        }
        .post_date_wi{
            flex: 0 0 110px;
            padding-right: 10px;
            text-align: right;
            color: rgb(136, 136, 136);
        }
        #space_body_wi{
            display:flex;
            overflow-x: hidden;
            min-width: 680px;
        }
        .scroll_bar{
            background: transparent;
            overflow-y:auto;
        }
        .scroll_bar::-webkit-scrollbar{
            width:4px;
        }
        .scroll_bar::-webkit-scrollbar-thumb{
            height: 20%; /* 스크롤바의 길이 */
            background-color: #e1e1e1; /* 스크롤바의 색상 */
            border-radius:2px;
        }
        .back_img_wi{
            width: 24px;
            height: 24px;
            /* background-image: url(/COLLABEE/img/back_img_wi.svg); *//*칸반 모양임*/
            background-size: cover;
            background-repeat: no-repeat;
            padding-top: 2.4px;
            display: flex;
            align-items: center;
            -webkit-box-pack: center;
            justify-content: center;
        }
        .emoji1_wi{
            width: 14.4px;
            height: 14.4px;
            display: inline-block;
/*             background-image: url(/COLLABEE/img/emiji.png); *//*이모티콘*/
            background-size: 5700% 5700%;
        }   
        .emoji2_wi{
            font-size: 0;
            margin: 0;
            padding: 0;
        }
        .click_tab{
    		color:black !important;
    		border-bottom:2px solid black !important;
    		font-weight:bold !important;
    	}
        .check_filter{
            height: 20px;
            width: 20px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23D9AD2B' fill-rule='evenodd' d='M17,3 C19.209139,3 21,4.790861 21,7 L21,17 C21,19.209139 19.209139,21 17,21 L7,21 C4.790861,21 3,19.209139 3,17 L3,7 C3,4.790861 4.790861,3 7,3 L17,3 Z M16.59,7.58 L10,14.17 L7.41,11.59 L6,13 L10,17 L18,9 L16.59,7.58 Z'%3E%3C/path%3E%3C/svg%3E");
        }
        .uncheck_filter{
            height:20px;
            width:20px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23bdbab7' fill-rule='evenodd' d='M17,3 C19.209139,3 21,4.790861 21,7 L21,17 C21,19.209139 19.209139,21 17,21 L7,21 C4.790861,21 3,19.209139 3,17 L3,7 C3,4.790861 4.790861,3 7,3 L17,3 Z M17,5 L7,5 C5.9456382,5 5.08183488,5.81587779 5.00548574,6.85073766 L5,7 L5,17 C5,18.0543618 5.81587779,18.9181651 6.85073766,18.9945143 L7,19 L17,19 C18.0543618,19 18.9181651,18.1841222 18.9945143,17.1492623 L19,17 L19,7 C19,5.9456382 18.1841222,5.08183488 17.1492623,5.00548574 L17,5 Z'%3E%3C/path%3E%3C/svg%3E");
        }
        .check_alarm{
            width:20px;
            height:20px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' %3E%3Cpath fill='%23fff' d='M11.65 21c.99 0 1.8-.81 1.8-1.8h-3.6c0 .99.81 1.8 1.8 1.8zm5.85-5.4v-4.95A5.848 5.848 0 0 0 13 4.962V4.35C13 3.603 12.397 3 11.65 3c-.747 0-1.35.603-1.35 1.35v.612a5.848 5.848 0 0 0-4.5 5.688v4.95L4 17.4v.9h15.3v-.9l-1.8-1.8z'%3E%3C/path%3E%3C/svg%3E");        }
        .uncheck_alarm{
            width:20px;
            height:20px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' %3E%3Cpath fill='%23fff' d='M11.65 21c.99 0 1.8-.81 1.8-1.8h-3.6c0 .99.81 1.8 1.8 1.8zm5.85-10.35A5.848 5.848 0 0 0 13 4.962V4.35C13 3.603 12.397 3 11.65 3c-.747 0-1.35.603-1.35 1.35v.612a5.6 5.6 0 0 0-1.305.504l8.505 8.496V10.65zm-.243 7.65l1.8 1.8 1.143-1.143L5.143 3.9 4 5.043 6.628 7.67A5.784 5.784 0 0 0 5.8 10.65v4.95L4 17.4v.9h13.257z'%3E%3C/path%3E%3C/svg%3E");
        }
        .checkOn{
            width:20px;
            height:20px;
            margin-right:5px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23D9AD2B' fill-rule='evenodd' d='M12 7c-2.76 0-5 2.24-5 5s2.24 5 5 5 5-2.24 5-5-2.24-5-5-5zm0-5C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z'%3E%3C/path%3E%3C/svg%3E");
        }
        .checkOff{
            width:20px;
            height:20px;
            margin-right:5px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23bdbab7' fill-rule='evenodd' d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z'%3E%3C/path%3E%3C/svg%3E");
        }
        .alert{/*padding 확인하기 해야됨*/
            background-color:rgb(66,64,63);
            color:rgb(255,255,255);
            font-size:14px;
            width:320px;
            height:auto;
            border-radius:4px;
            position:fixed;
            bottom:0;
            margin:20px;
            padding:10px;
            overflow:auto;
            line-height:1.6;
            display:none;
            z-index:200;
            box-shadow: 0px 11px 15px -7px rgb(0 0 0 / 20%), 0px 24px 38px 3px rgb(0 0 0 / 14%), 0px 9px 46px 8px rgb(0 0 0 / 12%);
        }
        .closed{
            float:right;
            cursor:pointer;
        }
    </style>
    <style>
        .filter_order_content{
            font-size:13px;
            border-radius: 4px;
            box-shadow: rgb(0 0 0 / 10%) 0px 0px 6px 2px;
            background-color: rgb(255, 255, 255);
            padding: 16px 0px 0px 16px;
            position:absolute;
            transform: translate3d(540px,38px, 0px);
            top: 0px;
            left: 0px;
            will-change: transform;
        }
        .filter_order_sec{
            display: flex;
            flex-direction: row;
        }
        .filter_order_style{
            display: flex;
            flex-direction: column;
            min-width: 144px;
            margin-right: 16px;
        }
        .filter_style1{
            max-height: 167px;
        }
        .order_style1{
            color: rgb(34, 34, 34);
            font-size: 13px;
            line-height: 30px;
            transition: background-color 0.2s ease 0s;
        }
        .filter_wi{
            display: flex;
            flex-direction: row;
            -webkit-box-align: center;
            align-items: center;
            height: 30px;
            color: rgb(34, 33, 32);
            cursor: pointer;
            transition: background-color 0.2s ease 0s;
        }
        .filter_wi:hover{
            color: rgb(97, 95, 92);
        }
        .filter_order_title{
            margin-bottom: 4px;
            color: rgb(136, 136, 136);
            font-weight: normal;
            font-size: 12px;
            line-height: 18px;
        }
        .set_bnt_wi{
            height: 28px;
            padding: 0px 12px;
            border-radius: 4px;
            background-color: rgb(217, 173, 43);
            color: rgb(255, 255, 255);
            font-weight: bold;
            cursor: pointer;
        }
        .order_style2{
            display: flex;
            flex-direction: row;
            align-items: center;
            cursor: pointer;
            transition: background-color 0.2s ease 0s;

        }
        .order_style2:hover{
            color: rgb(97, 95, 92);
        }
        .scroll_bar2{
            background: transparent;
            overflow-y:auto;
        }
        .scroll_bar2::-webkit-scrollbar{
            width:4px;
        }
        .scroll_bar2::-webkit-scrollbar-thumb{
            height: 20%; /* 스크롤바의 길이 */
            background-color: #e1e1e1; /* 스크롤바의 색상 */
            border-radius:2px;
        }
        .scroll_bar2 input[type="checkbox"], #order_update_wi, #order_create_wi{
        	display:none;
        }
        label[for="order_update_wi"] svg, label[for="order_create_wi"] svg{
        	margin-right:5px;
        }
        .none{
            display:none;
            
        }
    </style>
    <style>
        .row{
            display:flex;
            flex-direction: row;
        }
        #right_bar{
            background-color: transparent;
            flex: 0 0 auto;
            width: 250px;
            overflow-y: auto;
            height: calc((100vh - 126px) - 38px);
            padding: 42px 26px 20px 20px;
        }
        .schedule_icon{
            width:17px;
            height:17px;
            padding:8px;
            margin-top:5px;
        }
        .icon_sche1{
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' style='fill: rgb(225,225,225);' viewBox='0 0 24 24'%3E%3Cpath d='M17 12h-5v5h5v-5zM16 1v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2h-1V1h-2zm3 18H5V8h14v11z' color='%23E1E1E1'%3E%3C/path%3E%3C/svg%3E");
        }
        .icon_sche2{
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' style='fill: rgb(196,196,196);' viewBox='0 0 24 24'%3E%3Cpath d='M17 12h-5v5h5v-5zM16 1v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2h-1V1h-2zm3 18H5V8h14v11z' color='%23E1E1E1'%3E%3C/path%3E%3C/svg%3E");
        }
        .post_schedule{
            padding-bottom: 4px;
            color: rgb(136, 136, 136);
            font-size: 14px;
            line-height: 1.57;
            transition: color 0.2s ease 0s;
        }
        #right_bar ::placeholder{
            border: none;
            border-radius: 0px;
            width: 168px;
            background-color: rgb(255, 255, 255);
            font-size: 12px;
            color:rgb(196,196,196);
            line-height: 1.5;
            margin-bottom: 2px;

        }
        .searchbar { /*상단 검색창*/
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
        .searchbar::placeholder{
			color:rgb(196, 196, 196);
		}
		.searchbar:hover, .searchbar:hover::placeholder{
			border-color:rgb(136, 136, 136);
			color:rgb(136, 136, 136);
		}
        .searchbar:focus{
			background-color: rgba(255, 255, 255, 0.2);
			border-color:rgb(136, 136, 136);
			width:269px;
		}
        .bnt_base{/*아이콘 기본스타일*/
            height: 28px;
            min-width: 28px;
            border: 1px solid rgb(224, 221, 217);
            border-radius: 6px;
            color: rgb(34, 34, 34);
            line-height: 25px;
            -webkit-box-align: center;
            align-items: center;
            padding: 0px !important;
            display:flex;
        }
        .search_icon{
			fill:rgb(224, 221, 217);
			position: absolute;
			transition: fill 0.2s ease 0s;
			-webkit-box-align: center;
			border:none;
			display:flex;
		}
        .search_icon:hover svg path{
            fill:rgb(136,136,136);
        }
        .micro{
            margin-left: 7px;
        }
        .hidden{
            visibility:hidden;
            opacity:0;
        }
        .nonPost{
        	align-items: center;
        	margin:auto 0;
        }
    </style>
	<style>
    .postbox_mp1{
		line-height: 2.5;
		border-bottom:1px solid rgb(225, 225, 225);
	}
	.post_info{
		height:65px;
	}
	.post_title{
		all: unset;
		cursor: pointer;
		display: block;
		overflow-wrap: break-word;
		font-size: 13px;
		color: rgb(34, 34, 34);
		white-space: nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
		line-height: 14px;
		padding-top:15px;
	} 
	.ws_name {
		padding-right: 8px;
		font-size: 12px;
		transition: color 0.2s ease 0s;
		color:  rgb(51, 132, 108);
		cursor: pointer;
	}
	.post_date {
		color: rgb(136, 136, 136);
		font-size: 12px;
	}
	.kb_icon {
		width: 20px;
   		height: 20px;
		background-color: transparent;
  		cursor: pointer;
	}
	.icon_mp {
		float:left;
		width:43px;
		height:67px;
		text-align: right;
		line-height:3;
		padding-right: 4px;
	}
    </style>	
	<script>
    $(function(){

	var loginId = <%=loginId%>;
	var workspaceName = "<%=workspaceName%>";
	var workspaceId = <%=workspaceId%>;
	
    	//메인 문서 리스트
    	$.ajax({
			type:"post", 
			url:"Controller?command=workspacePostList",
			data:{
				"workspaceId" : workspaceId
			},
			datatype:"json",
			success:function(data){
				if(data.length==0){
					$("#container4_wi .nonPost").css("display","flex");	
				} else {
					$("#container4_wi .nonPost").css("display","none");
				
					$.each(data, function(index, item) {
	         			var box = "<a href='Controller?command=showNewDocument&documentId="+item.document_id+"&workspaceId="+workspaceId+"&workspaceName="+workspaceName+"&loginId="+loginId+"'>"
	         			+ "<div class='post_wi'>"
	         			+ "<div class='post_writer_wi'>"+item.name+"</div>" //칸반 아이콘!
	                    + "<div class='post_title_wi'><span class='back_img_wi'><span class='emoji2_wi'><span class='emoji1_wi' style='background-position: 55.3571% 60.7143%;'></span></span></span>"+item.title+"</div>"
	                    + "<div class='post_date_wi'>"+item.creation_date+"</div>"
	                	+ "</div></a>";
	                	
		                $("#post_sec").append(box); 
					});
				}
					$("#title_wi").text(workspaceName);
				},
				error:function(r,s,e) {
					alert("error!");	
				}
   	 	}); //post ajax
    	
        var x = "<svg viewBox='0 0 24 24' width='24px' height='24px' class='closed'><path fill='rgb(255,255,255)' d='M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z'></path></svg>";
        
        //공간 이름 버튼
        $("#container1_wi button:nth-child(1)").on("click",function(){
        	location.href="Controller?command=select_Workspace_Index&workspaceId="+workspaceId+"&workspaceName="+workspaceName;
        });
        
        //협업공간 알림
        $("#alarm_wi").click(function(){
            //아이콘 바꾸기
            var text = $(this).attr("class");
            
            if(text=="icon2_color check_alarm"){
               	//알람 update
				$.ajax({
					type:"get", 
					url:"Controller?command=workspace_Alarm",
					data:{
						"loginId":loginId,
						"onAlarm":0,
						"workspace_id":workspaceId
					},
					datatype:"json",
					success: function(data) {
		                //안내메세지 뜨기
		                var alert_message = $(".alert").html(x+workspaceName+" 협업공간의 알림이 꺼졌습니다. 할일/의사결정 등은 알려드립니다.");
		                    alert_message.fadeIn(function(){
		                        setTimeout(function() {
		                            alert_message.fadeOut() //3초후에 자동으로 닫힘
		                        }, 2000);
		                        //안내메세지 높이
		                        var height = alert_message.prop("scrollHeight");
		                        alert_message.css("height", height);
		                    });
					},
					error: function(r,s,e) {
						alert("error");
					}
				});					                	
            } else {
            	$.ajax({
					type:"post", 
					url:"Controller?command=workspace_Alarm",
					data:{
						"loginId":loginId,
						"onAlarm":1,
						"workspace_id":workspaceId
					},
					datatype:"json",
					success:function(data){
	                	//안내메세지 뜨기
		                var alert_message = $(".alert").html(x+workspaceName+" 협업공간의 알림이 켜졌습니다. 이제부터 모든 알림을 받을 수 있습니다.");
	                    alert_message.fadeIn(function(){
	                        setTimeout(function() {
	                            alert_message.fadeOut(); //3초후에 자동으로 닫힘
	                        }, 2000);
	                        //안내메세지 높이
	                        var height = alert_message.prop("scrollHeight");
	                        alert_message.css("height", height);
	                    });
					}
				});
            }//else
            $(this).toggleClass("check_alarm, uncheck_alarm");
        }); //done.
        
        $("#title_wi").click(function(){
            location.href="Controller?command=select_Workspace_Index&workspaceId="+workspaceId+"&workspaceName="+workspaceName;
        });
        
        //kanban 버튼
        $("#container1_wi button:nth-child(2)").click(function(){
            location.href="Controller?command=KanbanList";
        }); 
        
        //중앙탭 클릭하면 현재 어디인지 
        $("#container1_wi button, #container1_pi button").click(function(){
            $(this).addClass("click_tab");
            $(this).siblings().removeClass("click_tab");//본문도 바뀜 일반, 프라이빗(해야됨)
        });
        
        $("#container3_wi button:nth-child(1)").click(function(){
            alert("서비스 준비중입니다.");
        });

        //필터 열고 닫기
        $("#container3_wi button:nth-child(2)").click(function(){
            $("#click_filter").toggle();
        });
		
        //전체선택
        $(".scroll_bar2 > div").click(function() {
	        if($("#checkAll").is(":checked")) {
	        	$("input[name=chkbox]").prop("checked", true);
	        } else {
	        	$("input[name=chkbox]").prop("checked", false);
	        }
        });
        
        $(".scroll_bar2 > div").click(function(){
        	var box = $("input[name=chkbox]").length;
        	var chkOn = $("input[name=chkbox]:checked").length;
  
        	if(box == chkOn) {
        		$("#checkAll").prop("checked", true);
        	} else {
        		$("#checkAll").prop("checked", false);
        	}
        });
        
       /*  $(".scroll_bar2 div").click(function(){//필터중 하나를 누르면
            var text = $(this).parent().parent().text();//필터의 텍스트 가져오기
      
            if(text=="전체 선택") { //전체선택 필터면
                $(".check_filter .uncheck_filter").toggleClass("check_filter uncheck_filter");//모든 필터 체크/언체크 동시에 됨
            } else {
            	
                //개별선택 필터면
                //칸반개수(ajax로 가능?) vs. label개수-1이 같으면 전체에 체크
                var filterCnt = $(".scroll_bar2 div").length-1; //전체개수
                var chkOn = $(".check_filter").length-1; //체크된 개수
                var chkOff = $(".uncheck_filter").length-1; //체크안된 개수
                $(this).toggleClass("check_filter uncheck_filter");
                
                //눌렀을때뭔지
                if(filterCnt==chkOn){ //전체개수랑 체크된 개수 같으면 전체선택 체크해제
                    $("#checkAll").removeClass("check_filter").addClass("uncheck_filter");
                } else if(filterCnt==chkOff) {
                    $("#checkAll").removeClass("uncheck_filter").addClass("check_filter");
                    alert("!!");
                }
            }
        }); */
/* 
        $('input:radio[name="order"]').on("click", function(){//왜 한번만 실행?(해야됨)
        	var idName = $(this).attr("id");
        	var className = $(this).attr("class"); 
        	var fl;
        	if(idName=="update") {
        		fl = 0;	
        	} else {
        		fl = 1;
        	}
        	alert($('input:radio[name="order"]').is(':checked'));
        	
        	if($(this).is(':checked')!=true) {
        		$(this).addClass("checkOn").removeClass("checkOn");
        	} 
        	 */
        	//현재 내가 있는 공간 쿠키 가능?
     		/* if(className=="checkOff") {
     			$(this).removeClass("checkOff").addClass("checkOn");		
	        	$(this).parent().parent().siblings().find("checkOn").removeClass("checkOn").addClass("checkOff");
     		} */
     	
        	
            //datepicker
            /* $("#startD, #endD").datepicker({//datepicker호출 
                dateFormat:"yy.m.d" ,showOthermonths: true ,showMonthAfterYear:true
                ,buttonImageOnly:true ,yearSuffix:"년", monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"]
                ,dayNamesMin:["일", "월","화","수","목","금","토"]
                , showButtonPanel:true, currentText:"오늘", closeText:"닫기"
                ,onSelect:function(dataText, inst) {
                    var d = dataText;
                    var arr=d.split(".");
                    var year=arr[0]; //연도
                    var month=arr[1]; //월
                    var day=arr[2]; //일
                    //$("#start_sche").datepicker("setDate", new Date(d)); //일정창에 값 넣기
                	//$("#end_sche").datepicker("setDate", new Date(d));
                }//뭐가 start인지 end인지 구분 해야됨
            });
            
            //현재날짜 가져오기
            $("#startD, #endD").datepicker("setDate", new Date()); 
            
            //finish가 start보다 전이면 start가 선택한 finish 날짜로 변함
            $('#startD').datepicker("option", "onClose", function (selectedDate) {
                $("#endD").datepicker("option", "minDate", selectedDate);
            }); */

            //일정 위젯 누르면  동적 어쩌구
           /*  $(document).on("click", "input[title='일정제목']", function(){
                var className = $(this).parent().siblings().attr("class");
                if(className=="schedule_icon icon_sche1") {
                	 $(".workspace_sel").text("프라이빗 공간").css("color","");
                     $("#todo_modal").css({visibility:"visible", opacity:1}); //작성된 일정모달 뜸
                     $(".icon3_sch svg").css({visibility:"visible", opacity:1});
                } else {
                    //저장된 일정 뜨기(검정글씨들 해야됨)
                }
            }); */
            
            // 할일 클릭 모달
            $("#bnt2_1").on("click", function(){
            	location.href="Controller?command=ModalPartnerList";
            });
            
            //일정버튼 클릭 모달
            $("#bnt2_2").on("click", function(){
            	$("#schedule").removeClass("hidden");
            });
   
        //문서작성버튼    
		$(document).on("click", "#document_bnt_wi", function(){ 
			location.href="Controller?command=writedocument&workspaceId="+workspaceId+"&loginId="+loginId;
		});
		
        //내가 작성한 문서
		$("#mypost").click(function(){
			$("#post_sec").addClass("none");
		
			$.ajax({
				type:"post",
				url:"Controller?command=myWorkspacePost",
				data:{
					"loginId":loginId,
					"workspaceId":workspaceId
				},
				datatype:"json",
				success:function(data){
					$("#container4_wi").empty();
					$.each(data, function(index, item) {
						var add = "<div class='postbox_mp1 row'>"			
							+"<div class='icon_mp' style='padding-top: 7px;'><img src='"+item.kanban_icon_p+"' class='kb_icon'></div>"
							+"<div class='post_info column'>"
							+"<span class='post_title'>"+item.title+"</span>"
							+"<div class='row'>"
							+"<span class = 'ws_name'>"+item.workspace_name+"</span>"
							+"<span class ='post_date'>"+item.date+"</span>"
							+"</div>"
							+"</div>"
							+"</div>";
							
						$("#container4_wi").append(add);
					});
				}
			});
		});
		
		//검색
		$(".searchbar").keypress(function(e){
    	    if(e.keyCode == 13){
    			var search = $(this).val();
    		    location.href="Controller?command=SearchP1&search="+search+"&member_id="+loginId;
    		}
		});
		
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

<body>
	<%@ include file="WEB-INF/include/include_PartnerModal.jspf" %>

	<%@ include file="WEB-INF/include/include_NewWorkspaceModal.jspf"%>
	
	<%@ include file="WEB-INF/include/include_SettingWorkspace.jspf"%>
	
	<%@ include file="WEB-INF/include/include_InviteMembers.jspf"%>
	
    <div class="alert"></div>
	
	<%-- <%@ include file="WEB-INF/include/Todo_modal.jsp"%>  --%>
    
<div id="workspace_index">
	<%@ include file="WEB-INF/include/include_ScheduleModal.jspf"%>
<div>
	<%@ include file="WEB-INF/include/HomeSidebar.jspf"%>
</div>
    <!-- 메인페이지 -->
    <section id="space_main_wi"> <!--필터 선택&열고닫기 -->
        <header>
            <div id="head1_wi" style="white-space:nowrap;">
                <div id="bnt3_wi" class="row">
                    <div class="row">
                        <div id="title_wi" style="color:#fff"></div>
                        <div id="bnt1_wi">
                            <button type="button" id="alarm_wi" class="icon2_color check_alarm"></button>
                            <button type="button" class="icon2_color"><svg id="setting_wi" viewBox="0 0 24 24" width="20px" height="20px"><path d="M19.43 12.98c.04-.32.07-.64.07-.98 0-.34-.03-.66-.07-.98l2.11-1.65c.19-.15.24-.42.12-.64l-2-3.46c-.12-.22-.39-.3-.61-.22l-2.49 1c-.52-.4-1.08-.73-1.69-.98l-.38-2.65A.488.488 0 0 0 14 2h-4c-.25 0-.46.18-.49.42l-.38 2.65c-.61.25-1.17.59-1.69.98l-2.49-1c-.23-.09-.49 0-.61.22l-2 3.46c-.13.22-.07.49.12.64l2.11 1.65c-.04.32-.07.65-.07.98 0 .33.03.66.07.98l-2.11 1.65c-.19.15-.24.42-.12.64l2 3.46c.12.22.39.3.61.22l2.49-1c.52.4 1.08.73 1.69.98l.38 2.65c.03.24.24.42.49.42h4c.25 0 .46-.18.49-.42l.38-2.65c.61-.25 1.17-.59 1.69-.98l2.49 1c.23.09.49 0 .61-.22l2-3.46c.12-.22.07-.49-.12-.64l-2.11-1.65zM12 15.5c-1.93 0-3.5-1.57-3.5-3.5s1.57-3.5 3.5-3.5 3.5 1.57 3.5 3.5-1.57 3.5-3.5 3.5z"></path></svg></button>
                        </div>
                       </div> 
                    <div>
                        <div class="search_icon" class="bnt_base"><svg class="micro" style="margin-top:6px;" viewBox="0 0 24 24" width="16px" height="16px"><path d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"></path></svg></div>
                        <input type ="text" class="searchbar" placeholder="검색"/>
                    </div>
                </div>
                <div id="textarea_wi"><textarea id="summary_wi" placeholder="협업공간에 대한 간단한 설명을 입력하세요."></textarea></div>
                <div id="bnt2_wi">
                    <button type="button" id="bnt2_1"><svg viewBox="0 0 24 24" width="18px" height="18px" class="icon2_color"><path d="M12 1.5C6.204 1.5 1.5 6.204 1.5 12S6.204 22.5 12 22.5 22.5 17.796 22.5 12 17.796 1.5 12 1.5zM9.9 17.25L4.65 12l1.48-1.48 3.77 3.758 7.97-7.969L19.35 7.8 9.9 17.25z"></path></svg><span>할 일</span></button>
                    <button type="button" id="bnt2_2"><svg viewBox="0 0 24 24" width="18px" height="18px" class="icon2_color"><path d="M17 12h-5v5h5v-5zM16 1v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2h-1V1h-2zm3 18H5V8h14v11z"></path></svg><span>일정</span></button>
                    <button type="button" id="bnt2_3"><svg viewBox="0 0 24 24" width="18px" height="18px" class="icon2_color"><path d="M16.5 6v11.5c0 2.21-1.79 4-4 4s-4-1.79-4-4V5a2.5 2.5 0 0 1 5 0v10.5c0 .55-.45 1-1 1s-1-.45-1-1V6H10v9.5a2.5 2.5 0 0 0 5 0V5c0-2.21-1.79-4-4-4S7 2.79 7 5v12.5c0 3.04 2.46 5.5 5.5 5.5s5.5-2.46 5.5-5.5V6h-1.5z"></path></svg><span>파일</span></button>
                    <button type="button" id="bnt2_4"><svg viewBox="0 0 24 24" width="18px" height="18px" class="icon2_color"><path d="M2.833 4h13.75c.633 0 1.128.32 1.458.807L23 12.25l-4.96 7.434c-.33.486-.888.816-1.52.816H2.832A1.839 1.839 0 0 1 1 18.667V5.833C1 4.825 1.825 4 2.833 4zm11.917 9.625c.76 0 1.375-.614 1.375-1.375 0-.76-.614-1.375-1.375-1.375-.76 0-1.375.614-1.375 1.375 0 .76.614 1.375 1.375 1.375zm-4.583 0c.76 0 1.375-.614 1.375-1.375 0-.76-.614-1.375-1.375-1.375s-1.375.614-1.375 1.375c0 .76.614 1.375 1.375 1.375zm-4.584 0c.761 0 1.375-.614 1.375-1.375 0-.76-.614-1.375-1.375-1.375-.76 0-1.375.614-1.375 1.375 0 .76.614 1.375 1.375 1.375z"></path></svg><span>의사결정</span></button>
                    <button type="button" id="document_bnt_wi"><svg viewBox="0 0 24 24" width="18px" height="18px" class="icon2_color"><path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04a.996.996 0 0 0 0-1.41l-2.34-2.34a.996.996 0 0 0-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"></path></svg><span>문서 작성</span></button>
                </div>
            </div>
          
        <div class="topright1" style="display:flex; flex-direction:column;">
			<%@ include file="WEB-INF/include/homehead4.jspf" %>
	   		<div class="subheader_right3">
				<div class="subheader_right3_menu"></div>
			</div>
   	    </div>
        </header>
        

        <div id="tab_wi">
            <div id="container1_wi"> <!-- 협업공간탭 -->
                <button type="button" class="click_tab"><span>협업공간 문서</span></button>
                <button type="button"><span>칸반</span><svg width="24px" height="24px" viewBox="0 0 24 24"><g fill="none" fill-rule="evenodd"><path d="M0 0h14v14H0z"></path><path fill="#888888" d="M6.417 9.917h1.166v-3.5H6.417v3.5zM7 1.167C3.78 1.167 1.167 3.78 1.167 7S3.78 12.833 7 12.833 12.833 10.22 12.833 7 10.22 1.167 7 1.167zm0 10.5A4.674 4.674 0 012.333 7 4.674 4.674 0 017 2.333 4.674 4.674 0 0111.667 7 4.674 4.674 0 017 11.667zM6.417 5.25h1.166V4.083H6.417V5.25z"></path></g></svg></button>
                <button type="button"><span>간트차트</span></button>
                <button type="button"><span>캘린더</span></button>
                <button type="button" id="mypost"><span>내가 작성한 문서</span></button>
            </div>
            
            <div id="container1_pi" class="hidden"> <!-- 프라이빗탭 -->
                <button type="button" class="click_tab"><span>프라이빗 문서</span></button>
                <button type="button"><span>캘린더</span></button>
            </div>
            
            <div id="container3_wi">
                <button type="button"><svg viewBox="0 0 24 24" width="19px" height="19px" class="container3_bnt1_wi icon1_color"><path d="M13.056 16h-3L9.5 21h-2l.556-5H5.5v-2h2.778l.444-4H6.5V8h2.444L9.5 3h2l-.556 5h3l.556-5h2l-.556 5H18.5v2h-2.778l-.444 4H17.5v2h-2.444l-.556 5h-2l.556-5zm.222-2l.444-4h-3l-.444 4h3z" ></path></svg></button>
                <button type="button"><svg viewBox="0 0 24 24" width="19px" height="19px" class="container3_bnt2_wi icon1_color"><path d="M3 18h6v-2H3v2zM3 6v2h18V6H3zm0 7h12v-2H3v2z"></path></svg></button>
            </div>

            <!-- 필터 보류--> 
            <!-- <div id="click_filter" class="filter_order_content" style="display:none; z-index: 1;">
                <div class="filter_order_sec">
                    <div class="filter_style1 filter_order_style">
                        <div class="filter_order_title">필터</div>
                        <div class="scroll_bar2">
                            <div><label class="filter_wi"><span id="checkAll" class="check_filter"></span><input type="checkbox">전체 선택</label></div>
                            <div><label class="filter_wi"><span name="chkbox" class="check_filter"></span><input type="checkbox">아고라</label></div>
                            <div><label class="filter_wi"><span name="chkbox" class="check_filter"></span><input type="checkbox">지현</label></div>
                            <div><label class="filter_wi"><span name="chkbox" class="check_filter"></span><input type="checkbox">정민</label></div>
                            <div><label class="filter_wi"><span name="chkbox" class="check_filter"></span><input type="checkbox">태안</label></div>
                            <div><label class="filter_wi"><span name="chkbox" class="check_filter"></span><input type="checkbox">유라</label></div>
                        </div>
                    </div>
                    <div class="order_style1 filter_order_style">
                        <div class="filter_order_title">정렬</div>
                        <div id="order_box">
                            <div><label for="order_update_wi" class="order_style2"><span id="update" class="checkOn"></span><input type="radio" name="order" id="order_update_wi">업데이트 순</label></div>
                            <div><label for="order_create_wi" class="order_style2"><span id="create" class="checkOff"></span><input type="radio" name="order" id="order_create_wi">최신 등록 순</label></div>
                        </div>
                    </div>
                </div>
                <div style="padding:15px; text-align:right;"><button class="set_bnt_wi">적용</button></div>
            </div> -->

            <div id="container2_wi">
                <button class="tab1_bnt"><span>할 일</span></button>
                <button class="tab1_bnt"><span>의사결정</span></button>
                <button class="tab1_bnt2"><span>파일함<svg viewBox="0 0 24 24" width="12px" height="12px"><path d="M17.0278306,8 C18.1356358,8 18.40014,8.63354932 17.6171348,9.41655445 L13.4502437,13.5834455 C12.6679023,14.365787 11.40014,14.3664507 10.6171348,13.5834455 L6.45024373,9.41655445 C5.66790231,8.63421303 5.93074941,8 7.03954794,8 L17.0278306,8 Z" ></path></svg></span></button>
            </div>
        </div>

        <section id="space_body_wi" class="scroll_bar">
        <!-- 문서 목록 . 문서 작성하면 에이젝스로 보내고 다시 가져와서 preppend()함  -->
            <div id="container4_wi" class="scroll_bar">
            <div class="nonPost column">
            	<div>
            		<svg width="71px" height="71px" viewBox="0 0 24 24"><path fill="#e1e1e1" fill-rule="evenodd" d="M14.4 6L14 4H5v17h2v-7h5.6l.4 2h7V6z"></path></svg>
            	</div>
            	<p style="text-align: center;">협업공간에서 관련된 문서를 작성해 보세요.<br/>멤버를 초대하면 커뮤니케이션 할 수 있고, 문서를 공유받을 수 있어요.</p>
            </div>
            <div id="post_sec"></div>
            </div>
            
            <div>
				<%@ include file="WEB-INF/include/Aside.jspf"%>
            </div>
            <%@ include file="WEB-INF/include/include_postedSchedule.jspf" %>
        </section>
    </section>
   
</div>
</body>
</html>