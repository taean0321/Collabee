package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.ta.dao.ChattingDao;
import com.ta.dto.ChattingMessageLinkDto;

public class ChattingLinkMessageAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int link_id = Integer.parseInt(request.getParameter("linkId"));
		ChattingDao cDao = new ChattingDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		ArrayList<ChattingMessageLinkDto> list = cDao.getChattingMessageLink(link_id);
		JSONObject obj = new JSONObject();
		for(ChattingMessageLinkDto dto : list) {
			obj.put("link_name",dto.getLink_name());
			obj.put("picture",dto.getPicture());
			obj.put("link_title",dto.getLink_title());
			obj.put("link_explanation",dto.getLink_explanation());
		}
		out.print(obj);
	}
}
