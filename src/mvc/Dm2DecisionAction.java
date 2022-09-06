package mvc;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yr.dao.DmDao;

public class Dm2DecisionAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int decision_making_id = Integer.parseInt(request.getParameter("decision_making_id"));
		int decision = Integer.parseInt(request.getParameter("decision"));
		int max = Integer.parseInt(request.getParameter("max"));
		DmDao d = new DmDao();
		try {
			d.setDecision(decision_making_id, max, decision);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
