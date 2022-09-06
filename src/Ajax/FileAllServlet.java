package Ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ta.dao.FileDao;
import com.ta.dto.FileDto;

@WebServlet("/FileAllServlet")
public class FileAllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		int workspace_id = Integer.parseInt(request.getParameter("workspace_id"));
		int login_id = Integer.parseInt(request.getParameter("login_id"));
		FileDao fDao = new FileDao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array = new JSONArray();
		JSONObject obj = null;
		if(workspace_id==0) {
			ArrayList<FileDto> list = fDao.getAllWorkspaceTotalFile(login_id);
			JSONArray AllWorkspaceTotalFile = new JSONArray();
			for(FileDto dto : list) {
				obj = new JSONObject();
				obj.put("picture",dto.getPicture());
				obj.put("file_id",dto.getFile_id());
				obj.put("workspace_name",dto.getWorkspace_name());
				obj.put("file_name",dto.getFile_name());
				AllWorkspaceTotalFile.add(obj);
			}
			array.add(AllWorkspaceTotalFile);
		} else {
			ArrayList<FileDto> list = fDao.getSelectWorkspaceTotalFile(workspace_id);
			JSONArray SelectWorkspaceTotalFile = new JSONArray();
			for(FileDto dto : list) {
				obj = new JSONObject();
				obj.put("picture",dto.getPicture());
				obj.put("file_id",dto.getFile_id());
				obj.put("workspace_name",dto.getWorkspace_name());
				obj.put("file_name",dto.getFile_name());
				SelectWorkspaceTotalFile.add(obj);
			}
			array.add(SelectWorkspaceTotalFile);
		}
		out.print(array);
	}
}
