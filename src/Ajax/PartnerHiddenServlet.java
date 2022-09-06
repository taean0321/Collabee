package Ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ta.dao.PartnerDao;
import com.ta.dto.PartnerHiddenListDto;

@WebServlet("/PartnerHiddenServlet")
public class PartnerHiddenServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int login_id = Integer.parseInt(request.getParameter("login_id"));
		PartnerDao pDao = new PartnerDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array = new JSONArray();
		JSONObject obj = null;
		
		ArrayList<PartnerHiddenListDto> list = pDao.getPartnerHidden(login_id);
		for(PartnerHiddenListDto PartnerHidden: list) {
			obj = new JSONObject();
			obj.put("member_id",PartnerHidden.getMember_id());
			obj.put("name",PartnerHidden.getName());
			obj.put("email",PartnerHidden.getEmail());
			obj.put("picture",PartnerHidden.getPicture());
			array.add(obj);
		}
		out.print(array);
	}
}
