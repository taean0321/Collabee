package mvc;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.one.dao.MyPostDao;
import com.one.dao.MyWorkspaceListDao;
import com.one.dao.PrivateIdDao;
import com.one.dto.MyWorkspaceListDto;

public class MyPostAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int loginId = Integer.parseInt(request.getParameter("loginId"));
		MyPostDao dao = new MyPostDao();
		PrivateIdDao pao = new PrivateIdDao();
		
		request.setAttribute("postList", dao.getMyPost(1, loginId));
		request.setAttribute("workspaceId", pao.getPrivateId(loginId));
		request.getRequestDispatcher("MyPostCmt.jsp").forward(request, response);

		
	}
}
