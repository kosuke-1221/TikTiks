package main;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import dao.ShiftRequestDao;
import dao.ShiftDao;

@WebServlet("/Main/ShiftRegistration")
public class ShiftRegistrationAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ShiftRequestDao dao = new ShiftRequestDao();
            request.setAttribute("availableShifts", dao.getAvailableShifts());
            // 追加：shiftsテーブルから全シフト詳細を取得
            ShiftDao shiftDao = new ShiftDao();
            request.setAttribute("shiftDetails", shiftDao.getAllShiftDetails());

            RequestDispatcher dispatcher = request.getRequestDispatcher("shift_registration.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "システムエラーが発生しました");
            request.getRequestDispatcher("shift_registration.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");

            String userId = request.getParameter("user_id");
            String shiftDate = request.getParameter("shift_date");
            String startTime = request.getParameter("start_time");
            String endTime = request.getParameter("end_time");
            String note = request.getParameter("note");

            // 入力値の検証
            if (userId == null || userId.trim().isEmpty() ||
                shiftDate == null || shiftDate.trim().isEmpty() ||
                startTime == null || startTime.trim().isEmpty() ||
                endTime == null || endTime.trim().isEmpty()) {
                throw new IllegalArgumentException("必須項目が未入力です");
            }

            ShiftRequestDao dao = new ShiftRequestDao();
            dao.insertShift(userId, shiftDate, startTime, endTime, note);

            // 登録成功時は一覧画面にリダイレクト
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