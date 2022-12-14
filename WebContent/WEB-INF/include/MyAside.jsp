<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.yr.dto.*" %>
<%@ page import="com.yr.dao.*" %>
<%
	/* int login_id = (int)(session.getAttribute("login_id")); */
	DmDao dDao2 = new DmDao();
	ArrayList<DmWidgetDto> widget = dDao2.getWidget(4);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<style>
	a{
		text-decoration: none;
		color: black;
	}
    .dmw{
    	padding-bottom: 8px;
	    display: flex;
	    flex-direction: row;
	    padding-top: 8px;
    }
    .dmw2{
	    color: rgb(34, 34, 34);
	    font-size: 12px;
	    line-height: 1.5;
	    transition: color 0.2s ease 0s;
	    min-width: 0px;
    }
    .aside_title{
    	text-overflow: ellipsis;
	    white-space: nowrap;
	    overflow: hidden;
	    overflow-wrap: break-word;
    }
    .aside_writer{
    	word-break: break-all;
	    white-space: nowrap;
	    text-overflow: ellipsis;
	    overflow: hidden;
	    color: rgb(136, 136, 136);
    }
    .dmw_icon{
		padding-right: 5px;
		fill: rgb(193, 193, 193);
	}
	.dmw_icon:hover{
		fill: rgb(153, 153, 153);
	}
	*{
		box-sizing: border-box;
	}
	body, div {
		font-family: -apple-system,BlinkMacSystemFont,Malgun Gothic,Hiragino Kaku Gothic ProN,Hiragino Sans,Meiryo,MS PGothic,sans-serif,Dotum;
		margin:0;
		padding:0;
		box-sizing: border-box;
	}
	input, button{
		border:none;
		outline:none;
		box-shadow:none;
	}
	#right_bar{
		background-color: transparent;
		flex: 0 0 auto;
		width: 250px;
		overflow-y: auto;
		height: calc((100vh - 126px) - 38px);
		padding: 42px 0px 20px 14px;
		/* position: absolute;  */
	  	right: 0;
	  	/* top: 155px; */
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
	#startD, #endD, input[title="?????? ??????"], [title="????????????"]{
		margin-left:7px;
		color: rgb(34, 34, 34);
		font-size: 12px;
		line-height: 1.5;
		transition: color 0.2s ease 0s;
		min-width: 0px;
		cursor:pointer;
	}
	#startD, #endD {
		width:60px;
	}
	input[title="?????? ??????"]:hover, [title="????????????"]:hover{
		color:rgba(34, 34, 34, 0.7);
	}   
	.row{
		display:flex;
		flex-direction: row;
	}
	.column{
		display:flex;
		flex-direction:column;
	}
	.scheduleW{
		padding-bottom: 42px;
	}
	.todo_aside_container{
		/* flex: 0 0 250px;
	    height: 100%; */
	    padding-bottom: 42px;
	}
	.todo_aside_filtertitle{
		display: block;
	    font-size: 14px;
	    font-weight: normal;
	    color: rgb(136, 136, 136);
	    margin-top: 0px;
	    margin-bottom: 4px;
	}
	.todo_aside_item{
		display: flex;
	    flex-direction: row;
	    margin-bottom: 8px;
	 }   
	.todo_aside_item_link {
		display: inline-flex;
	    flex-flow: row wrap;
	    -webkit-box-align: center;
	    align-items: center;
	    color: rgb(34, 34, 34);
	    font-size: 12px;
	    line-height: 1.5;
	    transition: color 0.2s ease 0s;
	    min-width: 0px;
	    align-items: flex-end;
	}
	.todo_aside_iten_btn{
		background-color: transparent;
   		transform: translateY(2px);
	}
	.todo_aside_item_title{
		display: inline-block;
	    padding-right: 5px;
	    word-break: break-word;
	}
	.todo_aside_item_name{
		display: inline-block;
	    word-break: break-all;
	    white-space: nowrap;
	    text-overflow: ellipsis;
	    overflow: hidden;
	    color: rgb(136, 136, 136);
	}
	.todo_ul{
		padding: 0px;
    	margin: 0px;
	}
	</style>
	<script>
	var workspaceId = <%=request.getParameter("workspaceId")%>;
	var workspaceName = "<%=request.getParameter("workspaceName")%>";
	var loginId = 4;
	$(function(){
		
		$("#rightBar_schedule").empty();//?????? ???????????? 
		$.ajax({
			type:"post", 
			url:"Controller?command=showTwoSchedule",
			data:{
				"workspaceId":4,
			},
			datatype:"json",
			success:function(data){
				$.each(data, function(index, item) {
					var schedule = "<div class='row' style='margin-top:10px;'>"
						+"<div class='schedule_icon icon_sche2'></div>"
						+"<div class='column' style='width: 226px;'>"
						+"<input title='?????? ??????' type='text' placeholder='?????? ??????' value='"+item.start_date+" ~ "+item.finish_date+"' readonly/>"<!--datepicker-->
						+"<input title='????????????' type='text' placeholder='??? ?????? ?????? ??????' scheduleId='"+item.scheduleId+"' value='"+item.title+"' readonly/>"
						+"</div>"
						+"</div>";	
					
						$("#rightBar_schedule").append(schedule);
				
				$.ajax({
					type:"post",
					url:"Controller?command=scheduleGetter",
					data:{
						"scheduleId":item.scheduleId,
					},
					datatype:"json",
					success:function(data){
						//$.each(data, function(index, item){
							$(".edit_title_container textarea").val(data.title);					
							$("#schedule_start").val(data.startDate); //?????? ????????? ?????? ??????
							$("#schedule_end").val(data.finishDate);
							$("#schedule_location > textarea").val(data.locations);
							$("#schedule_summary > textarea").val(data.content);//??????????????? ??????
							
							$(".attendee_list ul li").each(function(index, item) {
								var memberId = $(item).attr("scheduleattendee_id");
								if(data.writerId==memberId){
								$(".assign_list_span").text($(item).attr("name"));							
									//????????? ????????? ????????? ????????? ???.....!!!
								}
								var atd = data.attendee;
								for(var i in atd){
									if(atd[i]==memberId){
										var setPickedMember = "<div class='selected_attendee' email='"+$(item).attr("email")+"' scheduleattendee_id='"+memberId+"'><span>"+$(item).text()+"</span></div>";
										$("#schedule_modal .picked_attendee").append(setPickedMember);
									}
								}
							});
					},
					error:function(r,s,e){
						alert("error!");	
					}
				});
				});
			
			},
			error:function(r,s,e){
				alert("error!");
			}
		});
		
	});	
	</script>
	
	
