<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.jm.dto.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>새  할 일</title>
	<style>
		*{
			box-sizing: border-box;
			margin: 0;
    		padding: 0;
    		border: 0;
    		outline: 0;
			font-family: -apple-system,BlinkMacSystemFont,Malgun Gothic,Hiragino Kaku Gothic ProN,Hiragino Sans,Meiryo,MS PGothic,sans-serif,Dotum;
		}
		body{
			font-size: 13px;
		}
		button{
			border: none;
		    box-sizing: border-box;
		    font-size: 12px;
		    outline: 0;
		}
		a{
			text-decoration: none;
		}
		input{
			background-color: #fff;
		}
		textarea{
			resize: none;
			overflow: auto;
			margin: 0;
		}
	
		.todo_layout_container{
			top: 0;
		    left: 0;
		    right: 0;
		    bottom: 0;
		    z-index: 1300;
		    position: fixed;
		    
		    overflow-y: initial;
    		overflow-x: initial;
		}
		.modal_overlay{
			top: 0;
		    left: 0;
		    right: 0;
		    bottom: 0;
		    z-index: -1;
		    position: fixed;
		    touch-action: none;
		    background-color: rgba(0, 0, 0, 0.5);
		    -webkit-tap-highlight-color: transparent;
		}
		.todo_modal1{
			opacity: 1;
    		transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;
    		
    		height: 100%;
    		outline: none;
    		
    		display: flex;
    		align-items: center;
    		justify-content: center;
		}
		.todo_modal2{
			max-width: 600px;
			flex: 0 1 auto;
    		max-height: calc(100% - 96px);
    		margin: 48px;
		    display: flex;
		    position: relative;
		    flex-direction: column;
		    box-shadow: 0px 11px 15px -7px rgb(0 0 0 / 20%), 0px 24px 38px 3px rgb(0 0 0 / 14%), 0px 9px 46px 8px rgb(0 0 0 / 12%);
		    border-radius: 4px;
		    background-color: #fff;
		}
		.new_todo_container{
			background-color: rgb(255, 255, 255);
		    width: 580px;
		    padding: 20px 20px 22px;
		    border-radius: 4px;
		}
		.new_todo_header{
			display: flex;
		    flex-direction: row;
		    -webkit-box-align: center;
		    align-items: center;
		    -webkit-box-pack: justify;
		    justify-content: space-between;
		    margin-bottom: 24px;
		    padding-left: 4px;
		}
		.new_todo_h6{
			font-size: 12px;
		    font-weight: bold;
		    line-height: 1.5;
		    color: rgb(136, 136, 136);
		}
		.new_todo_btn_x{
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
		}
		.btn_x_svg{
			display: inline-block;
		    vertical-align: middle;
		    shape-rendering: inherit;
		}
		.btn_x_path{
			transition: fill 0.2s ease 0s;
    		fill: rgb(136, 136, 136);
		}
		.new_todo_inputcontainer{
			display: flex;
    		flex-direction: row;
		}
		.new_todo_path{
			fill: rgb(225, 225, 225);
		}
		.new_todo_input{
			width: 505px;
		    margin-left: 10px;
		    font-size: 22px;
		    color: rgb(34, 34, 34);
		    line-height: 1.45;
		    border: none;
		}
		.new_todo_assign{
			display: flex;
		    flex-direction: row;
		    -webkit-box-pack: start;
		    justify-content: flex-start;
		    -webkit-box-align: center;
		    align-items: center;
		    margin-top: 4px;
		    margin-left: 40px;
		    margin-bottom: 24px;
		}

		.assign_list_path1{
			fill: rgb(34, 34, 34);
		}
		.new_todo_datecontainer{
			border-top: 1px solid rgb(225, 225, 225);
    		padding-top: 24px;
		}
		.todo_date_picker_container{
			display: flex;
		    flex-direction: row;
		    align-items: flex-start;
		}
		
		.todo_date_picker_icon_area{
			margin: 2px 9px 0px 5px;
			height: 20px;
		}
		.todo_date_picker_icon_path{
			fill: rgb(136, 136, 136);
		}
		.todo_date_picker{
			display: flex;
		    flex-flow: row wrap;
		    -webkit-box-align: center;
		    align-items: center;
		    padding-left: 4px;
		    font-size: 16px;
		    line-height: 24px;
		}
		.todo_date_picker_datecontainer{
			display: flex;
		    flex-flow: row wrap;
		    -webkit-box-align: center;
		    align-items: center;
		    flex: 1 1 0%;
		}
		.todo_picker_date_btn{
			font-weight: normal;
			font-size: 14px !important;
			height: 24px;
		    padding: 0px 1px;
		    line-height: 24px;
		    background-color: transparent;
		    cursor: pointer;
		    transition: color 0.2s ease 0s, background-color 0.2s ease 0s;
		    color: rgb(136, 136, 136);
		    pointer-events: auto;
		}
		.todo_picker_date_btn:hover{
			border-radius: 4px;
		    background-color: rgb(247, 246, 245);
		    color: rgb(34, 34, 34);
		}
		
		.new_todo_footer{
			display: flex;
		    flex-direction: row;
		    -webkit-box-pack: justify;
		    justify-content: space-between;
		    margin-top: 40px;
		}
		.new_todo_footercell{
			display: flex;
		    flex-direction: row;
		    -webkit-box-align: center;
		    align-items: center;
		    position: relative;
		    padding-left: 4px;
		}
		.icon_btn{
			margin-right: 10px;
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
		}
		.new_todo_save_btn{
			position: relative;
		    min-height: inherit;
		    color: rgb(255, 255, 255);
		    font-size: 12px;
		    font-weight: 500;
		    line-height: 1.5;
		    border-radius: 4px;
		    text-align: center;
		    padding: 5px 18px;
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
		.new_todo_save_btn:hover{
			background-color: rgb(179, 142, 34);
    		border-color: rgb(179, 142, 34);
		}
		.todo_date_picker_devide{
			display: inline-block;
		    color: rgb(34, 34, 34);
		    font-size: 12px;
		    line-height: 1.5;
		}

        
        .new_todo_projectdropdowncontainer{
        	position: relative;
    		margin-right: 12px;
        }
        .new_todo_projectdropdowncontainer1{
        	position: relative;
    		box-sizing: border-box;
    		
    		width: 160px;
		    border-width: 1px;
		    border-style: solid;
		    border-radius: 4px;
		    background-color: rgb(255, 255, 255);
		    border-color: rgb(217, 173, 43);
        }
        .new_todo_projectdropdowncontainer2{
        	-webkit-box-align: center;
		    /* align-items: center; */
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
		.new_todo_projectdropdown_componet{
			-webkit-box-align: center;
		    align-items: center;
		    display: flex;
		    flex: 1 1 0%;
		    flex-wrap: wrap;
		    padding: 2px 8px;
		    position: relative;
		    overflow: hidden;
		    box-sizing: border-box;
		    
		    padding-left: 8px !important;
		}
        .new_todo_projectdropdown_workspace{
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
        .new_todo_projectdropdown_workspace>span{
        	display: inline-block;
		    width: 100%;
		    white-space: nowrap;
		    text-overflow: ellipsis;
		    overflow: hidden;
        }
        
        .new_todo_filescontainer{
		   max-height: calc(100vh - 434px);
		    height: 100%;
		    overflow-y: scroll;
        }
        .new_todo_edit_file_container{
        	margin: 16px 0px;
        }
        .edit_des_iconcontainer{
        	margin: 3px 10px 0px 5px;
        }
        .new_todo_edit_des_container{
        	display: flex;
		    flex-direction: row;
		    margin-top: 16px;
		    padding: 0px 3px 3px 0px;
        }
        .edit_des_textarea{
        	overflow-wrap: break-word;
		    white-space: break-spaces !important;
		    
		    display: block;
		    width: 100%;
		    min-height: 50px;
		    padding: 1px 4px 2px;
		    border: 0px;
		    border-radius: 4px;
		    background-color: rgb(255, 255, 255);
		    color: rgb(34, 34, 34);
		    font-size: 14px;
		    line-height: 1.71;
		    flex: 1 1 0% !important;
		    resize: none;
        }
         .edit_des_textarea:focus{
         	box-shadow: rgb(217 173 43) 0px 0px 0px 1px inset, rgb(217 173 43 / 20%) 0px 0px 0px 4px;
         }
         .edit_des_textarea:hover{
         	background-color: rgb(255, 255, 255);
         }


		.new_todo_input::-webkit-scrollbar {
				width:4px;
			}
		.new_todo_input::-webkit-scrollbar-thumb {
		    height: 70%; /* 스크롤바의 길이 */
		    background: #e1e1e1; /* 스크롤바의 색상 */
		    border-radius: 2px;
		}
			.edit_des_textarea::-webkit-scrollbar {
				width:4px;
			}
			.edit_des_textarea::-webkit-scrollbar-thumb {
		    height: 70%; /* 스크롤바의 길이 */
		    background: #e1e1e1; /* 스크롤바의 색상 */
		    border-radius: 2px;
			}
		
		#div_background {
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
        
        /* 협업공간 선택 리스트 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */

        .workspace_list{ /* 누르면 열리는 공간 목록*/
        	position: fixed;
        	z-index: 2100;
            display:flex;
            justify-content: right;
            margin-right:90px;
            display : none;
          	
		    min-height: 270px; 
        }
        .workspace_list ul{ /* 누르면 열리는 공간 목록*/
            position: absolute;
            list-style: none;
            background-color: rgb(255, 255, 255);
            border-radius: 4px;
            width: 160px;
            /* width: 160px;
            height:270px; */
            border:1px solid #e1e1e1;
            font-size: 14px;
            font-weight: 500;
            color:rgb(34, 34, 34);
            padding:5px 12px;
            line-height: 2.5;
            display:flex;
            flex-direction: column;
            align-items: center;
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
        .workspace_list ul::-webkit-scrollbar {
			width:4px;
		}
		.workspace_list ul::-webkit-scrollbar-thumb {
	    height: 70%; /* 스크롤바의 길이 */
	    background: #e1e1e1; /* 스크롤바의 색상 */
	    border-radius: 2px;
		}
		
		/* 담당자 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */
        
         .icon_sch{
            margin: 4px 10px 0px 8px;
            /* padding-top: 4px; */
        }
        .icon2_sch{
            width: 100%;
            cursor: pointer;
            transition: color 0.2s ease 0s, background-color 0.2s ease 0s;
            font-size: 14px;
            border-radius: 4px;
            background-color: transparent;
            color:rgb(136, 136, 136);

        }
        #assign_sch{
            display: flex;
            flex-direction: row;
            position: relative;
            min-height: 28px;
        }
        .picked_assign{
        	flex-wrap:wrap;
        	display:flex;
        	padding-left: 40px;
        } 
        .selected_assign{
            display: flex;
            height: 32px;
            margin: 8px 4px 0px 0px;
            padding: 5px 10px 5px 13px;
            border: 1px solid rgb(224, 221, 217);
            border-radius: 18px;
            background-color: rgb(255, 255, 255);
            font-size: 15px;
            -webkit-box-align: center;
            align-items: center;
            box-sizing: border-box;
            cursor:pointer;
            width: fit-content;
        }
        #assgin_sel_todo{ /*담당자 추가*/
            height: 28px;
            font-weight: normal;
            text-align: left;
            line-height: 28px;
        }
        .assign_list{ /*누르면 열리는 파트너 멤버 목록*/
            height:180px;
            width:240px;
            line-height: 2.3;
            cursor: pointer;
            transition: color 0.2s ease 0s, background-color 0.2s ease 0s;
            position:absolute;
            font-size:14px;
            color:rgb(34, 34, 34);
            border:1px solid rgb(247,239,213);
            border-radius:4px;
            padding:1px;
            background-color:#fff;
            margin-left: 36px;
            margin-top:28px;
            overflow: auto;
        }
        .assign_list ul{
            list-style: none;
            padding-top: 12px;
            padding-left: 16px;
        }
        .assign_list li{
        	margin-left: 30px;
        }
        .picture_todo_modal{
            width: 20px;
            height:20px;
            border-radius:50%;
            background-color:rgb(255, 255, 255);
            content:"";
            background-size:cover;
            position:absolute;
            margin-top:5px;
        }
        .picture2_sch{ /*picture_todo_modal보다 아래 있어야함*/
            position:unset; 
            margin: 0px 5px 0px 0px;
        }
        #assign_sch{
        	border: 1px solid rgb(230, 230, 230);
        	border-radius: 18px;
        	width: 130px;
        }
        
	</style>
	
	<script src="js/jquery-3.6.0.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script>
		$(function () {
		   
            $("#todo_start_date_picker_btn, #todo_finish_date_picker_btn").datepicker("setDate", new Date());
            $("#todo_start_date_picker_btn, #todo_finish_date_picker_btn").click(function() { 
            	$("#todo_start_date_picker_btn, #todo_finish_date_picker_btn").datepicker({
            		dateFormat:"yy.m.d" ,showOthermonths: true ,showMonthAfterYear:true
                    ,buttonImageOnly:true ,yearSuffix:"년", monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"]
                    ,dayNamesMin:["일", "월","화","수","목","금","토"]
                    , showButtonPanel:true, currentText:"오늘", closeText:"닫기"
            	});
            	//finish가 start보다 전이면 start가 선택한 finish 날짜로 변함(보류)            
            });

		
			//협업공간 리스트 뜨기
		    $(".new_todo_projectdropdowncontainer").click(function() {
            	var px = $(this).offset().left;	/* 클릭한 현재위치 가로 */
            	var py = $(this).offset().top+ 35;
            	$(".workspace_list").css('left',px+'px');
            	$(".workspace_list").css('top',py+'px');
				
				$(".workspace_list").css('display', 'block');
				$("#div_background").css('display', 'block');
		        $(".new_todo_projectdropdown_workspace>span").html("공간 검색").css("color", "rgb(136, 136, 136)");
		        $(".icon3_sch svg").css({visibility:"hidden", opacity:0});
			});
          	$("#div_background").click(function() {
            	$("#div_background").css('display', 'none');
          		$(".workspace_list").css('display', 'none');
          	});
		  
		    
		    $(".workspace_list > ul > li ").click(function(){ //리스트 선택하면 그값으로 바뀌고 리스트 닫힘
		        
		        // .input_workspace_name 에 workspace_name 넣기
		        var workspace1 = $(this).find("span").text();
		        //$(".input_workspace_name").val(workspace1);
		        
		        // workspace_id input에 넣기
		        var workspace_id = $(this).find(".workspace_id_Todo_modal").text();
		        $(".input_workspace_id_Todo_modal").val(workspace_id);
		        
		        //var workspace = $(this).text();
		        if(workspace1=="프라이빗 공간"){ //프라이빗 선택하면 색 바뀜. 
		           $(".new_todo_projectdropdown_workspace>span").html("프라이빗 공간").css('color', 'rgb(217, 173, 43)');
		           $(".new_todo_projectdropdowncontainer1").css('border', "1px solid rgb(217, 173, 43)");
		           $(".new_todo_save_btn").css({border:"1px solid rgb(217, 173, 43)", 'background-color':"rgb(217, 173, 43)"});
		           $("#workspace_container_arrow").css("fill","rgb(217, 173, 43)");
		        } else{
		        	$(".new_todo_projectdropdown_workspace>span").html(workspace1).css('color', 'rgb(51, 132, 108)');
		        	$(".new_todo_projectdropdowncontainer1").css('border', "1px solid rgb(51, 132, 108)");
		            $(".new_todo_save_btn").css({border:"1px solid rgb(51, 132, 108)", 'background-color':"rgb(51, 132, 108)"});
		            $("#workspace_container_arrow").css("fill","rgb(51, 132, 108)");
		        }
		        
		        $("#div_background").css('display', 'none');
          		$(".workspace_list").css('display', 'none');
		        $("#workspace_container_arrow").css({visibility:"visible", opacity:1});
		    });
		    $(".workspace_list li").hover(function (){
		        $(this).css("background-color", "rgb(242,242,242)");
		    }, function(){
		        $(this).css("background-color", "rgb(255, 255, 255)");
		    });
		    
		    
		  // 담당자 선택
	        $("#assgin_sel_todo").on("focus", function (){
	           	$(this).attr("placeholder","담당자 이름 검색").css({width: '400px', color:"rgb(136, 136, 136)", border:"1px solid rgb(217, 173, 43)", 'box-shadow': "0 0 4px rgb(247,239,213)", 'padding-right':"200px", cursor:"text"});
	           	$(".assign_list").css('display', 'block'); //리스트 열기
	           	$("#assign_sch").css('border-color', 'transparent');
	        });
	        
		
	        //클릭하면 아래에 추가
	        $(document).on("click",".assign_list ul li", function(){
	            var name = $(this).text();//선택한 멤버 이름
	            var email = $(this).attr("email");  // 선택한 멤버 이메일
	            var assign_member_id = $(this).parent().find(".member_id_todo_modal").text();
				var img = $(this).parent().find(".picture_todo_modal").css('background-image');
	            
	            $(".assign_list").addClass("hidden");
	            $(this).parent().parent().detach();//고른 멤버 리스트에서 삭제.
	            
	                
	            var setPickedMember = "<div class='selected_assign' email='"+email+"'><span>"+name+"</span><div class='member_id_picked_assign' style='display: none; background-image: "+img+"' value='"+assign_member_id+"'></div></div>";
	            $(".picked_assign").append(setPickedMember);
	            
	            
	            $(".assign_list").css('display', 'none'); //리스트 닫기

	            $("#assgin_sel_todo").removeAttr("style");
	            $("#assgin_sel_todo").attr("placeholder","담당자 추가")
	            $("#assign_sch").css('border-color', 'rgb(230, 230, 230)');
	        });
	        
	        //클릭하면 사라짐
	        $(document).on("click",".selected_assign", function(){
	        	var name = $(this).find("span").text();//선택한 멤버 이름
	            var email = $(this).attr("email");  // 선택한 멤버 이메일
	            var member_id = $(this).find(".member_id_picked_assign").attr("value");
	            var img = $(this).parent().find(".member_id_picked_assign").css('background-image');
	            alert(member_id);
	            
	            
	            $(this).detach();
	            
	            
	            var setPickedMember = "<div><div class='todo_modal_assign_conatiner'><div class='picture_todo_modal' style=background-image:"+img+"'></div><div class='member_id_todo_modal' style='display: none'>"+member_id+"</div><li email='"+email+"'>"+name+"</li></div></div>"
	            $(".assign_list ul").append(setPickedMember);

	        });	
	        
	        // 담당자 아이디 submit 하기전 input 에 넣기
	        $(".new_todo_save_btn").click(function() {
		        var assign_list_str = "";
	        	$(".selected_assign > div").each(function(index, item) {
		        	
		        	var member_id = $(item).attr('value');

		        	assign_list_str += member_id + "_";
	        	});

	        	$(".assign_member_id_list").val(assign_list_str);
	        });
	        
	        // 파트너 이름 검색
            $("#assgin_sel_todo").keyup(function(key){
                var search = $(this).val();
                $(".todo_modal_assign_conatiner li").each(function(index, item){
                	if($(item).text().includes(search)){
						$(item).parent().parent().css("display","block");                		
                	} else {
						$(item).parent().parent().css("display","none");
                	}
                });
            });

		});
		
/* 		function () {
			if(str == null){
				
				return true;
			}else{
				alert("담당자를 선택해 주세요!");
				return false;
			}
		} */
	</script>
	
</head>
<body>
	<form action="Controller?command=TodoInsert"  method="post">
	<div id="todo_modal" class="todo_layout_container">
		<div class="modal_overlay" aria-hidden="true" style="opacity: 1; transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;"></div>
		
		<div class="todo_modal1">
			<div class="todo_modal2">
				
				<div id="new_todo">
					<div class="new_todo_container">
						<header class="new_todo_header">
							<h6 class="new_todo_h6">새 할 일</h6>
							
							<button type="button" color="mono3Grey" title="닫기" class="new_todo_btn_x">
								<svg viewBox="0 0 24 24" width="24px" height="24px" class="btn_x_svg"><path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z" class="btn_x_path"></path></svg>
							</button>
						</header>
						
						<div>
						
							<div class="new_todo_inputcontainer">
								<svg viewBox="0 0 24 24" width="30px" height="30px" class="btn_x_svg"><path d="M12 1.5C6.204 1.5 1.5 6.204 1.5 12S6.204 22.5 12 22.5 22.5 17.796 22.5 12 17.796 1.5 12 1.5zM9.9 17.25L4.65 12l1.48-1.48 3.77 3.758 7.97-7.969L19.35 7.8 9.9 17.25z" color="#E1E1E1" class="new_todo_path"></path></svg>
								<textarea name="content" maxlength="101" placeholder="햄스터 조사 @이정민대리 ~ 6/13" class="new_todo_input" style="overflow-wrap: break-word; flex: 0 0 auto; white-space: break-spaces !important; height: 32px;" required></textarea>
							</div>
							
							<div class="new_todo_assign">
								<div class="user_manage"> <!-- 담당자 -->
										
										<%
										ArrayList<PartnerListDto> pL = (ArrayList<PartnerListDto>)request.getAttribute("pL");
										%>
										 
							                <div id="assign_sch">
							                    <div class="icon_sch"><svg viewBox="0 0 24 24" width="20px" height="20px" class="icon_color"><path d="M9 11.75a1.25 1.25 0 1 0 0 2.5 1.25 1.25 0 0 0 0-2.5zm6 0a1.25 1.25 0 1 0 0 2.5 1.25 1.25 0 0 0 0-2.5zM12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8 0-.29.02-.58.05-.86 2.36-1.05 4.23-2.98 5.21-5.37a9.974 9.974 0 0 0 10.41 3.97c.21.71.33 1.47.33 2.26 0 4.41-3.59 8-8 8z" color="#C1C1C1" class="Beecon__Path-sc-3x6pq4-1 dBeMQs"></path></svg></div>
							                    
							                    <input type="text" id="assgin_sel_todo" class="icon2_sch" placeholder="담당자 추가"/>
							                    
							                    <div class="assign_list" style="display: none"><!-- 담당자 목록 -->
							                        <ul>
							                        <%
							                        	for(int i = 0; i<pL.size(); i++){
							                        %>
							                        	<div>
								                            <div class="todo_modal_assign_conatiner">
								                            	<div class="picture_todo_modal" style="background-image:<%=pL.get(i).getPicture() %>"></div>
								                            	<div class="member_id_todo_modal" style="display: none"><%=pL.get(i).getMember_id() %></div>
								                            	<li email="<%=pL.get(i).getEmail() %>">
								                            		<%=pL.get(i).getName() %>
								                            	</li>
								                            </div>
							                        	</div>
													<%
							                        	}													
													%>
							                        </ul>
							                    </div>
							                							
							                </div>
								            <!-- 선택된 멤버들 div -->
								            <div class="row picked_assign"></div>		
								            <input type="hidden" name="assign_member_id" class="assign_member_id_list"/>		            

								</div>
							</div>
							
							<div class="new_todo_datecontainer">
								<div class="todo_date_picker_container">
								
									<div class="todo_date_picker_icon_area">
										<svg viewBox="0 0 24 24" width="20px" height="20px" class="btn_x_svg"><path d="M11.99,2 C17.52,2 22,6.48 22,12 C22,17.52 17.52,22 11.99,22 C6.47,22 2,17.52 2,12 C2,6.48 6.47,2 11.99,2 Z M12,4 C7.58,4 4,7.58 4,12 C4,16.42 7.58,20 12,20 C16.42,20 20,16.42 20,12 C20,7.58 16.42,4 12,4 Z M12.5,7 L12.5,12.25 L17,14.92 L16.25,16.15 L11,13 L11,7 L12.5,7 Z" class="todo_date_picker_icon_path"></path></svg>
									</div>
									
									<div class="todo_date_picker">
										<div class="todo_date_picker_datecontainer">
											<div>
												<!-- <button id="todo_start_date_picker_btn" class="todo_picker_date_btn" >시작일 추가</button> -->
												<input name="todo_startd" type='text' id="todo_start_date_picker_btn" class="todo_picker_date_btn"  value='시작일 추가'/>
											</div>
											
											<span class="todo_date_picker_devide" style="padding: 0px 10px 0px 6px;">~</span>
											
											<div>
												<!-- <button id="todo_finish_date_picker_btn" class="todo_picker_date_btn">완료일 추가</button> -->
												<input name="todo_finishd" type='text' id="todo_finish_date_picker_btn" class="todo_picker_date_btn"  value='완료일 추가'/>
											</div>
										</div>
									</div>
									
								</div>
							</div>
							
							<div class="new_todo_edit_des_container">
								<div class="edit_des_iconcontainer">
									<svg viewBox="0 0 24 24" width="21px" height="21px" class="btn_x_svg"><path d="M5 1h13.6a2 2 0 0 1 2 2v18a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2zm.467 1.467a1 1 0 0 0-1 1v17.066a1 1 0 0 0 1 1h12.666a1 1 0 0 0 1-1V3.467a1 1 0 0 0-1-1H5.467zm1.444 8.555V9.556h9.778v1.466H6.91zm0-3.666V5.889h9.778v1.467H6.91z" class="btn_x_path"></path></svg>
								</div>
								
								<textarea name="todo_des" maxlength="501" placeholder="할 일 설명 추가" spellcheck="false" class="edit_des_textarea"></textarea>
							</div>
							
							<footer class="new_todo_footer">
								<div class="new_todo_footercell"  style="margin-left: 300px;">
									<div class="new_todo_projectdropdowncontainer">
										<div>
											<div class="new_todo_projectdropdowncontainer1">
												<div class="new_todo_projectdropdowncontainer2">
													<div class="new_todo_projectdropdown_componet">
														<div class="new_todo_projectdropdown_workspace">
															<span>협업공간 선택</span>
															<svg viewBox="0 0 24 24" width="16px" height="16px" class="btn_x_svg" style="margin-left: 8px; margin-right: 8px;"><path d="M17.0278306,8 C18.1356358,8 18.40014,8.63354932 17.6171348,9.41655445 L13.4502437,13.5834455 C12.6679023,14.365787 11.40014,14.3664507 10.6171348,13.5834455 L6.45024373,9.41655445 C5.66790231,8.63421303 5.93074941,8 7.03954794,8 L17.0278306,8 Z" style="fill: rgb(217, 173, 43)" id="workspace_container_arrow" ></path></svg>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
	
									<button type="submit" color="primary" class="new_todo_save_btn">저장</button>
								</div>
							</footer>
						</div>
						

						
						<input class="input_workspace_id_Todo_modal" name="workspace_id" type="hidden" />
					</div>
				</div>
				
			</div>
		</div>
	</div>
	</form>
	
	<div id="div_background"></div>
	
<!-- 	<div> -->
	
	</div>
	
	
	<div class="workspace_list">
		<ul class="left-bar icon_color" >
			<li style="margin-bottom: 0px;">공간 검색</li>
			<%
				ArrayList<ModalWorkspaceListDto> mWList = (ArrayList<ModalWorkspaceListDto>)request.getAttribute("mWList");
						for(int i = 0; i<mWList.size(); i++){
			%>
			<li>
				<svg viewBox="0 0 24 24" width="16px" height="16px"><path d="M14.027 5L13.6 3H4v18h2v-7h6l.533 2H20V5z"></path></svg>
				<span><%=mWList.get(i).getWorkspace_name() %></span>
				<div style="display: none;" class="workspace_id_Todo_modal"><%=mWList.get(i).getWorkspace_id() %></div>
			</li>
			<%
				}
			%>
		</ul>
	</div>
	
	
</body>
</html>