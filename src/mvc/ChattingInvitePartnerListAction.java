package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ta.dao.PartnerDao;
import com.ta.dto.PartnerDto;

public class ChattingInvitePartnerListAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int loginId = Integer.parseInt(request.getParameter("loginId"));
		JSONArray array = new JSONArray();
		PartnerDao pDao = new PartnerDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		ArrayList<PartnerDto> list = pDao.getPartner(loginId);
		for(PartnerDto partner : list) {
			JSONObject obj = new JSONObject();
			obj.put("member_id",partner.getMember_id());
			obj.put("name",partner.getName());
			obj.put("email",partner.getEmail());
			obj.put("picture",partner.getPicture());
			array.add(obj);
		}
		out.print(array);
	}
}
