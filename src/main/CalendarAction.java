package main;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import bean.Calendar;
import dao.CalendarDao;

@WebServlet("/Main/CalendarAction")
public class CalendarAction extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // セッションから userID を取得
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userID");

        if (userId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "ログインしていません。");
            return;
        }

        System.out.println("取得した user_id: " + userId);

        // DBからシフト情報を取得
        CalendarDao dao = new CalendarDao();
        List<Calendar> shiftList = dao.getShiftsByUser(userId);
        System.out.println("取得したシフトリスト: " + shiftList);

        // シフト情報を JSON に変換してリクエスト属性にセット
        Gson gson = new Gson();
        String shiftListJson = gson.toJson(shiftList);
        request.setAttribute("shiftListJson", shiftListJson);

        // calendar.jsp にフォワードする（JSONを直接返さない）
        request.getRequestDispatcher("calendar.jsp").forward(request, response);
    }
}
