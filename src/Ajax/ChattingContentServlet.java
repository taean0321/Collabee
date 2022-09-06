package Ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.ta.dao.ChattingDao;
import com.ta.dto.ChattingContentsDto;

@WebServlet("/ChattingContentServlet")
public class ChattingContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int message_id = Integer.parseInt(request.getParameter("messageId"));
		response.setCharacterEncoding("UTF-8");
		String message = request.getParameter("message");
		ChattingDao cDao = new ChattingDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = null;
		
		ArrayList<ChattingContentsDto> list = cDao.getChattingMessage(message_id);
		for(ChattingContentsDto ChattingMessage : list) {
			obj = new JSONObject();
			obj.put("message_id",ChattingMessage.getMessage_id());
			obj.put("name",ChattingMessage.getName());
			obj.put("picture",ChattingMessage.getPicture());
			obj.put("message",ChattingMessage.getMessage());
			obj.put("send_time",ChattingMessage.getSend_time());
			obj.put("link_id",ChattingMessage.getLink_id());
			obj.put("file_id",ChattingMessage.getFile_id());
		}
		out.print(obj);
	}
}
