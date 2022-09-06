package Ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.ta.dao.PartnerDao;

@WebServlet("/PartnerInvitationAgainServlet")
public class PartnerInvitationAgainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");
		response.setContentType("application/json");
		PartnerDao pDao = new PartnerDao();
		PrintWriter out = response.getWriter();
		
		pDao.SendMail(email);
		JSONObject obj = new JSONObject();
		obj.put("email",email);
		out.print(obj);
	}
}
