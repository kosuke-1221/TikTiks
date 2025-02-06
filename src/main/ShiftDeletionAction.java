package main;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.ShiftRequestDao;

@WebServlet("/Main/ShiftDeletion")
public class ShiftDeletionAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            String userId = request.getParameter("user_id");
            String shiftDate = request.getParameter("shift_date");
            String startTime = request.getParameter("start_time");

            if(userId == null || userId.trim().isEmpty() ||
               shiftDate == null || shiftDate.trim().isEmpty() ||
               startTime == null || startTime.trim().isEmpty()) {
                throw new IllegalArgumentException("削除に必要な情報が不足しています");
            }

            ShiftRequestDao dao = new ShiftRequestDao();
            dao.deleteShift(userId, shiftDate, startTime);
            
            response.sendRedirect("ShiftRegistration");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("shift_registration.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "システムエラーが発生しました");
            request.getRequestDispatcher("shift_registration.jsp").forward(request, response);
        }
    }
}
