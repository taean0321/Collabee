package mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.one.dao.DocumentIdRtDao;
import com.one.dao.DocumentPostDao;

public class PostDocumentAction implements Action{ //문서작성클릭

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_id = Integer.parseInt(request.getParameter("loginId"));
		int workspace_id = Integer.parseInt(request.getParameter("workspaceId"));
		int documentId=0;
		try {
			DocumentPostDao dao = new DocumentPostDao();//문서작성클릭, 임시저장
			DocumentIdRtDao rdao = new DocumentIdRtDao();//문서id
			dao.setDocument(member_id, workspace_id);
			documentId = rdao.getDocument_id(workspace_id, member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("documentId", documentId);//문서id저장. 임시저장리스트에 attr
		request.setAttribute("workspaceId", workspace_id);
		request.getRequestDispatcher("Document.jsp").forward(request, response);
	}
}
