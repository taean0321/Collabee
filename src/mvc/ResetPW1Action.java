package mvc;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.jm.dao.ResetPW1Dao;

public class ResetPW1Action implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String n_pw = request.getParameter("n_pw");
		
		ResetPW1Dao rDao = new ResetPW1Dao();
		int result = rDao.ResetPW1(n_pw, email);
	
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		
		if(result == 1) {
			obj.put("result", "1");
		}else {
			obj.put("result", "0");
		}
		out.println(obj);
	}

}
