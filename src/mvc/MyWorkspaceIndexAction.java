package mvc;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.one.dao.WorkspaceFindManagerDao;
import com.one.dto.WorkspaceFindManagerDto;

import com.one.dao.MyWorkspaceListDao;
import com.one.dto.MyWorkspaceListDto;

public class MyWorkspaceIndexAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//협업공간 클릭 설명, 알림, 대외비, 완료
		int member_id = Integer.parseInt(request.getParameter("loginId"));
		int workspace_id = Integer.parseInt(request.getParameter("workspaceId"));
		
		MyWorkspaceListDao dao = new MyWorkspaceListDao();
		WorkspaceFindManagerDao fdao = new WorkspaceFindManagerDao();
		
		ArrayList<MyWorkspaceListDto> list = new ArrayList<MyWorkspaceListDto>();
		ArrayList<WorkspaceFindManagerDto> fList = new ArrayList<WorkspaceFindManagerDto>();
		
		try {
			list = dao.getMyWorkspace_List(member_id);
			fList = fdao.findManager(workspace_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		String workspaceName="";
		int workspaceId=0;
		for(MyWorkspaceListDto dto : list ) {
			if(workspace_id==dto.getWorkspace_id()){
				workspaceName = dto.getWorkspace_name();
				workspaceId = dto.getWorkspace_id();
			}
		}	
		/*
		 * JSONObject obj = new JSONObject(); for(MyWorkspaceListDto dto : list) {
		 * if(workspace_id==dto.getWorkspace_id()) { obj.put("workspace_id",
		 * dto.getWorkspace_id()); obj.put("summary", dto.getSummary());
		 * obj.put("confidential", dto.getConfidential()); obj.put("workspace_url",
		 * dto.getInvite_url()); obj.put("complete", dto.getComplete());
		 * obj.put("workspace_alarm", dto.getWorkspace_alarm()); } }
		 */
		request.setAttribute("loginId", member_id);
		request.setAttribute("workspaceId", workspaceId);
		request.setAttribute("workspaceName", workspaceName);
		request.setAttribute("workspacePostList", list); //이 두줄은 html, jsp를 위한 것임. 여기에 저장된 데이터는 json이 아니라 html!! 
		request.getRequestDispatcher("workspace_index.jsp").forward(request, response);//출력할 페이지로 req, resp 전송. 응답하는 것으로  요청한 것을 html로 구현한 것을 가지고 있음.
	}
}
