package mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yr.dao.OptionDao;

public class Option1ChangePwAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Pw = request.getParameter("newPassword");
		int member_id = Integer.parseInt(request.getParameter("member_id"));
		OptionDao oDao = new OptionDao();
		oDao.setPw(Pw, member_id);
	}

}
