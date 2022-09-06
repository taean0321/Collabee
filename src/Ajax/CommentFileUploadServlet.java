package Ajax;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.ta.dao.ChattingDao;
import com.ta.dao.CommentDao;

@WebServlet("/CommentFileUploadServlet")
public class CommentFileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getRealPath("/image/upload");
		File filePath = new File(path);
		if(filePath.exists()==false) {
			filePath.mkdirs();
		}
		int sizeLimit = 100*1024*1024;
		MultipartRequest multi = new MultipartRequest(request, path, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		int loginId = Integer.parseInt(multi.getParameter("loginId"));
		int documentId = Integer.parseInt(multi.getParameter("documentId"));
		String fileObject = (String)(files.nextElement());
		String fileName = multi.getFilesystemName(fileObject);
		
		CommentDao cDao = new CommentDao();
		cDao.InsertCommentFile(loginId, documentId, fileName);
		cDao.insertCommentFileContent(loginId, documentId, fileName);
		
		response.sendRedirect("comment.jsp");
	}
}
