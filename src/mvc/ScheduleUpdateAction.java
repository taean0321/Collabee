package mvc;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.one.dao.ScheduleUpdateDao;

public class ScheduleUpdateAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("update schedule 들어옴");
		int schedule_id = Integer.parseInt(request.getParameter("scheduleId"));
		String title = request.getParameter("title");
		String summary = request.getParameter("summary");
		String start_date = request.getParameter("startDate");
		String finish_date = request.getParameter("finishDate");
		String location = request.getParameter("locations");
		String attendee = request.getParameter("attendee");
		ScheduleUpdateDao dao = new ScheduleUpdateDao();
		dao.updateSchedule(schedule_id, title, summary, start_date, finish_date, location, attendee);
		
		dao.updateScheduleAttnedee(schedule_id, attendee);
		
	}
}
