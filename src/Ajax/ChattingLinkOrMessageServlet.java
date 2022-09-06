package Ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ta.dao.ChattingDao;
import com.ta.dao.LinkDao;
import com.ta.dto.ChattingContentsDto;

@WebServlet("/ChattingLinkOrMessageServlet")
public class ChattingLinkOrMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int login_id = Integer.parseInt(request.getParameter("loginId"));
		int chatting_room_id = Integer.parseInt(request.getParameter("chattingRoomId"));
		String message = request.getParameter("message");
		ChattingDao cDao = new ChattingDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = null;
		LinkDao lDao = new LinkDao();
		int link_id=0;
		
		if(lDao.urlValidator(message)) {
			lDao.insertLinkChatting(login_id, chatting_room_id, message);
			link_id = lDao.SelectChattingLinkId(login_id, chatting_room_id, message);
			cDao.insertChattingLink(login_id, chatting_room_id, link_id);
			for(ChattingContentsDto list : cDao.getChattingContents(login_id, chatting_room_id, link_id)) {
				obj= new JSONObject();
				obj.put("message_id",list.getMessage_id());
				obj.put("name",list.getName());
				obj.put("picture",list.getPicture());
				obj.put("message",list.getMessage());
				obj.put("send_time",list.getSend_time());
				obj.put("link_id",list.getLink_id());
			}
		} else {
			cDao.insertChattingMessage(login_id, chatting_room_id, message);
			int message_id = cDao.SelectChattingMessageId(login_id, chatting_room_id, message);
			for(ChattingContentsDto list : cDao.getChattingMessage(message_id)){
				obj= new JSONObject();
				obj.put("message_id",list.getMessage_id());
				obj.put("name",list.getName());
				obj.put("picture",list.getPicture());
				obj.put("message",list.getMessage());
				obj.put("send_time",list.getSend_time());
				obj.put("link_id",list.getLink_id());
			}	
		}
		out.print(obj);
	}
}
