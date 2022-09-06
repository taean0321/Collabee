package mvc;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yr.dao.DmDao;

public class Dm2ChangeDecisionMakerAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int decision_making_id = Integer.parseInt(request.getParameter("decision_making_id"));
		int n_member_id = Integer.parseInt(request.getParameter("member_id"));
		int max = Integer.parseInt(request.getParameter("max"));
		DmDao d = new DmDao();
		int now_decision = d.showDecision(decision_making_id, max);
		try {
			if(now_decision == 2) {
				d.changeDecisionMaker1(decision_making_id, max, n_member_id);
			}else {
				d.changeDecisionMaker2(decision_making_id, max, n_member_id);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
