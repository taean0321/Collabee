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
import com.ta.dto.RecentlyLinkDto;

@WebServlet("/LinkSelectWorkspaceServlet")
public class LinkSelectWorkspaceServlet extends HttpServlet {
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
			JSONArray AllWorkspaceTotalLink = new JSONArray();
			for(LinkDto dto : list) {
				obj = new JSONObject();
				obj.put("link_picture", dto.getLinkPicture());
				obj.put("link_id", dto.getLink_id());
				obj.put("workspace_name", dto.getWorkspace_name());
				obj.put("title", dto.getTitle());
				obj.put("link_name", dto.getLink_name());
				obj.put("link_title", dto.getLink_title());
				obj.put("link_explanation", dto.getLink_explanation());
				obj.put("picture", dto.getPicture());
				AllWorkspaceTotalLink.add(obj);
			}
			array.add(AllWorkspaceTotalLink);
			
			ArrayList<RecentlyLinkDto> list1 = lDao.getAllWorkspaceRecentlyLink(login_id);
			JSONArray SelectWorkspaceRecentlyLink = new JSONArray();
			for(RecentlyLinkDto dto : list1) {
				obj = new JSONObject();
				obj.put("link_id",dto.getLink_id());
				obj.put("link_title",dto.getLink_title());
				obj.put("link_name",dto.getLink_name());
				SelectWorkspaceRecentlyLink.add(obj);
			}
			array.add(SelectWorkspaceRecentlyLink);
		} else {
			ArrayList<LinkDto> list = lDao.getSelectWorkspaceTotalLink(workspace_id);
			JSONArray AllSelectWorkspaceTotalLink = new JSONArray();
			for(LinkDto dto : list) {
				obj = new JSONObject();
				obj.put("link_picture", dto.getLinkPicture());
				obj.put("link_id", dto.getLink_id());
				obj.put("workspace_name", dto.getWorkspace_name());
				obj.put("title", dto.getTitle());
				obj.put("link_name", dto.getLink_name());
				obj.put("link_title", dto.getLink_title());
				obj.put("link_explanation", dto.getLink_explanation());
				obj.put("picture", dto.getPicture());
				AllSelectWorkspaceTotalLink.add(obj);
			}
			array.add(AllSelectWorkspaceTotalLink);
			
			ArrayList<RecentlyLinkDto> list1 = lDao.getSelectWorkspaceRecentlyLink(workspace_id);
			JSONArray SelectWorkspaceRecentlyLink = new JSONArray();
			for(RecentlyLinkDto dto : list1) {
				obj = new JSONObject();
				obj.put("link_id",dto.getLink_id());
				obj.put("link_title",dto.getLink_title());
				obj.put("link_name",dto.getLink_name());
				SelectWorkspaceRecentlyLink.add(obj);
			}
			array.add(SelectWorkspaceRecentlyLink);
		}
		out.print(array);
	}
}
