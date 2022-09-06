package mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ta.dao.PartnerDao;

public class PartnerBlockAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int loginId = Integer.parseInt(request.getParameter("loginId"));
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		
		PartnerDao pDao = new PartnerDao();
		pDao.UpdatePartnerBlock(loginId, memberId);
		
//		request.getRequestDispatcher("partner_management.jsp").forward(request, response);		
	}
}
