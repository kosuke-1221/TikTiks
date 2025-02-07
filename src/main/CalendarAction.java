package main;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Calendar;
import dao.CalendarDao;

public class CalendarAction extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CalendarDao dao = new CalendarDao();
        List<Calendar> shiftList = dao.getShiftsByUser(userId);

        // shiftListをrequestオブジェクトにセット
        request.setAttribute("shiftList", shiftList);

        // calendar.jspに転送
        request.getRequestDispatcher("calendar.jsp").forward(request, response);
    }
}
