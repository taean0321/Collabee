package Ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.ta.dao.CommentDao;

@WebServlet("/CommentGetLinkNameServlet")
public class CommentGetLinkNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int link_id = Integer.parseInt(request.getParameter("link_id"));
		CommentDao cDao = new CommentDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		
		obj.put("linkName",cDao.getLinkInformation(link_id));
		out.print(obj);
	}
}