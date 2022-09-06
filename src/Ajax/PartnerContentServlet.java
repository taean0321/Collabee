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
import com.ta.dto.InvitePartnerInformationDto;
import com.ta.dto.PartnerDto;

@WebServlet("/PartnerContentServlet")
public class PartnerContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int loginId = Integer.parseInt(request.getParameter("loginId"));
		PartnerDao pDao = new PartnerDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array = new JSONArray();
		JSONObject obj = null;
		
		JSONObject countInvitePartner = new JSONObject();
		countInvitePartner.put("alarm_count",pDao.getCountAlarm(loginId));
		array.add(countInvitePartner);
		
		ArrayList<InvitePartnerInformationDto> list = pDao.getInvitePartnerInformation(loginId);
		JSONArray invitePartnerInformation = new JSONArray();
		for(InvitePartnerInformationDto dto : list) {
			obj = new JSONObject();
			obj.put("partner_id",dto.getPartner_id());
			obj.put("invite_mail",dto.getInvite_mail());
			invitePartnerInformation.add(obj);
		}
		array.add(invitePartnerInformation);
		
		ArrayList<PartnerDto> list1 = pDao.getInviteMeInformation(loginId);
		JSONArray inviteMeInformation = new JSONArray();
		for(PartnerDto dto : list1) {
			obj = new JSONObject();
			obj.put("member_id",dto.getMember_id());
			obj.put("picture",dto.getPicture());
			obj.put("email",dto.getEmail());
			obj.put("name",dto.getName());
			inviteMeInformation.add(obj);
		}
		array.add(inviteMeInformation);
			
		if(pDao.CompanyCheck(loginId)) {
			JSONObject countCompanyColleague = new JSONObject();
			countCompanyColleague.put("companyColleague_count",pDao.getCountCompanyColleague(loginId));
			array.add(countCompanyColleague);
			
			ArrayList<PartnerDto> list3 = pDao.getCompanyColleague(loginId);
			JSONArray companyColleague = new JSONArray();
			for(PartnerDto dto : list3) {
				obj = new JSONObject();
				obj.put("member_id",dto.getMember_id());
				obj.put("picture",dto.getPicture());
				obj.put("email",dto.getEmail());
				obj.put("name",dto.getName());
				companyColleague.add(obj);
			}
			array.add(companyColleague);
			
			JSONObject countExternalPartner = new JSONObject();
			countExternalPartner.put("externalPartner_count",pDao.getCountExternalPartner(loginId));
			array.add(countExternalPartner);
			
			ArrayList<PartnerDto> list4 = pDao.getExternalPartner(loginId);
			JSONArray externalPartner = new JSONArray();
			for(PartnerDto dto : list4) {
				obj = new JSONObject();
				obj.put("member_id",dto.getMember_id());
				obj.put("picture",dto.getPicture());
				obj.put("email",dto.getEmail());
				obj.put("name",dto.getName());
				externalPartner.add(obj);
			}
			array.add(externalPartner);
			
		} else {
			JSONObject countPartne = new JSONObject();
			countPartne.put("partner_count",pDao.getCountPartne(loginId));
			array.add(countPartne);
			
			ArrayList<PartnerDto> list4 = pDao.getPartner(loginId);
			JSONArray partner = new JSONArray();
			for(PartnerDto dto : list4) {
				obj = new JSONObject();
				obj.put("member_id",dto.getMember_id());
				obj.put("picture",dto.getPicture());
				obj.put("email",dto.getEmail());
				obj.put("name",dto.getName());
				partner.add(obj);
			}
			array.add(partner);
		}
		out.print(array);
	}
}