</head>
<body>
	<div id="right_bar" class="left-bar column">
		<div style="padding-bottom: 42px;">
			<a href="" class="post_schedule">????????? ??????</a>
			<div class="row" style="margin-top:10px;">
				<div class="schedule_icon icon_sche1"></div>
				<div class="column">
					<div class="row">
						<input id="startD" title="?????? ??????" type="datepicker" placeholder="?????? ??????" />
						<span>~</span>
						<input id="endD" title="?????? ??????" type="datepicker" /> 
					</div>
					<input id="scheT" title="??????" type="text" placeholder="??? ?????? ?????? ??????"/>
				</div>
			</div>
			<div id="rightBar_schedule" class="scheduleW">
	
			</div>
		</div>
		<!-- ???????????? ?????? -->
		<aside class="todo_aside_container">
			<h6 class="todo_aside_filtertitle">????????? ????????? ??? ??? ???</h6>
				<ul class="todo_ul">
					<%-- <%
					ArrayList<TodoListDto> todoListW = (ArrayList<TodoListDto>)request.getAttribute("todoListW");
					for(int i = 0; i<todoListW.size(); i++){
					%> --%>
						<li class="todo_aside_item"" >	<!-- ?????????????????? ?????? -->
							<div style="display: none;"><%-- <%= todoListW.get(i).getTodo_id() %> --%></div>
							<div>
								<button class="todo_aside_iten_btn" style="background-color:transparent">
									<svg viewBox="0 0 24 24" width="18px" height="18px" class="svg1"><path fill="#888888" d="M12 1.5C6.204 1.5 1.5 6.204 1.5 12S6.204 22.5 12 22.5 22.5 17.796 22.5 12 17.796 1.5 12 1.5zM9.9 17.25L4.65 12l1.48-1.48 3.77 3.758 7.97-7.969L19.35 7.8 9.9 17.25z"></path></svg>								
								</button>
							</div>
							<div class="todo_aside_item_link">
								<span class="todo_aside_item_title"><%-- <%= todoListW.get(i).getContent() %> --%>2????????? ???????????? ??????</span>
								<span class="todo_aside_item_name"><%-- <%= todoListW.get(i).getWriter_p() %> --%>??????</span>
							</div>
						</li> <!-- ?????????????????? ??? -->
					<%-- <%
						}
					%> --%>
					</ul>
				</aside>
		<!-- ???????????? ?????? -->
		
		
		<div style="padding-bottom: 42px;">
			<div class="post_schedule">?????? ????????????</div>
			<div>
