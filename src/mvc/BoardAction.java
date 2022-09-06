package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.yr.dao.Collabee_newinfoDao;
import com.yr.dto.CollabeenewinfoDto;

public class BoardAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int order = Integer.parseInt(request.getParameter("newinfo"));
		Collabee_newinfoDao iDao = new Collabee_newinfoDao();
		CollabeenewinfoDto list = null;
		try {
			list = iDao.getBoard(order);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=UTF-8");
		response.setContentType("application/json"); 
		PrintWriter out  = response.getWriter(); 
		JSONObject obj = new JSONObject();
		obj.put("title", list.getTitle());
		obj.put("content", list.getContent());
		obj.put("creation_date", list.getCreation_date());
		out.println(obj);
	}

}
