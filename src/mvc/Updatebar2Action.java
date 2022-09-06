package mvc;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.one.dao.PrivateIdDao;
import com.yr.dao.HomeDao;
import com.yr.dao.UpdatebarDao;
import com.yr.dto.ArticleDto;
import com.yr.dto.NoneFolderDto;

public class Updatebar2Action implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session= request.getSession();
		HomeDao hDao = new HomeDao();
		//int member_id = (Integer)session.getAttribute("member_id");
		int member_id = 4;
		PrivateIdDao dao = new PrivateIdDao();
		int privateSpaceId = dao.getPrivateId(member_id);
		request.setAttribute("workspaceId", privateSpaceId);
		ArrayList<NoneFolderDto> listNone = null;
		String name = "";
		String email = "";
		String corName = "";
		UpdatebarDao uDao = new UpdatebarDao();
		ArrayList<ArticleDto> list = null;
		int partnerN = 0;
		String picture = null;
		try {
			listNone = hDao.getHomeWorkspace(member_id);
			list = uDao.setChecked(member_id);
			partnerN = hDao.getCountPartner(member_id);
			name = hDao.showName(member_id);
			picture = hDao.showPicture(member_id);
			email = hDao.showEmail(member_id);
			corName = hDao.showCorName(member_id);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//request.setAttribute("list2", listNone);
		request.setAttribute("email", email);
		request.setAttribute("corName", corName);
		if(picture != null) {
			if(!picture.startsWith("http"))
				picture = "image/upload/" + picture;
			request.setAttribute("picture", picture);
		}
		request.setAttribute("name", name);
		request.setAttribute("partnerN", partnerN);
		request.setAttribute("list", list);
		request.getRequestDispatcher("0updatebar2.jsp").forward(request, response);
	}

}
