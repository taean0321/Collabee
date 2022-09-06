package mvc;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yr.dao.HomeDao;

public class WorkspaceOrderAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session= request.getSession();
		//int member_id = (Integer)session.getAttribute("member_id");
		int member_id = 4;
//		JSONArray jarr = new JSONArray();
//		jarr = new JSONArray(request.getParameter("array"));
		String[] arr = request.getParameterValues("main");
		System.out.println(Arrays.toString(arr));
		int[] arr2 = new int[arr.length];
		for(int i = 0; i<=arr.length-1; i++) {
			int j = Integer.parseInt(arr[i]);
			arr2[i] = j;
		}
		System.out.println(Arrays.toString(arr2));
		HomeDao hDao = new HomeDao();
		hDao.deleteWorkspaceOrder(member_id);
		for(int i = 0; i<=arr2.length-1; i++) {
			try {
				hDao.updateWorkspaceOrder(i+1, member_id, arr2[i]);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

}
