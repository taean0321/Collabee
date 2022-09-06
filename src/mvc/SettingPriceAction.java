package mvc;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yr.dao.HomeDao;
import com.yr.dto.NoneFolderDto;

public class SettingPriceAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int loginId = Integer.parseInt(request.getParameter("loginId"));
		
		ArrayList<NoneFolderDto> listNone = null;
		String name = "";
		String email = "";
		String corName = "";
		int partnerN = 0;
		String picture = "";
		try {
			HomeDao hDao = new HomeDao();
			name = hDao.showName(loginId);
			email = hDao.showEmail(loginId);
			listNone = hDao.getHomeWorkspace(loginId);
			corName = hDao.showCorName(loginId);
			partnerN = hDao.getCountPartner(loginId);
			picture = hDao.showPicture(loginId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("corName", corName);
		request.setAttribute("partnerN", partnerN);
		request.setAttribute("email", email);
		request.setAttribute("name", name);
		request.setAttribute("picture", picture);
		request.setAttribute("list2", listNone);
		request.getRequestDispatcher("setting_price.jsp").forward(request, response);
	}

}
