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
import com.one.dto.MemberInfoDto;
import com.ta.dao.PartnerDao;
import com.ta.dto.PartnerDto;

public class WorkspaceInviteListAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_id = Integer.parseInt(request.getParameter("loginId"));
		
		int workspace_id = Integer.parseInt(request.getParameter("workspaceId"));
		
		PartnerListDao pdao = new PartnerListDao();
		ArrayList<PartnerListDto> pList = pdao.partnerList(member_id);//파트너 리스트 뽑기
		
		MyMemberListDao mdao = new MyMemberListDao();
		ArrayList<MemberInfoDto> mList = mdao.getWorkspace_MemberList(8);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray array = new JSONArray();
		for(int i = 0; i <= pList.size()-1; i++) {//파트너 멤버 id중에
			JSONObject obj = new JSONObject();
			int result = 0;
			int partner = pList.get(i).getMember_id();
			
			for(int j = 0; j <= mList.size()-1; j++) {//이미 공간멤버 id면 저장 안함
				int member = mList.get(j).getMember_id();
				if(partner!=member) {
					result=1;
					continue;
				} else {
					result=0;
					break;
				}
			}
			if(result == 1) {
				obj.put("memberId", partner);
				obj.put("email", pList.get(i).getEmail());
				obj.put("name", pList.get(i).getName());
				obj.put("picture", pList.get(i).getPicture());
				array.add(obj);
			}
		}
		out.print(array);
	}
}
