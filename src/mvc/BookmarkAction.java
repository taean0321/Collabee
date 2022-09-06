package mvc;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jm.dao.BookmarkDao;
import com.jm.dto.BookmarkDto;
import com.yr.dao.HomeDao;

public class BookmarkAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BookmarkDao bDao = new BookmarkDao();
		HomeDao hDao = new HomeDao();
		int loginId = 4;
		ArrayList<BookmarkDto> bList = bDao.bookmarkList(loginId);
		String name = "";
		int partnerN = 0;
		String picture = null;
		String email="";
		String corporationN="";
		name = hDao.showName(loginId);
		try {
			partnerN = hDao.getCountPartner(loginId);
			picture = hDao.showPicture(loginId);
			email = hDao.showEmail(loginId);
			corporationN = hDao.showCorName(loginId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("partnerN", partnerN);
		request.setAttribute("name", name);
		request.setAttribute("email", email);
		request.setAttribute("corName", corporationN);
		if(picture != null) {
			if(!picture.startsWith("http"))
				picture = "image/upload/" + picture;
			request.setAttribute("picture", picture);
		}
//		System.out.println("BookmarkAction에서 bList : " + bList);
		request.setAttribute("bList", bList);
		request.getRequestDispatcher("bookmark2.jsp").forward(request, response);
		
	}
	
	
}
