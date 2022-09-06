package mvc;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yr.dao.DmDao;

public class Dm2EditAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int decision_making_id = Integer.parseInt(request.getParameter("decision_making_id"));
		String decision_making_title = request.getParameter("title");
		DmDao d = new DmDao();
		try {
			d.changeTitle(decision_making_id, decision_making_title);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
