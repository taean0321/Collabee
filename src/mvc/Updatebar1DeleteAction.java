package mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yr.dao.UpdatebarDao;

public class Updatebar1DeleteAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int news_id = Integer.parseInt(request.getParameter("newsId"));
		UpdatebarDao uDao = new UpdatebarDao();
		try {
			uDao.deleteNews(news_id);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
