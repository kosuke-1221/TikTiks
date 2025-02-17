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

@WebServlet("/AdminResetPassword")
public class Admin_ResetPasswordAction extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // 初期パスワードを "NikoNiko2525" に変更
    private static final String DEFAULT_PASSWORD = "NikoNiko2525";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = request.getParameter("userID");
        if (userID == null || userID.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Main/EmployeeList.jsp");
            return;
        }
        String updateSql = "UPDATE users SET password = ? WHERE user_id = ?";
        try (Connection conn = Database.getConnection();
                PreparedStatement ps = conn.prepareStatement(updateSql)) {
            ps.setString(1, DEFAULT_PASSWORD);
            ps.setString(2, userID);
            int result = ps.executeUpdate();
            if (result > 0) {
                request.getSession().setAttribute("message", "ユーザー " + userID + " のパスワードをリセットしました。");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "エラーが発生しました。");
        }
        // 完了画面へリダイレクト（"back" パラメータで元の画面指定：ここでは EmployeeList.jsp）
        String backUrl = URLEncoder.encode("EmployeeList.jsp", "UTF-8");
        response.sendRedirect(request.getContextPath() + "/Main/Reset_Completion2.jsp?back=" + backUrl);
    }
}
