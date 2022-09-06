package mvc;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.ta.dao.PartnerDao;

public class PartnerInvitationAgainAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
