package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ta.dao.CommentDao;
import com.ta.dto.CommentDto;

public class CommentContentAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int documentId = Integer.parseInt(request.getParameter("documentId"));
		JSONArray array = new JSONArray();
		CommentDao cDao = new CommentDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = null;
		
		ArrayList<CommentDto> list = cDao.getComment(documentId);
		for(CommentDto comment : list ) {
			obj = new JSONObject();
			obj.put("comment_id",comment.getComment_id());
			obj.put("picture", comment.getPicture());
			obj.put("name", comment.getName());
			obj.put("creation_date", comment.getCreation_date());
			obj.put("content", comment.getContent());
			obj.put("file_id", comment.getFile_id());
			obj.put("link_id", comment.getLink_id());
			array.add(obj);
		}
		out.print(array);
	}
}
