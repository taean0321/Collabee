package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.one.dao.myWorkspacePostDao;
import com.one.dto.MyPostDto;

public class MyWorkspacePostAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_id = Integer.parseInt(request.getParameter("loginId"));
		int workspace_id = Integer.parseInt(request.getParameter("workspaceId"));
		
		ArrayList<MyPostDto> list = new ArrayList<MyPostDto>();
		myWorkspacePostDao dao = new myWorkspacePostDao();
		list = dao.getMyPost(member_id, workspace_id);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		JSONArray array = new JSONArray();
		for(MyPostDto dto : list) {
			JSONObject obj = new JSONObject();
			obj.put("kanban_icon_p", dto.getKanban_icon_p());
			obj.put("title", dto.getTitle());
			System.out.println(dto.getTitle());
			obj.put("workspace_name", dto.getWorkspace_name());
			obj.put("date", dto.getDate());
			array.add(obj);
		}
		out.println(array);
	}
}
