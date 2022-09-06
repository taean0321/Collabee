package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.jm.dao.PartnerListDao;
import com.jm.dto.PartnerListDto;
import com.one.dao.MyMemberListDao;
import com.one.dao.PrivateIdDao;
import com.one.dto.MemberInfoDto;

public class GetThisWorkspaceMemberAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int workspace_id = Integer.parseInt(request.getParameter("workspaceId"));
		int loginId = Integer.parseInt(request.getParameter("loginId"));
		
		PrivateIdDao pao = new PrivateIdDao();
		int privateSpaceId = pao.getPrivateId(loginId);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json"); 
		PrintWriter out = response.getWriter();
		
		JSONArray array = new JSONArray();

		if(privateSpaceId==workspace_id) {
			PartnerListDao lao = new PartnerListDao();
			ArrayList<PartnerListDto> list = lao.partnerList(loginId);
			
			for(PartnerListDto dto : list) {
				JSONObject obj = new JSONObject();
				obj.put("member_id", dto.getMember_id());
				obj.put("name", dto.getName());
				obj.put("picture", dto.getPicture());
				obj.put("email", dto.getEmail());
				array.add(obj);
			}
		} else {
			MyMemberListDao dao = new MyMemberListDao();
			ArrayList<MemberInfoDto> list = dao.getWorkspace_MemberList(workspace_id);
			for(MemberInfoDto dto : list) {
				JSONObject obj = new JSONObject();
				obj.put("member_id", dto.getMember_id());
				obj.put("name", dto.getName());
				obj.put("email", dto.getEmail());
				obj.put("picture", dto.getPicture());
				//obj.put("workspace_id", dto.getMember_id());
				obj.put("manager", dto.getManager_icon_p());
				array.add(obj);
			}
		}
		
		out.print(array);
	}
}
