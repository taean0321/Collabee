package mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.one.dao.DocumentUpdateDao;

public class DocumentUpdateAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int document_id = Integer.parseInt(request.getParameter("documentId"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int workspace_id = Integer.parseInt(request.getParameter("workspaceId"));
		
		DocumentUpdateDao dao = new DocumentUpdateDao();
		dao.updateDocument(title, content, document_id);
		
		request.getRequestDispatcher("postedDocument.jsp?documentId="+document_id+"?workspaceId="+workspace_id).forward(request, response);
	}
}
