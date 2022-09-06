package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.one.dao.WorkspaceSearchDao;
import com.yr.dto.NoneFolderDto;

public class WorkspaceSearchAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_id = Integer.parseInt(request.getParameter("loginId"));
		String input = request.getParameter("input");
		
		WorkspaceSearchDao dao = new WorkspaceSearchDao();
		ArrayList<NoneFolderDto> list = dao.searchWorkspace_Name(member_id, input);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array = new JSONArray();
		for(NoneFolderDto dto : list) {
			JSONObject obj = new JSONObject();
			obj.put("workspaceId", dto.getWorkspace_id());
			obj.put("workspace_name", dto.getWorkspace_name());
			System.out.println(dto.getWorkspace_name());
			obj.put("order", dto.getOrder());
			array.add(obj);
		}
		out.print(array);
	}
}
