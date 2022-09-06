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

import com.ta.dao.ChattingDao;
import com.ta.dao.PartnerDao;
import com.ta.dto.ChattingDto;
import com.ta.dto.PartnerDto;

@WebServlet("/ChattingListAndPartnerServlet")
public class ChattingListAndPartnerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int loginId = Integer.parseInt(request.getParameter("loginId"));
		PartnerDao pDao = new PartnerDao();
		ChattingDao cDao = new ChattingDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array = new JSONArray();
		JSONObject obj = null;
		
		JSONObject obj2 = new JSONObject();
		obj2.put("chattingMainName",cDao.getChattingMainName(loginId));
		array.add(obj2);
		
		ArrayList<ChattingDto> workspaceChattingName = cDao.getWorkspaceChattingNameList(loginId);
    	JSONArray workspaceChattingNameList = new JSONArray();
		for(ChattingDto dto : workspaceChattingName) {
    		obj = new JSONObject();
    		obj.put("chattingRoomName",dto.getChatting_name());
    		obj.put("chattingRoomId",dto.getChatting_room_id());
    		workspaceChattingNameList.add(obj);
    	}
		array.add(workspaceChattingNameList);
		
		ArrayList<ChattingDto> groupChattingName = cDao.getGroupChattingList(loginId);
    	JSONArray groupChattingList = new JSONArray();
		for(ChattingDto dto : groupChattingName) {
    		obj = new JSONObject();
    		obj.put("chattingRoomName",dto.getChatting_name());
    		obj.put("chattingRoomId",dto.getChatting_room_id());
    		groupChattingList.add(obj);
    	}
		array.add(groupChattingList);
		
		if(pDao.CompanyCheck(loginId)){
			ArrayList<PartnerDto> partnerList = pDao.getCompanyColleague(loginId);
        	JSONArray commpanyColleague = new JSONArray();
			for(PartnerDto dto : partnerList) {
        		obj = new JSONObject();
        		obj.put("name",dto.getName());
        		obj.put("email",dto.getEmail());
        		obj.put("picture",dto.getPicture());
        		obj.put("member_id",dto.getMember_id());
        		commpanyColleague.add(obj);
        	}
			array.add(commpanyColleague);
			
			ArrayList<PartnerDto> partnerList2 = pDao.getExternalPartner(loginId);
        	JSONArray externalPartner = new JSONArray();
			for(PartnerDto dto : partnerList2) {
        		obj = new JSONObject();
        		obj.put("name",dto.getName());
        		obj.put("email",dto.getEmail());
        		obj.put("picture",dto.getPicture());
        		obj.put("member_id",dto.getMember_id());
        		externalPartner.add(obj);
        	}
			array.add(externalPartner);
		} else {
			ArrayList<PartnerDto> partnerList = pDao.getPartner(loginId);
			JSONArray partner = new JSONArray();
			for(PartnerDto dto : partnerList) {
				obj = new JSONObject();
				obj.put("name",dto.getName());
        		obj.put("email",dto.getEmail());
        		obj.put("picture",dto.getPicture());
        		obj.put("member_id",dto.getMember_id());
        		partner.add(obj);
			}
			array.add(partner);
		}
		out.print(array);
	}
}
