package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.one.dao.DocumentEtcDao;
import com.one.dao.DocumentShowDao;
import com.one.dto.DocumentShowDto;

public class DocumentDetailAction implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int document_id = Integer.parseInt(request.getParameter("documentId"));
		int workspace_id = Integer.parseInt(request.getParameter("workspaceId"));
		int member_id = Integer.parseInt(request.getParameter("loginId"));
		
		ArrayList<DocumentShowDto> list = null;
		try {
			DocumentShowDao dao = new DocumentShowDao();
			list = dao.showDocument(document_id);
			
		/*	for(DocumentShowDto dto : list) {
				request.setAttribute("title", dto.getTitle());
				request.setAttribute("content", dto.getContent());
				request.setAttribute("workspace_name", dto.getWorkspace_name());
				request.setAttribute("pic", dto.getPic());
			}*/
			
			DocumentEtcDao edao = new DocumentEtcDao();
			request.setAttribute("alarm", edao.getDocumentAlarm(document_id, member_id));
			request.setAttribute("bookmark", edao.getDocumentBookmark(document_id, member_id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("documentList", list);
		request.setAttribute("documentId", document_id);//문서id저장. 임시저장리스트에 attr
		request.setAttribute("workspaceId", workspace_id);
		request.getRequestDispatcher("postedDocument.jsp").forward(request, response);
		
	}
}
