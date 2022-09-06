package mvc;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.one.dao.DocumentDelDao;

public class DocumentDelAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int documentId = Integer.parseInt(request.getParameter("documentId"));
		DocumentDelDao dao = new DocumentDelDao();
		int result = dao.delDocument(documentId);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application.json");
		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		obj.put("IsDel", result);
		out.print(obj);
		//request.getRequestDispatcher("Controller?command=zAction&sec_command=select_Workspace_Index&workspaceId="+workspaceId);
	}
}
