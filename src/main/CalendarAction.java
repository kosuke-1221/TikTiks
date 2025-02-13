package main;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Calendar;
import dao.CalendarDao;

@WebServlet("/Main/CalendarAction")
public class CalendarAction extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
        // セッションから user_id を取得
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userID");

        // ユーザーIDがセッションに存在しない場合、エラーを表示
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "ログインしていません。");
            return; // 実際にエラーを返して終了
        }

	    System.out.println("取得した user_id: " + userId); // ユーザーIDの確認

	    CalendarDao dao = new CalendarDao();
	    List<Calendar> shiftList = dao.getShiftsByUser(userId);

	    System.out.println("取得したシフトリスト: " + shiftList); // シフトリストの確認

	    request.setAttribute("shiftList", shiftList);
	    request.getRequestDispatcher("calendar.jsp").forward(request, response);
	}
}
