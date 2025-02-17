package main;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

@WebServlet("/AdminResetAllShiftSubmission")
public class AdminResetAllShiftSubmission extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            Class.forName("org.h2.Driver");
            conn = Database.getConnection();

            // 全スタッフの SHIFT_REQUESTS をリセット（削除）する
            String deleteSQL = "DELETE FROM SHIFT_REQUESTS";
            ps = conn.prepareStatement(deleteSQL);
            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "エラーが発生しました。");
        } finally {
            try { if(ps != null) ps.close(); } catch(Exception e) { }
            try { if(conn != null) conn.close(); } catch(Exception e) { }
        }
        String backUrl = URLEncoder.encode("EmployeeList.jsp", "UTF-8");
        response.sendRedirect(request.getContextPath() + "/Main/Reset_Completion.jsp?back=" + backUrl);
    }
}
