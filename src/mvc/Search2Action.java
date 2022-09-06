package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ta.dao.DBConnection;
import com.yr.dao.SearchDao;
import com.yr.dto.SearchCommentsDto;

public class Search2Action implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String word = request.getParameter("searchComments");
		int member_id = Integer.parseInt(request.getParameter("login_id"));
		
		SearchDao sDao = new SearchDao();
		Connection conn = DBConnection.getConnection();
		ArrayList<SearchCommentsDto> list = null;
		try {
			if(word.length()>0)
				list = sDao.searchComments(word, member_id);
			else
				list = new ArrayList<SearchCommentsDto>();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter(); 
		JSONArray array = new JSONArray();
		for(SearchCommentsDto dto : list) {
			JSONObject obj = new JSONObject();   // "JSONObject" ---> json-simple
			obj.put("picture",dto.getPicture());
			obj.put("name",dto.getName());
			obj.put("content",dto.getContent());
			obj.put("workspace_name",dto.getWorkspace_name());
			obj.put("title",dto.getTitle());
			obj.put("workspace_id",dto.getWorkspace_id());
			obj.put("document_id",dto.getDocument_id());
			obj.put("creation_date",dto.getCreation_date());
			array.add(obj);
		}
		out.println(array);
	}

}
