package mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.one.dao.DocumentEtcDao;

public class DocumentBookmarkAlarmAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_id = Integer.parseInt(request.getParameter("loginId"));
		int document_id = Integer.parseInt(request.getParameter("documentId"));
		String text = request.getParameter("text");
		DocumentEtcDao dao = new DocumentEtcDao();

		switch(text) {
		case "noBookmark" :
			dao.setBookmark(member_id, document_id);
			break;
		case "onBookmark" :
			dao.DelBookmark(member_id, document_id);
			break;
		case "noAlarm" :
			dao.setDocumentAlarm(document_id, member_id);
			break;
		case "onAlarm" :
			dao.delDocumentAlarm(document_id, member_id);
			break;
		}
	}
}
