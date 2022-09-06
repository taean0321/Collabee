package mvc;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.one.dao.WorkspaceInviteMemberDao;

public class WorkspaceInviteMemberAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int workspace_id = Integer.parseInt(request.getParameter("workspaceId"));
		String inviteMember = request.getParameter("inviteMember");
		String[] list = inviteMember.split("_"); 
		WorkspaceInviteMemberDao dao = new WorkspaceInviteMemberDao();
		for(int i = 0; i <= list.length-1; i++) {
			
			dao.partner_invite(workspace_id, Integer.parseInt(list[i]));
		}
		
		
		
	}

}
