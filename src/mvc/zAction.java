package mvc;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yr.dao.HomeDao;
import com.yr.dto.NoneFolderDto;

public class zAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("sec_command");  
		int loginId = Integer.parseInt(request.getParameter("loginId"));
		
		HomeDao hDao = new HomeDao();
		ArrayList<NoneFolderDto> listNone = null;
		String name = "";
		int partnerN = 0;
		String picture = null;
		String email="";
		String corporationN="";
		try {
			listNone = hDao.getHomeWorkspace(loginId);
			name = hDao.showName(loginId);
			partnerN = hDao.getCountPartner(loginId);
			picture = hDao.showPicture(loginId);
			email = hDao.showEmail(loginId);
			corporationN = hDao.showCorName(loginId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("list2", listNone);
		request.setAttribute("partnerN", partnerN);
		request.setAttribute("name", name);
		request.setAttribute("email", email);
		request.setAttribute("corporationN", corporationN);
		request.setAttribute("loginId", loginId);
		if(picture != null) {
			if(!picture.startsWith("http"))
				picture = "image/upload/" + picture;
			request.setAttribute("picture", picture);
		}
		request.getRequestDispatcher("Controller?command="+command).forward(request, response);
	}
	
}
