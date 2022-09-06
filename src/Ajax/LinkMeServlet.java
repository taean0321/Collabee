package Ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ta.dao.LinkDao;
import com.ta.dto.LinkDto;

@WebServlet("/LinkMeServlet")
public class LinkMeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int workspace_id = Integer.parseInt(request.getParameter("workspace_id"));
		int login_id = Integer.parseInt(request.getParameter("login_id"));
		LinkDao lDao = new LinkDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array = new JSONArray();
		JSONObject obj = null;
		
		if(workspace_id==0) {
			ArrayList<LinkDto> list = lDao.getAllWorkspaceMyLink(login_id);
			for(LinkDto AllWorkspaceMyLink : list) {
				obj = new JSONObject();
				obj.put("link_picture",AllWorkspaceMyLink.getLinkPicture());
				obj.put("link_id", AllWorkspaceMyLink.getLink_id());
				obj.put("workspace_name", AllWorkspaceMyLink.getWorkspace_name());
				obj.put("title", AllWorkspaceMyLink.getTitle());
				obj.put("link_name", AllWorkspaceMyLink.getLink_name());
				obj.put("link_title", AllWorkspaceMyLink.getLink_title());
				obj.put("link_explanation", AllWorkspaceMyLink.getLink_explanation());
				obj.put("picture", AllWorkspaceMyLink.getPicture());
				array.add(obj);
			}
		} else {
			ArrayList<LinkDto> list = lDao.getSelectWorkspaceMyLink(login_id, workspace_id);
			for(LinkDto SelectWorkspaceMyLink : list) {
				obj = new JSONObject();
				obj.put("link_picture",SelectWorkspaceMyLink.getLinkPicture());
				obj.put("link_id", SelectWorkspaceMyLink.getLink_id());
				obj.put("workspace_name", SelectWorkspaceMyLink.getWorkspace_name());
				obj.put("title", SelectWorkspaceMyLink.getTitle());
				obj.put("link_name", SelectWorkspaceMyLink.getLink_name());
				obj.put("link_title", SelectWorkspaceMyLink.getLink_title());
				obj.put("link_explanation", SelectWorkspaceMyLink.getLink_explanation());
				obj.put("picture", SelectWorkspaceMyLink.getPicture());
				array.add(obj);
			}
		}
		out.print(array);
	}
}
