<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.one.dao.*"%>
<%@ page import="com.one.dto.*" %>
<%@ page import="java.util.*" %>

<%
	int loginId = (Integer)session.getAttribute("loginId");
	int corporation_id = (Integer)session.getAttribute("corporation_id");
	ArrayList<MyPostDto> postList = (ArrayList<MyPostDto>)request.getAttribute("postList");

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8"/>
	<title>내가 작성한</title>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<style>
		*{
            box-sizing: border-box;
        }
		body, div {
			font-family: -apple-system,BlinkMacSystemFont,Malgun Gothic,Hiragino Kaku Gothic ProN,Hiragino Sans,Meiryo,MS PGothic,sans-serif,Dotum;
			margin:0;
			padding:0;
			box-sizing: border-box;
		}
		a{
			text-decoration:none;
		}
		input, button{
			border:none;
			outline:none;
			box-shadow:none;
		}
		.mydocument{
			width: 100vw;
    		height: 100vh;
		}
		#title_mp{
			position: relative;
			height: 68px;
			display: flex;
			flex-direction: row;
			align-items: center;
			
		}
		#mypost_title{
			font-size: 22px;
    		font-weight: bold;
			margin-left: 45px;
			flex: 1 1 auto;
			display: flex;
			flex-direction: row;
			-webkit-box-pack: justify;
			justify-content: space-between;
			-webkit-box-align: center;
			align-items: center;
			white-space: nowrap;
		}	
		#mypost_title a{
			text-decoration: none;
			color: rgb(34, 34, 34);
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
		.searchbar:hover, .searchbar:hover::placeholder{
			border-color:rgb(136, 136, 136);
			color:rgb(136, 136, 136);
		}
		.mastersearchbar:hover svg{ /*안됨*/
			fill:rgb(136, 136, 136);
		}
		.searchbar:focus:sibligs(svg){ /*안됨*/
			fill:rgb(136, 136, 136);
		}
		.searchbar:focus{
			background-color: rgba(255, 255, 255, 0.2);
			border-color:rgb(136, 136, 136);
			width:269px;
		}
		.searchbar::placeholder{
			color:rgb(196, 196, 196);
		}
		.searchbar:focus::placeholder{
			color:rgb(136, 136, 136);
		}
		.search_icon{
			fill:rgb(224, 221, 217);
			position: absolute;
			transition: fill 0.2s ease 0s;
			-webkit-box-align: center;
			border:none;
			display:flex;
		}
		.posting_bnt {/* 상단 문서작성버튼*/
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
			margin-right:80px;
			transition: background-color 0.2s ease 0s, color 0.2s ease 0s, border-color 0.4s ease 0s, fill 0.2s ease 0s, opacity 0.2s ease 0s;
		}
		.posting_bnt:hover{
			background-color: rgb(179, 142, 34);
    		border-color: rgb(179, 142, 34);
		}
		.posting_icon{ 
			fill: rgb(255, 255, 255);
			width:13px;
			height:13px;
		}
		.icon_color{
            fill: rgb(136, 136, 136);
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
		.month_bnt{/*버튼 스타일*/
            padding-left: 0px;
            padding-right: 0px;
            transition: fill 0.2s ease 0s;
            cursor: pointer;
            pointer-events: auto;
            width: auto;
            background-color: transparent;
            text-decoration: none;
            border-color: rgb(224, 221, 217) !important;
        }
		#minitab_mp{
			display: flex;
			flex-direction: row;
			-webkit-box-pack: justify;
			justify-content: space-between;
			/* position: relative; */
			z-index: auto;
			height: 38px;
			margin: 0px 20px;
			border-bottom: 1px solid rgb(225, 225, 225);
		}
		#mypost {
			font-weight: bold;
			color:rgb(34, 34, 34);
    		border-bottom:1px solid rgb(34, 34, 34);
			font-size: 12px;
			pointer-events: auto;
			height:38px;
			width:93px;	
			margin-left: 24px;
			line-height: 36px;
			position:relative;
		}
		#mypost a{
			text-decoration: none;
			color:rgb(34, 34, 34);
		}
		#mycomment{
			position:relative;
    		color: rgb(136, 136, 136);
			font-size: 12px;
			height:38px;
			width:93px;
			margin-left:31px;
			line-height: 36px;
			list-style:none;
		}
		label{
			cursor:pointer;
		}
		#mycomment a:hover {
			color:rgb(34, 34, 34);
			border-bottom:none;
		}
		#mycomment a{
			text-decoration: none;
			color: rgb(136, 136, 136);
		}
	
		#minitab_mp input{
			display:none;
		}
		#filter_mp{
			width:19px;
			height:19px;
			background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' style='fill: %23888888'%3E%3Cpath d='M3 18h6v-2H3v2zM3 6v2h18V6H3zm0 7h12v-2H3v2z'%3E%3C/path%3E%3C/svg%3E");
			margin-right:50px;
			background-color: transparent;
			margin-top:6px;
			list-style:none;
			transition: fill 0.2s ease 0s;
			cursor: pointer;
			pointer-events: auto;
		}
		.bnt_none{
			border:none;
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
			margin-top: 8px;
		}
		.icon_mp svg{
			fill:rgb(136,136,136);
		}
		.postbox_mp1{
			line-height: 2.5;
			border-bottom:1px solid rgb(225, 225, 225);
		}
		.postbox_mp2{
			float:left;
			line-height: 1.7;
			height:65px;
			border-bottom:1px solid rgb(225, 225, 225);
			margin-top:3px;
			
		}
		.left_tab_sec1{
			flex: 1 1 auto;
			display: flex;
			flex-direction: column;
			height: 100vh;
			overflow: auto;
			min-width: 690px;
		}
		.left_tab_sec2{
			display: flex;
			flex-direction: column;
			flex: 1 1 auto;
			padding: 0px 20px 0px 40px;
			overflow-y: auto;
			box-sizing: border-box;
			height: calc((100vh - 68px) - 38px);
		}
		
		.tab_style1{
			width: 100%;
			position: fixed;
			background-color: rgb(255,255,255);
			z-index: 1;
		}
		.right_bnt{  
			margin-right:260px;
            display: flex;
            -webkit-box-pack: end;
            -webkit-box-align: center;
		}
		.tab1_bnt{
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

		.left-bar::-webkit-scrollbar{
			width:4px;
			height:4px;
		}
		.left-bar::-webkit-scrollbar-thumb{
			height: 20%;
			background-color: #e1e1e1;
			border-radius: 2px;
		}
	</style>
	<style>
	.left_tab{ /*사이드메뉴바*/
		position: relative;
		width: 240px;
		background-color: rgb(247, 246, 245);
		flex: 0 0 auto;
		display: flex;
		flex-direction: column;
		-webkit-box-align: stretch;
		align-items: stretch;
		padding-top: 72px;
	}
	.mastersearchbar{
		display: flex;
		flex-direction: row;
		position: relative;
		align-items: center;
	}
	.micro{
		margin-left: 7px;
	}
	.row{
		display:flex;
		flex-direction: row;
	}
	.column{
		display:flex;
		flex-direction:column;
	}
	</style>
	<style>
	#myPostCommentList .post_date::before{
		content: "・";
		display: inline-block;
		padding-left: 4px;
		padding-right: 4px;
	}
	.post_name{
		color:rgb(136,136,136); 
		font-size:12px;
	}
	/*댓글필터*/
	.myCommentFilter1{
		width: 160px;
		border-radius: 4px;
		box-shadow: rgb(0 0 0 / 10%) 0px 0px 6px 2px;
		background-color: rgb(255, 255, 255);
		padding: 12px 0px;
	}
	.myCommentFilter2{
		position: absolute;
		transform: translate3d(685px, 106px, 0px);
		top: 0px;
		left: 0px;
		will-change: transform;
	}
	label[for="latest_comment"] {
		margin-left:17px;
	}
	#label_hover:hover{
		background-color: rgb(242, 242, 242);
	}

	/* 문서 필터*/
	.filter_style1{
		position: absolute;
		transform: translate3d(519px, 106px, 0px);/*학원 컴에서 위치 조정하기(해야됨)*/
		top: 0px;
		left: 0px;
		will-change: transform;
	}
	.filter_style2{
		border-radius: 4px;
		box-shadow: rgb(0 0 0 / 10%) 0px 0px 6px 2px;
		background-color: rgb(255, 255, 255);
		padding: 16px 0px 0px 16px;
		height:130px;
		width:176px;
	}
	.order_style1{
		color: rgb(34, 34, 34);
		font-size: 13px;
		line-height: 30px;
		transition: background-color 0.2s ease 0s;
	}
	.filter_order_title{
		margin-bottom: 4px;
		color: rgb(136, 136, 136);
		font-weight: normal;
		font-size: 12px;
		line-height: 18px;
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
	#order_create_p, #order_update_p, #latest_comment{
		display:none;
	}
	label[for="order_create_p"] svg, label[for="order_update_p"] svg{
		margin-right:5px;
	}
	</style>
	<style>
	input[type="checkbox" i] {
		background-color: initial;
		cursor: default;
		appearance: auto;
		box-sizing: border-box;
		margin: 3px 3px 3px 4px;
		padding: initial;
		border: initial;
	}
	input[type="checkbox"] {
	    display: none;
	}
	.left-bar {
	    position: relative;
	    overflow-y: auto;
	    flex: 1 1 auto;
	    overflow-x: hidden;
	}
	.sidebar {
	    z-index: 1;
	    position: relative;
	    width: 240px;
	    background-color: rgb(247, 246, 245);
	    flex: 0 0 auto;
	    display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	    padding-top: 72px;
	    overflow-y: auto;
	    margin-left: -10px;
	    margin-top: -10px;
	}
	::-webkit-scrollbar {
		width:4px;
	}
	::-webkit-scrollbar-thumb {
	    height: 70%; /* 스크롤바의 길이 */
	    background: #e1e1e1; /* 스크롤바의 색상 */
	    border-radius: 2px;
	}
	.top-row {
	    position: relative;
	    display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	}
	.header {
	    display: flex;
	    flex-direction: row;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    -webkit-box-align: center;
	    align-items: center;
	    padding: 0px 14px 0px 20px;
	    flex: 0 1 auto;
	    height: 72px;
	    top: 0px;
	    z-index: 9;
	    background-color: rgb(247, 246, 245);
	    width: 205px;
	    position: fixed;
	}
	.collabee {
	    min-width: inherit;
	    min-height: inherit;
	    padding-left: 0px;
	    padding-right: 0px;
	    transition: fill 0.2s ease 0s;
	    cursor: pointer;
	    pointer-events: auto;
	    width: auto;
	    background-color: transparent;
	    color: yellow;
	}
	.alarm {
	    padding-bottom: 4px;
	    min-width: inherit;
	    min-height: inherit;
	    padding-left: 0px;
	    padding-right: 0px;
	    transition: fill 0.2s ease 0s;
	    cursor: pointer;
	    pointer-events: auto;
	    width: auto;
	    background-color: transparent;
	    text-decoration: none;
	    border: none;
	    box-sizing: border-box;
	    font-size: 12px;
	    outline: 0;
	}
	.alarm_svg {
	    display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: gray;
	}
	.alarm_svg:hover{
		fill: #616060;
	}
	.left-navigation {
	    display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	    padding-bottom: 22px;
	}
	.menu {
	    background-color: rgba(0, 0, 0, 0.05);
	    cursor: pointer;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    background-color: transparent;
	    padding-left: 18px;
	    padding-right: 16px;
	    position: relative;
	    pointer-events: auto;
	}
	.menu:hover{
		background-color: #e3e3e3;
	}
	.fill_black {
	    fill: rgb(34, 34, 34);
	}
	.svg1 {
	    display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(136, 136, 136);
	}
	.name {
	    padding: 3px 0px;
	    margin-left: 4px;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    font-size: 14px;
	    line-height: 1.57;
	    color: rgb(34, 34, 34);
	}
	.bold {
	    font-weight: bold;
	}
	.btn1 {
	    display: inline-block;
	    background-color: transparent;
	    position: absolute;
	    top: 50%;
	    right: 16px;
	    width: 20px;
	    height: 20px;
	    transform: translate(0px, -50%);
	}
	.menu > .btn1:hover{
		background-color: #c7c5c5;
		border-radius: 4px;
	}
	.svg2 {
	    display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(34, 34, 34);
	    opacity: 0;
	}
	.calendar {
	    font-weight: bold;
	    cursor: pointer;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    background-color: transparent;
	    padding-left: 18px;
	    padding-right: 16px;
	}
	.calendar2 {
	    cursor: pointer;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    background-color: transparent;
	    padding-left: 18px;
	    padding-right: 16px;
	}
	.private {
	    display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	    padding-bottom: 22px;
	}
	.sidebar h2 {
	    margin: 0px;
	    padding-left: 20px;
	    padding-bottom: 2px;
	    font-size: 13px;
	    line-height: 1.54;
	    font-weight: normal;
	    color: rgb(136, 136, 136);
	}
	.new_workspace {
	    margin: 6px 16px 8px;
	    font-weight: bold;
	    font-size: 14px;
	    line-height: 1.57;
	    padding: 5px;
	    position: relative;
	    min-height: inherit;
	    color: rgb(255, 255, 255);
	    border-radius: 4px;
	    text-align: center;
	    transition: background-color 0.2s ease 0s, color 0.2s ease 0s, border-color 0.4s ease 0s, fill 0.2s ease 0s, opacity 0.2s ease 0s;
	    border-width: 1px;
	    border-style: solid;
	    border-color: rgb(51, 132, 108);
	    background-color: rgb(51, 132, 108);
	    cursor: pointer;
	    opacity: 1;
	    width: auto;
	    box-shadow: none;
	}
	.new_workspace:hover{
		background-color: rgb(44, 111, 91);
    	border-color: rgb(44, 111, 91);
	}
	.w_search {
	    box-sizing: border-box;
	    border: 1px solid rgb(193, 193, 193);
	    border-radius: 4px;
	    font-size: 13px;
	    color: rgb(34, 34, 34);
	    line-height: 1.54;
	    width: 100%;
	    padding: 4px 24px 4px 26px;
	}
	.w_search::placeholder{
		color:rgb(193,193,193);
	}
	.w_search:hover{
		border: 1px solid rgb(136,136,136);
	}
	.w_search:hover::placeholder{
		color: rgb(136,136,136);
	}
	.createFolder {
	    display: flex;
	    flex-direction: column;
	    padding-left: 16px;
	    padding-right: 16px;
	}
	.btn2 {
	    position: relative;
	    cursor: pointer;
	    background-color: transparent;
	}
	.btn2::before {
	    position: absolute;
	    right: 0px;
	    left: 0px;
	    height: 1px;
	    background-color: rgb(230, 230, 230);
	    content: " ";
	    top: 50%;
	}
	.contents {
	    position: relative;
	    display: inline-flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    background-color: rgb(247, 246, 245);
	    font-size: 12px;
	    color: rgb(136, 136, 136);
	    padding: 5px 4px;
	}
	.contents:hover{
		color:black;
	}
	.contents:hover svg{
		fill:rgb(136,136,136);
	}
	.svg3 {
	    margin-right: 4px;
	    display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(193, 193, 193);
	}
	.folder1 {
	    flex: 1 0 auto;
	    width: 100%;
	    box-sizing: border-box;
	    min-width: 0px;
	}
	.f_container {
	    position: relative;
	    display: flex;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    margin-top: 0px;
	    margin-bottom: 0px;
	    user-select: none;
	    padding: 0px 0px 0px 4px;
	    cursor: pointer;
	    background-color: transparent;
	}
	.f_container:hover{
		background-color: #e3e3e3;
	}
	.svg4 {
	    visibility: hidden;
	    flex-shrink: 0;
	    margin-right: 2px;
	    display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(193, 193, 193);
	}
	.f_container3 {
	    display: flex;
	    flex: 1 0 auto;
	    width: 100%;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    padding-right: 16px;
	}
	.svg5 {
	    display: inline-block;
	    vertical-align: middle;
	    shape-rendering: inherit;
	    fill: rgb(136, 136, 136);
	}
	.w_list {
	    flex: 1 0 auto;
	    width: 100%;
	    box-sizing: border-box;
	    min-width: 0px;
	    margin-left: 10px;
	    margin-top: -5px;
	}
	.f_container4 {
	    display: flex;
	    flex: 1 0 auto;
	    width: 100%;
	    flex-direction: row;
	    -webkit-box-align: center;
	    align-items: center;
	    margin-top: 2px;
	}
	.btn3 {
	    min-width: inherit;
	    min-height: inherit;
	    padding-left: 0px;
	    padding-right: 0px;
	    transition: fill 0.2s ease 0s;
	    cursor: pointer;
	    pointer-events: auto;
	    width: auto;
	    background-color: transparent;
	    text-decoration: none;
	    font-weight: 400;
	    color: gray;
	}
	.sidebar-footer {
	    display: flex;
	    flex-direction: column;
	    color: rgb(136, 136, 136);
	    font-size: 12px;
	    line-height: 1.5;
	    padding-top: 40px;
	    padding-left: 20px;
	    padding-bottom: 90px;
	}
	.alarm_expl {/*알람설정*/
	    display: none;
	    z-index: 10;
	    margin-left: 194px;
	    margin-top: 37px;
	    outline: none;
	    position: absolute;
	    width: 236px;
	    background-color: rgb(255, 255, 255);
	    height: 220px;
	    box-shadow: 0px 5px 5px -3px rgb(0 0 0 / 20%), 0px 8px 10px 1px rgb(0 0 0 / 14%), 0px 3px 14px 2px rgb(0 0 0 / 12%);
	}
	.sidebar h6 {
	    all: unset;
	    display: block;
	    font-size: 12px;
	    line-height: 1.5;
	    color: rgb(136, 136, 136);
	    padding: 12px 0px 4px 18px;
	}
	.alarm_expl2 {
	    display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	    padding-top: 0px;
	    padding-bottom: 12px;
	}
	.alarm_btn1 {
	    font-size: 13px;
	    font-weight: normal;
	    color: rgb(34, 34, 34);
	    text-align: left;
	    position: relative;
	    line-height: 1.5;
	    border-radius: 3px;
	    padding: 5px 18px;
	    background-color: transparent;
	    cursor: pointer;
	    border: none;
	}
	.alarm_expl3 {
	    display: flex;
	    flex-direction: column;
	    -webkit-box-align: stretch;
	    align-items: stretch;
	    border-top: 1px solid rgb(225, 225, 225);
	    padding: 12px 0px;
	}
	.alarm_expl4 {
	    position: relative;
	    color: rgb(34, 34, 34);
	    font-size: 12px;
	    font-weight: 500;
	    line-height: 1.5;
	    padding: 5px 18px;
	    cursor: pointer;
	}
	
	.mydocument .none{
		display:none;
		opacity:0;
	}
	.mydocument .hidden{
		visibility:hidden;
		opacity:0;
	}
	</style>
	<style>
	.order_svg{
		width:20px;
		height:20px;
		margin-right:5px;
	}
	.checkOrder{
		background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23D9AD2B' fill-rule='evenodd' d='M12 7c-2.76 0-5 2.24-5 5s2.24 5 5 5 5-2.24 5-5-2.24-5-5-5zm0-5C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z'%3E%3C/path%3E%3C/svg%3E");
	}
	.uncheckOrder{
		background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23bdbab7' fill-rule='evenodd' d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z'%3E%3C/path%3E%3C/svg%3E");
	}
	.topright1{
    	position: relative;
	    flex: 0 0 auto;
	    width: 250px;
    }
	</style>
	<script>
	$(function(){
		var workspaceId = <%=request.getAttribute("workspaceId")%>;
		var loginId = <%=loginId%>;
	<%
		for(MyPostDto dto : postList) {
	%>		
			var add = "<a href='Controller?command=showNewDocument&documentId=<%=dto.getDocument_id()%>&workspaceId="+workspaceId+"&workspaceName="+workspaceName+"&loginId=<%=loginId%>' class='postbox_mp1 row'>"			
				+"<div class='icon_mp'><img src='<%=dto.getKanban_icon_p()%>' class='kb_icon'/></div>"
				+"<div class='post_info column'>"
				+"<span class='post_title'><%=dto.getTitle()%></span>"
				+"<div class='row'>"
				+"<span class = 'ws_name'><%=dto.getWorkspace_name()%></span>"
				+"<span class ='post_date'><%=dto.getDate()%></span>"
				+"</div>"
				+"</div>"
				+"</a>";
				
			$("#myPostList").append(add);
	<%
		}
	%>
			$("#mypost").css({'border-bottom':"1px solid black", 'font-weight':"bold", color:"black"});
			$("#myPostList").removeClass("none");
			$("#mycomment").css({'border-bottom':"none", 'font-weight':"normal", color:"rgb(136,136,136)"});
			$("#myPostCommentList").addClass("none");
		
		//문서작성 버튼
		$(".posting_bnt").click(function(){
			location.href="Controller?command=writedocument&workspaceId="+workspaceId;
		});
		
		//내가 작성한 문서 보기
		$("#mypost").on("click", function(){
			$("#mypost").css({'border-bottom':"1px solid black", 'font-weight':"bold", color:"black"});
			$("#myPostList").removeClass("none");
			$("#mycomment").css({'border-bottom':"none", 'font-weight':"normal", color:"rgb(136,136,136)"});
			$("#myPostCommentList").addClass("none");
		});
		
		//내가 작성한 댓글 보기
		$("#mycomment").on("click", function(e){
			$("#mycomment").css({'border-bottom':"1px solid black", 'font-weight':"bold", color:"black"});
			$("#myPostCommentList").removeClass("none");
			$("#mypost").css({'border-bottom':"none", 'font-weight':"normal", color:"rgb(136,136,136)"});
			$("#myPostList").addClass("none");
			
			$.ajax({
				type:"post", 
				url:"Controller?command=MyCmt",
				data:{
					"loginId" : loginId
				},
				datatype:"json",
				success:function(data){//변경사항을 화면에 그려줌
					$.each(data, function(index, item) {
						var add = "<a href='Controller?command=showNewDocument&documentId="+item.documentId+"&workspaceId="+workspaceId+"&workspaceName="+workspaceName+"&loginId=<%=loginId%>' class='postbox_mp2'>"			
							+ "<div class='icon_mp'><svg viewBox='0 0 24 24' width='21px' height='21px'><path d='M5.6 4h12.8c.88 0 1.6.72 1.6 1.6V20l-3.2-3.2H5.6c-.88 0-1.6-.72-1.6-1.6V5.6C4 4.72 4.72 4 5.6 4z' color='#888888'></path></svg></div>"
							+ "<div class='post_info'><span class='post_title'>"+ item.content +"</span>"
							+ "<div><span class ='ws_name'>"+item.workspace_name+"</span><span class='post_name'>"+item.title+"</span>"
							+ "<span class ='post_date'>"+item.creation_date+"</span></div></div></a>";
						$("#myPostCommentList").append(add);
				});
				}
			});
		});
		
		//필터 각 탭에 맞게 & 다른데 누르면 닫힘
		/* $(document).click(function(e){
			var now = $("#myPostList").attr("class");
			if(now.indexOf("none") < 0) {
				if(e.target.id != 'filter_mp') { 
					$("#myCommentFilter").addClass("hidden");
					if($("#myPostFilter").has(e.target).length==0) {//클릭한 곳이 attendee_list의 일부가 아니면??
						//$("#attendee_sel_sch").attr("placeholder","참석자 추가").css({border:"none","box-shadow":"none", cursor:"pointer"});
						$("#myPostFilter").addClass("hidden");
					} 
				} else {
					$("#myPostFilter").toggleClass("hidden")
				}
			} else {
				$("#myPostFilter").addClass("hidden");
				if(e.target.id != 'filter_mp') {   // 클릭한 곳의 id가 #filter_mp가 아니면 아래 실행
					if($("#myCommentFilter").has(e.target).length==0) {//클릭한 곳이 attendee_list의 일부가 아니면??
						$("#myCommentFilter").addClass("hidden");
					} 
				} else {
					$("#myCommentFilter").toggleClass("hidden");
				}
			}	
        }); */
		
		//정렬
		$(".order_svg").click(function(){
			$(this).addClass("checkOrder").removeClass("uncheckOrder");
			alert($(this).attr("class"));
			var order = $(this).parent().parent().parent().find(":nth-child(1) div");
		
			alert(order.attr("class"));
			order.addClass("uncheckOrder").removeClass("checkOrder");
		});
		
		//datepicker
		$("#startD, #endD").datepicker({//datepicker호출
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
			}
		});
		
		//현재날짜 가져오기
		$("#startD, #endD").datepicker("setDate", new Date()); 
		
		//finish가 start보다 전이면 start가 선택한 finish 날짜로 변함
		$('#startD').datepicker("option", "onClose", function (selectedDate) {
			$("#endD").datepicker("option", "minDate", selectedDate);
		});
		
		$("#scheT").on("click", function(){
			var start = $("#startD").val();
			var end = $("#endD").val();
			$("#schedule").removeClass("hidden");
			$("#startSche").val(start);
			$("#endSche").val(end);
		});
		
		//검색
		$(".searchbar").keypress(function(e){
    	    if(e.keyCode == 13){
    			var search = $(this).val();
    		    var member_id = loginId;
    		    location.href="Controller?command=SearchP1&search="+search+"&member_id="+loginId;
    		}
		});
		
		
	});
	</script>
