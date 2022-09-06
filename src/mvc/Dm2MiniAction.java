package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.yr.dao.DmDao;
import com.yr.dto.Dm2PastDto;
import com.yr.dto.DmBarDto;
import com.yr.dto.DmWorkspaceMemberDto;

public class Dm2MiniAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_id = Integer.parseInt(request.getParameter("member_id"));
		int decision_making_id = Integer.parseInt(request.getParameter("decision_making_id"));
		int workspace_id = Integer.parseInt(request.getParameter("workspace_id"));
		DmDao d = new DmDao();
		ArrayList<Dm2PastDto> listPast = d.pastDecision(decision_making_id);
		String picture = null;
		picture = d.myPicture(member_id);
		int document_id = d.whowrote1(decision_making_id);
		int writer_id = d.whowrote2(document_id);
		String writer_picture = null;
		writer_picture = d.myPicture(writer_id);
		String writer_name = d.showWriterName(writer_id);
		ArrayList<DmBarDto> list = d.getDecisionList(decision_making_id);
		if(writer_picture != null) {
			if(!writer_picture.startsWith("http"))
				writer_picture = "image/upload/" + picture;
		}
		if(picture != null) {
			if(!picture.startsWith("http"))
				picture = "image/upload/" + picture;
		}
		int max = d.maxSequence(decision_making_id);
		String str = list.get(0).getEdit_date();
		String edit_date = str.substring(0, str.indexOf("."));
		//System.out.println(edit_date);
		
		response.setContentType("text/html;charset=UTF-8");
		response.setContentType("application/json"); 
		PrintWriter out  = response.getWriter(); 
		JSONObject obj = new JSONObject();
		obj.put("workspace_id", list.get(0).getWorkspace_id());
		obj.put("workspace_name", list.get(0).getWorkspace_name());
		obj.put("document_id", document_id);
		obj.put("document_title", list.get(0).getTitle());
		obj.put("dm_id", decision_making_id);
		obj.put("dm_title", list.get(0).getDecision_making_title());
		obj.put("max", max);
		obj.put("writer_name", writer_name);
		obj.put("writer_picture", writer_picture);
		obj.put("edit_date", edit_date);
		obj.put("name", list.get(0).getName());
		obj.put("picture", picture);
		
		JSONArray array = new JSONArray();
		for(Dm2PastDto dto : listPast) {
			JSONObject obj1 = new JSONObject();   // "JSONObject" ---> json-simple
			obj1.put("p_decision_icon_p",dto.getDecision_icon_p());
			obj1.put("p_decision_making_cur",dto.getDecision_making_cur());
			obj1.put("p_name",dto.getName());
			obj1.put("p_picture",dto.getPicture());
			String str1 = dto.getEdit_date();
			String p_edit_date = str1.substring(0, str1.indexOf("."));
			obj1.put("p_edit_date", p_edit_date);
			obj1.put("p_decision",dto.getDecision());
			array.add(obj1);
		}
		ArrayList<DmWorkspaceMemberDto> list2 = null;
		try {
			list2 = d.getWorkspaceMember(workspace_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		JSONArray array2 = new JSONArray();
		for(DmWorkspaceMemberDto dto2 : list2) {
			JSONObject obj2 = new JSONObject();   // "JSONObject" ---> json-simple
			obj2.put("next_member_id",dto2.getMember_id());
			obj2.put("next_picture",dto2.getPicture());
			obj2.put("next_name",dto2.getName());
			array2.add(obj2);
		}
		obj.put("array", array);
		obj.put("array2", array2);
		out.println(obj);
	}

}
