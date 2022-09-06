package mvc;

public class ActionFactory { // 싱글턴 패턴
	private static ActionFactory instance = new ActionFactory();
	private ActionFactory() {}
	public static ActionFactory getInstance() {
		return instance;
	}
	Action getAction(String command) {
		Action action = null;
		switch(command) {
		case "ChattingFileUploadAction" :
			action = new ChattingFileUploadAction();
			break;
		case "CommnetFileUploadAction" :
			action = new CommentFileUploadAction();
			break;
		case "ChattingContentAction" :
			action = new ChattingContentAction();
			break;
		case "ChattingFileMessageAction" :
			action = new ChattingFileMessageAction();
			break;
		case "ChattingFileAction" :
			action = new ChattingFileAction();
			break;
		case "ChattingInviteMemberAction" :
			action = new ChattingInviteMemberAction();
			break;
		case "ChattingInvitePartnerListAction" :
			action = new ChattingInvitePartnerListAction();
			break;
		case "ChattingLinkMessageAction" :
			action = new ChattingLinkMessageAction();
			break;
		case "ChattingLinkOrMessageAction" :
			action = new ChattingLinkOrMessageAction();
			break;
		case "ChattingLinkAction" :
			action = new ChattingLinkAction();
			break;
		case "ChattingListAndPartnerAction" :
			action = new ChattingListAndPartnerAction();
			break;
		case "ChattingMessageAction" :
			action = new ChattingMessageAction();
			break;
		case "ChattingParticipantsAction" :
			action = new ChattingParticipantsAction();
			break;
		case "CommentContentAction" :
			action = new CommentContentAction();
			break;
		case "CommentContentWriteAction" :
			action = new CommentContentWriteAction();
			break;
		case "CommentGetFileNameAction" :
			action = new CommentGetFileNameAction();
			break;
		case "CommentGetLinkNameAction" :
			action = new CommentGetLinkNameAction();
			break;
		case "FileAllAction" :
			action = new FileAllAction();
			break;
		case "FileMeAction" :
			action = new FileMeAction();
			break;
		case "FileSelectWorkspaceAction" :
			action = new FileSelectWorkspaceAction();
			break;
		case "LinkAllAction" :
			action = new LinkAllAction();
			break;
		case "LinkMeAction" :
			action = new LinkMeAction();
			break;
		case "LinkSelectWorkspaceAction" :
			action = new LinkSelectWorkspaceAction();
			break;	
		case "PartnerBlockAction" :
			action = new PartnerBlockAction();
			break;
		case "PartnerContentAction" :
			action = new PartnerContentAction();
			break;
		case "PartnerHiddenAction" :
			action = new PartnerHiddenAction();
			break;
		case "PartnerInvitationAgainAction" :
			action = new PartnerInvitationAgainAction();
			break;
		case "PartnerInviteAgreeAction" :
			action = new PartnerInviteAgreeAction();
			break;
		case "PartnerInviteCancelAction" :
			action = new PartnerInviteCancelAction();
			break;
		case "PartnerInviteRefuseAction" :
			action = new PartnerInviteRefuseAction();
			break;	
		case "PartnerInviteAction" :
			action = new PartnerInviteAction();
			break;
		case "FilesAction" : 
			action = new FilesAction();
			break;
		case "LinksAction" : 
			action = new LinksAction();
			break;	
		case "option4" :
			action = new Option4Action();
			break;
			
		//jm
		case "bookmark":
			action = new BookmarkAction();
			break;
		case "KanbanSelector" :
			action = new KanbanSelectorAction();
			break;
		case "BookmarkDel" : 
			action = new BookmarkDelAction();
			break;
		case "KanbanSelectorChange":
			action = new KanbanSelectorChangeAction();
			break;
		case "KanbanList" :
			action = new KanbanListAction();
			break;
		case "KanbanDel" :
			action = new KanbanDelAction();
			break;
		case "KanbanDocuOrderUpdate" :
			action = new KanbanDocuOrderUpdateAction();
			break;
		case "KanbanOrderUpdate" :
			action = new KanbanOrderUpdateAction();
			break;
		case "KanbanInsert" :
			action = new KanbanInsertAction();
			break;
		case "KanbanNewDocu" :
			action = new KanbanNewDocuAction();
			break;
		case "KanbanNewWS" : 
			action = new KanbanNewWSAction();
			break;
		case "Todo" :
			action = new TodoAction();
			break;
		case "ModalWorkspaceList" :
			action = new ModalWorkspaceListAction();
			break;
		case "ModalPartnerList" :
			action = new ModalPartnerListAction();
			break;
		case "TodoInsert" :
			action = new TodoInsertAction();
			break;
		case "TodoDetail" :
			action = new TodoDetailAction();
			break;
		case "TodoCurSelectorAction" :
			action = new TodoCurSelectorAction();
			break;
		case "TodoDetailEdit" :
			action = new TodoDetailEditAction();
			break;
		case "TodoDetailDel" :
			action = new TodoDetailDelAction();
			break;
		case "SignUpCheckEmail" : 
			action = new SignUpCheckEmailAction();
			break;
		case "SignUpSendEmail" :
			action = new SignUpSendEmailAction();
			break;
		case "SignUp" :
			action = new SignUpAction();
			break;
		case "SignUpNaver" :
			action = new SignUpNaverAction();
			break;
		case "LoginCheck":
			action = new LoginCheckAction();
			break;
		case "ResetPW" :
			action = new ResetPWAction();
			break;
		case "ResetPW1" :
			action = new ResetPW1Action();
			break;
		case "SignUpKakao" :
			action = new SignUpKakaoAction();
			break;    
		case "LoginAccountCheck" :
			action = new LoginAccountCheckAction();
			break;
		case "NewChat":
			action = new NewChatAction();
			break;
		case "NewChattingRoomInsert" :
			action = new NewChattingRoomInsertAction();
			break;	
			
		//jh
		case "settingPrice" : //가격 및 결제
			action = new SettingPriceAction();
			break;
		case "Home":
			action = new HomeRecentAction();
			break;
		case "MemberDelete":
			action = new MemberDeleteAction();
			break;
		case "dm1":
			action = new Dm1Action();
			break;
		case "dm2":
			action = new Dm2Action();
			break;
		case "option1":
			action = new Option1Action();
			break;
		case "option2":
			action = new Option2Action();
			break;
		case "option3":
			action = new Option3Action();
			break;
		case "updatebar1":
			action = new Updatebar1Action();
			break;
		case "updatebar2":
			action = new Updatebar2Action();
			break;
		case "getPrivateId" :
			action = new GetPrivateIdAction();
			break;
		case "select_Workspace_Index" ://협업공간 메인화면
			action = new MyWorkspaceIndexAction(); 
			break;
		case "workspacePostList" : //협업공간 메인 문서리스트 출력
			action = new WorkspacePostListAction();
			break;
		case "workspace_Alarm" : //협업공간 알림 켜고 끄기
			action = new WorkspaceAlarmAction();
			break;
		case "workspaceUpdate" : //협업공간이름설명 업데이트
			action = new WorkspaceUpdateAction();
			break;
		case "workspaceUpdate2" : //대외비, 완료 설정
			action = new WorkspaceUpdate2Action();
			break;
		case "workspaceDelete" : //공간 삭제
			action = new WorkspaceDeleteAction();
			break;
		case "workspaceInviteList" ://멤버초대 목록
			action = new WorkspaceInviteListAction();
			break;
		case "workspaceInviteMember" ://멤버 초대 insert
			action = new WorkspaceInviteMemberAction();
			break;
		case "workspaceFindManager" :// 관리자 찾기
			action = new WorkspaceFindManagerAction();
			break;
		case "memberIdentified" : //비번 맞는지 확인
			action = new MemberPwIdentifiedAction();
			break;
		case "newWorkspace" : //협업공간 생성
			action = new NewWorkspaceAction();
			break;
		case "workspaceSearch"	:
			action = new WorkspaceSearchAction();
			break;
		case "workspaceManagerEtc" : //관리자 설정 
			action = new WorkspaceManagerEtcAction();
			break;
		case "searchMember" : //멤버 검색
			action = new WorkspaceMemberSearchAction();
			break;
		case "myWorkspacePost" : //내가 작성한 문서	
			action = new MyWorkspacePostAction();
			break;
		case "writedocument"://문서작성 클릭
			action = new PostDocumentAction();
			break;
		case "saveDocument" ://문서 저장 클릭
			action = new SaveDocumentAction();
			break;
		case "updateDocument" : //문서 수정
			action = new DocumentUpdateAction();
			break;
		case "showNewDocument" ://문서 디테일 보기
			action = new DocumentDetailAction();
			break;
		case "getDraftsDocument" : //임시저장문서 가져오기
			action = new GetDocumentDraftsAction();
			break;
		case "showTwoSchedule" ://위젯 일정 2개 보여주기
			action = new ScheduleTwoAction();
			break;
		case "getThisWorkspaceMember" ://멤버 리스트 채우기
			action = new GetThisWorkspaceMemberAction();
			break;
		case "ModalWorkspaceListjh" : //공간 리스트
			action = new SelWorkspaceListAction();
			break;
		case "documentEtc" ://북마크, 알림 가져오기
			action = new DocumentEtcAction();
			break;
		case "documentBookmarkAlarm" :
			action = new DocumentBookmarkAlarmAction();
			break;
		case "documentDel" : //문서 삭제
			action = new DocumentDelAction();
			break;
		case "insertSchedule" : //일정 저장 -> insert
			action = new ScheduleInsertAction();
			break;
		case "updateSchedule" : //일정 수정
			action = new ScheduleUpdateAction();
			break;
		case "deleteSchedule" : //일정 삭제
			action = new ScheduleDeleteAction();
			break;
		case "scheduleGetter" : //일정 가져오기
			action = new ScheduleGetterAction();
			break;
		case "MyPost" :
			action = new MyPostAction();
			break;
		case "MyCmt" :
			action = new MyCmtAction();
			break;	
			
		// yr
		case "Board":
			action = new BoardAction();
			break;
		case "Dm2ChangeDecisionMaker":
			action = new Dm2ChangeDecisionMakerAction();
			break;
		case "Dm2Decision":
			action = new Dm2DecisionAction();
			break;
		case "Dm2Delete":
			action = new Dm2DeleteAction();
			break;
		case "Dm2Edit":
			action = new Dm2EditAction();
			break;
		case "Dm2Mini":
			action = new Dm2MiniAction();
			break;
		case "Option1ChangeJob":
			action = new Option1ChangeJobAction();
			break;
		case "Option1ChangeName":
			action = new Option1ChangeNameAction();
			break;
		case "Option1ChangePhone":
			action = new Option1ChangePhoneAction();
			break;
		case "Option1ChangePw":
			action = new Option1ChangePwAction();
			break;
		case "Option1ChangeTeam":
			action = new Option1ChangeTeamAction();
			break;
		case "OPtion1MemberLogout":
			action = new Option1MemberLogoutAction();
			break;
		case "Search1":
			action = new Search1Action();
			break;
		case "Search2":
			action = new Search2Action();
			break;
		case "Search3":
			action = new Search3Action();
			break;
		case "Search4":
			action = new Search4Action();
			break;
		case "Updatebar1Delete":
			action = new Updatebar1DeleteAction();
			break;
		case "UploadMP":
			action = new UploadMPAction();
			break;
		case "WorkspaceOrder":
			action = new WorkspaceOrderAction();
			break;
		}
		return action;
	}
}
