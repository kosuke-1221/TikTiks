package main;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.Database;

@WebServlet("/AdminResetShiftSubmission")
public class Admin_ResetShiftSubmission extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = request.getParameter("userID");
        if (userID == null || userID.isEmpty()) {
            response.sendRedirect("ResetShiftSubmission.jsp");
            return;
        }
        String deleteSql = "DELETE FROM SHIFT_REQUESTS WHERE user_id = ?";
        try (Connection conn = Database.getConnection();
                PreparedStatement ps = conn.prepareStatement(deleteSql)) {
            ps.setString(1, userID);
            int result = ps.executeUpdate();
            if (result > 0) {
                request.getSession().setAttribute("message", "ユーザー " + userID + " のシフト提出をリセットしました。");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "エラーが発生しました。");
        }
        String backUrl = URLEncoder.encode("ResetShiftSubmission.jsp", "UTF-8");
        response.sendRedirect(request.getContextPath() + "/Main/Reset_Completion.jsp?back=" + backUrl);
    }
}