</head>
<body>
	<%@ include file="WEB-INF/include/include_PartnerModal.jspf" %>
<div class="row mydocument">
	<%@ include file="WEB-INF/include/HomeSidebar.jspf"%>
	<div class="alarm_expl">
		<h6>방해금지 모드</h6>
		<div class="alarm_expl2">
			<button class="alarm_btn1">1시간 동안 알림 끄기</button>
			<button class="alarm_btn1">2시간 동안 알림 끄기</button>
			<button class="alarm_btn1">4시간 동안 알림 끄기</button>
			<button class="alarm_btn1">아침까지 알림 끄기 (오전 9시)</button>
		</div>
		<div class="alarm_expl3">
			<a class="alarm_expl4" href="">알림 설정</a>
		</div>
	</div>
	
<section class="left_tab_sec1 column">	<!-- 레프트 빼고 전체-->
	<div class="tab_style1"> <!-- 고정 헤더 -->

	<div id="title_mp" class="row">
		<div id="mypost_title">내가 작성한 문서</div>

		<div class="row">
			<div class="mastersearchbar">
				<div class="search_icon" class="bnt_base"><svg class="micro" viewBox="0 0 24 24" width="16px" height="16px"><path d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"></path></svg></div>
				<input type ="text" class="searchbar" placeholder="검색"/>
				<button class="posting_bnt">
					<svg viewBox="0 0 24 24" width="13px" height="13px" ><path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04a.996.996 0 0 0 0-1.41l-2.34-2.34a.996.996 0 0 0-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z" class="posting_icon" ></path></svg>
					<span style="color:rgb(255,255,255)">문서 작성</span>
				</button>
			</div>
			<div class="topright1">
				<%@ include file="WEB-INF/include/homehead14.jspf" %>
	    	</div>
		</div>
	</div>

	<div id ="minitab_mp" class="row">
		<!-- 미니탭-->
		<div class="row">
			<div id="mypost">
				<input type="radio" id="tab1_mp" name="tab1" checked>
				<label for="tab1_mp">내가 작성한 문서</label>
			</div>
			<div id="mycomment">
				<input type="radio" id="tab2_mp" name="tab2">
				<label for="tab2_mp">내가 작성한 댓글</label>
			</div><!--댓글 누르면 댓글보기로 넘어감(해야됨)-->
		</div>	
	
		<div class="right_bnt"> <!--필터 누르면 모달 뜸(해야됨)-->
			<button id="filter_mp" class="bnt_none"></button> 		
			<button class="tab1_bnt"><a><span>할 일</span></a></button>
			<button class="tab1_bnt"><a><span>의사결정</a></span></button>
			<button class="tab1_bnt2"><a><span>파일함<svg viewBox="0 0 24 24" width="12px" height="12px"><path d="M17.0278306,8 C18.1356358,8 18.40014,8.63354932 17.6171348,9.41655445 L13.4502437,13.5834455 C12.6679023,14.365787 11.40014,14.3664507 10.6171348,13.5834455 L6.45024373,9.41655445 C5.66790231,8.63421303 5.93074941,8 7.03954794,8 L17.0278306,8 Z" ></path></svg></span></a></button>
		</div>
	</div>
	</div>
	

		<!--문서목록 작성할때마다 하나씩 생기는것임.(해야됨)-->
	<div style="display:flex; flex-direction:row; margin-top:105px;"> <!--문서목록과 오른쪽탭-->
	
	<section id="myPostList" class="left_tab_sec2"> <!--내가 작성한 문서-->