<%
	for(DmWidgetDto dto : widget){
%>
		<a class="dmw" href="" dmID="<%= dto.getDocument_id()%>">
			<div>
			<svg viewBox="0 0 24 24" width="17px" height="17px" class="dmw_icon"><path d="M2.833 4h13.75c.633 0 1.128.32 1.458.807L23 12.25l-4.96 7.434c-.33.486-.888.816-1.52.816H2.832A1.839 1.839 0 0 1 1 18.667V5.833C1 4.825 1.825 4 2.833 4zm11.917 9.625c.76 0 1.375-.614 1.375-1.375 0-.76-.614-1.375-1.375-1.375-.76 0-1.375.614-1.375 1.375 0 .76.614 1.375 1.375 1.375zm-4.583 0c.76 0 1.375-.614 1.375-1.375 0-.76-.614-1.375-1.375-1.375s-1.375.614-1.375 1.375c0 .76.614 1.375 1.375 1.375zm-4.584 0c.761 0 1.375-.614 1.375-1.375 0-.76-.614-1.375-1.375-1.375-.76 0-1.375.614-1.375 1.375 0 .76.614 1.375 1.375 1.375z" color="#c1c1c1" class="Beecon__Path-sc-3x6pq4-1 ehFssD"></path></svg>
			</div>
			<div class="dmw2">
				<div class="aside_title"><%= dto.getDecision_making_title()%></div>
				<div class="aside_writer"><%= dto.getName()%></div>
			</div>
		</a>
<%
	}
%>
				
		</div>
		</div>
	</div><!--?????? ???-->
	
	
	
				
<script>
	$(function(){
		//datepicker ??????
		$("#startD, #endD").datepicker({//datepicker??????
			dateFormat:"yy.m.d" ,showOthermonths: true ,showMonthAfterYear:true
			,buttonImageOnly:true ,yearSuffix:"???", monthNames:["1???","2???","3???","4???","5???","6???","7???","8???","9???","10???","11???","12???"]
			,dayNamesMin:["???", "???","???","???","???","???","???"]
			, showButtonPanel:true, currentText:"??????", closeText:"??????"
			,onSelect:function(dataText, inst) {
				var d = dataText;
			
				var arr=d.split(".");
				var year=arr[0]; //??????
				var month=arr[1]; //???
				var day=arr[2]; //???
			}//?????? start?????? end?????? ?????? ?????????
		});
		
		//???????????? ????????????
		$("#startD, #endD").datepicker("setDate", new Date()); 
		
		//finish??? start?????? ????????? start??? ????????? finish ????????? ??????
		$('#startD').datepicker("option", "onClose", function (selectedDate) {
			$("#endD").datepicker("option", "minDate", selectedDate);
		});
		
		
	});
</script>
</body>
</html>