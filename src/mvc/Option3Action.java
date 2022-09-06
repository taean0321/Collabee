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

public class Option3Action implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HomeDao hDao = new HomeDao();
		HttpSession session= request.getSession();
		//int member_id = (Integer)session.getAttribute("member_id");
		int member_id = 4;
		String name = "";
		int partnerN = 0;
		String email = "";
		String corName = "";
		String picture = null;
		ArrayList<NoneFolderDto> listNone = null;
		try {
			listNone = hDao.getHomeWorkspace(member_id);
			name = hDao.showName(member_id);
			partnerN = hDao.getCountPartner(member_id);
			picture = hDao.showPicture(member_id);
			//System.out.println(cor_manager);
			email = hDao.showEmail(member_id);
			corName = hDao.showCorName(member_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("email", email);
		request.setAttribute("corName", corName);
		request.setAttribute("list2", listNone);
		request.setAttribute("partnerN", partnerN);
		request.setAttribute("name", name);
		if(picture != null) {
			if(!picture.startsWith("http"))
				picture = "image/upload/" + picture;
			request.setAttribute("picture", picture);
		}
		request.getRequestDispatcher("0option3.jsp").forward(request, response);
	}

}