<%-- <%
	try{
		MyPostDao dao = new MyPostDao(); //dao 사용하기 위한 dao객체 생성
		ArrayList<MyPostDto> list = dao.getMyPost(1);
		for(MyPostDto dto : list) { //dao 실행하고 dto list 리턴. dto에 저장된 값 출력
%>
		<div class="postbox_mp2">			
			<div class="icon_mp"><img src="<%=dto.getKanban_icon_p()%>" class="kb_icon"/></div>
			<div class="post_info"><span class="post_title"><%=dto.getTitle()%></span>
				<div><span class = "ws_name"><%=dto.getWorkspace_name() %></span><span class ="post_date"><%=dto.getDate()%></span></div>
			</div>
		</div>
		
<%			
		}
	} catch(Exception e) {
		e.printStackTrace();
	}


%>	 --%>	
	</section>
	<section id="myPostCommentList" class="left_tab_sec2"></section>
	<%@ include file="../WEB-INF/include/MyAside.jsp"%> 
</div>
</section>

</div>

<!-- 댓글 필터-->
<!-- <div id="myCommentFilter" class="myCommentFilter1 myCommentFilter2 order_style1 hidden">
	<div class="filter_order_title" style="margin-left:17px;">정렬</div>
	<div id="label_hover">
		<label for="latest_comment" class="order_style2">
			<input type="radio" id="latest_comment">위치 조정(해야됨)
			<svg width="19px" height="19px" viewBox="0 0 24 24" style="margin-right: 5px;"><path fill="#888888" fill-rule="evenodd" d="M12 7c-2.76 0-5 2.24-5 5s2.24 5 5 5 5-2.24 5-5-2.24-5-5-5zm0-5C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"></path></svg>			최신 등록 순
		</label>
	</div>
</div>

문서 필터
<div id="myPostFilter" class="order_style1 filter_style1 filter_style2 hidden">
	<div class="filter_order_title">정렬</div>
	<div>
		<div>
			<label for="order_update_p" class="order_style2">
				<div class="checkOrder order_svg"></div>
				<input type="radio" id="order_update_p">
				업데이트 순
			</label>
		</div>
		<div>
			<label for="order_create_p" class="order_style2">
				<div class="uncheckOrder order_svg"></div>
				<input type="radio" id="order_create_p">선택하면 크표시 바뀌기, hover(해야됨)
				최신 등록 순
			</label>
		</div>
	</div>
</div> -->

<%@ include file="../WEB-INF/include/include_ScheduleModal.jspf" %>
<%@ include file="../WEB-INF/include/include_postedSchedule.jspf" %>
</body>
</html>