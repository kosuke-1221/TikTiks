package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

@WebServlet("/AdminDatabaseReset")
public class Admin_DatabaseReset extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DEFAULT_PASSWORD = "NikoNiko2525"; // 初期パスワード例

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String message = "";
        try (Connection conn = Database.getConnection()) {
            // シフト提出テーブルの全件削除（テーブルが再利用可能になる）
            String deleteShiftSql = "DELETE FROM SHIFT_REQUESTS";
            try (PreparedStatement ps = conn.prepareStatement(deleteShiftSql)) {
                ps.executeUpdate();
            }
            // 全従業員のパスワードを初期値に更新
            String updateUsersSql = "UPDATE users SET password = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateUsersSql)) {
                ps.setString(1, DEFAULT_PASSWORD);
                ps.executeUpdate();
            }
            message = "データベースの内容をリセットしました。";
            request.getSession().setAttribute("message", message);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "リセット中にエラーが発生しました。");
        }
        response.sendRedirect("Reset_Completion.jsp");
    }
}
