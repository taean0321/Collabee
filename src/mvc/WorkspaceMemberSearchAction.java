package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.one.dao.MyMemberListDao;
import com.one.dto.MemberInfoDto;

public class WorkspaceMemberSearchAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int workspace_id = Integer.parseInt(request.getParameter("workspaceId"));
		String input = request.getParameter("input");
		
		MyMemberListDao dao = new MyMemberListDao();
		ArrayList<MemberInfoDto> list = dao.searchMember_Name(workspace_id, input);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray array = new JSONArray();		
		for(MemberInfoDto dto : list) {
			JSONObject obj = new JSONObject();
			obj.put("picture", dto.getPicture());
			obj.put("member_id", dto.getMember_id());
			obj.put("name", dto.getName());
			obj.put("email", dto.getEmail());
			obj.put("manager_p", dto.getManager_icon_p());
			array.add(obj);
		}
		out.print(array);
	}
}
