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

@WebServlet("/PartnerInviteServlet")
public class PartnerInviteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			response.setCharacterEncoding("UTF-8");
			String[] inviteList = request.getParameterValues("inviteList");
			int loginId = Integer.parseInt(request.getParameter("loginId"));
			PartnerDao pDao = new PartnerDao();
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			JSONObject obj = new JSONObject();	
			
			for(int i=0; i<=inviteList.length-1; i++) {
				if(pDao.CheckIniteMailDuplication(loginId, inviteList[i])) {
					pDao.setInvitePartner(loginId, inviteList[i]);
					pDao.SendMail(inviteList[i]);
				}
			}
			obj.put("invite","초대완료");
			out.print(obj);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
