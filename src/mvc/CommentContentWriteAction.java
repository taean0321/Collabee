package mvc;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.ta.dao.CommentDao;
import com.ta.dao.LinkDao;

public class CommentContentWriteAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int login_id = Integer.parseInt(request.getParameter("loginId"));
		int document_id = Integer.parseInt(request.getParameter("documentId"));
		String message = request.getParameter("message");
		CommentDao cDao = new CommentDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = null;
		LinkDao lDao = new LinkDao();
		int link_id=0;
		
		if(lDao.urlValidator(message)) {
			lDao.insertLinkDocument(login_id, document_id, message);
			link_id = lDao.SelectCommentLinkId(login_id, document_id, message);
			cDao.insertCommentLinkContent(login_id, document_id, link_id);
		} else {
			cDao.insertComments(login_id, document_id, message);
		}
		obj = new JSONObject();
		out.print(obj.put("documentId",document_id));		
	}
}
