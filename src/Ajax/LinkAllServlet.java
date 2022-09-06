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

@WebServlet("/LinkAllServlet")
public class LinkAllServlet extends HttpServlet {
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
			ArrayList<LinkDto> list = lDao.getAllWorkspaceTotalLink(login_id);
			for(LinkDto AllWorkspaceTotalLink : list) {
				obj = new JSONObject();
				obj.put("link_picture",AllWorkspaceTotalLink.getLinkPicture());
				obj.put("link_id", AllWorkspaceTotalLink.getLink_id());
				obj.put("workspace_name", AllWorkspaceTotalLink.getWorkspace_name());
				obj.put("title", AllWorkspaceTotalLink.getTitle());
				obj.put("link_name", AllWorkspaceTotalLink.getLink_name());
				obj.put("link_title", AllWorkspaceTotalLink.getLink_title());
				obj.put("link_explanation", AllWorkspaceTotalLink.getLink_explanation());
				obj.put("picture", AllWorkspaceTotalLink.getPicture());
				array.add(obj);
			}
		} else {
			ArrayList<LinkDto> list = lDao.getSelectWorkspaceTotalLink(workspace_id);
			for(LinkDto SelectWorkspaceTotalLink : list) {
				obj = new JSONObject();
				obj.put("link_picture",SelectWorkspaceTotalLink.getLinkPicture());
				obj.put("link_id", SelectWorkspaceTotalLink.getLink_id());
				obj.put("workspace_name", SelectWorkspaceTotalLink.getWorkspace_name());
				obj.put("title", SelectWorkspaceTotalLink.getTitle());
				obj.put("link_name", SelectWorkspaceTotalLink.getLink_name());
				obj.put("link_title", SelectWorkspaceTotalLink.getLink_title());
				obj.put("link_explanation", SelectWorkspaceTotalLink.getLink_explanation());
				obj.put("picture", SelectWorkspaceTotalLink.getPicture());
				array.add(obj);
			}	
		}
		out.print(array);
	}
}
