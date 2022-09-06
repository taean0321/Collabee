package mvc;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yr.dao.DmDao;
import com.yr.dto.MyPartnerDto;
import com.yr.dto.MyWorkspaceDto;

public class Dm1Action implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_id = 4;
		DmDao d = new DmDao();
		ArrayList<MyPartnerDto> list1 = null;
		ArrayList<MyWorkspaceDto> list2 = null;
		try {
			list1 = d.getPartners(member_id);
			list2 = d.getWorkspace(member_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("list1", list1);
		request.setAttribute("list2", list2);
		request.getRequestDispatcher("0dm1.jsp").forward(request, response);
	}

}
