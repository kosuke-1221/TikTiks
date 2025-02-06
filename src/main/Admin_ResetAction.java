package main;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.Database;

@WebServlet("/AdminReset")
public class Admin_ResetAction extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DEFAULT_PASSWORD = "NikoNiko2525"; // 初期パスワードを "NikoNiko2525" に変更

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = request.getParameter("userID");
        String type = request.getParameter("type"); // "shift" または "password"
        if(userID == null || userID.isEmpty() || type == null || type.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Main/menu2.jsp");
            return;
        }
        String message = "";
        String redirectPage = "";
        try (Connection conn = dao.Database.getConnection()) {
            if("shift".equals(type)) {
                // シフト提出リセット処理
                String deleteSql = "DELETE FROM SHIFT_REQUESTS WHERE user_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(deleteSql)) {
                    ps.setString(1, userID);
                    int result = ps.executeUpdate();
                    if(result > 0) {
                        message = "ユーザー " + userID + " のシフト提出をリセットしました。";
                    } else {
                        message = "リセット対象のシフト情報が見つかりませんでした。";
                    }
                }
                redirectPage = "ResetShiftSubmission.jsp";
            } else if("password".equals(type)) {
                // パスワードリセット処理
                String updateSql = "UPDATE users SET password = ? WHERE user_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                    ps.setString(1, DEFAULT_PASSWORD);
                    ps.setString(2, userID);
                    int result = ps.executeUpdate();
                    if(result > 0) {
                        message = "ユーザー " + userID + " のパスワードをリセットしました。";
                    } else {
                        message = "ユーザー情報が見つかりませんでした。";
                    }
                }
                redirectPage = "EmployeeList.jsp";
            } else {
                message = "不正なリクエストです。";
            }
            request.getSession().setAttribute("message", message);
        } catch(Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "エラーが発生しました。");
        }
        // 共通のリセット完了画面へリダイレクト。redirectPage は元の画面のパス
        String backUrl = URLEncoder.encode(redirectPage, "UTF-8");
        response.sendRedirect(request.getContextPath() + "/Main/Reset_Completion.jsp?back=" + backUrl);
    }
}
