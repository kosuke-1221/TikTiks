package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;



public class Password_ChangeAction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // フォームデータを取得
        String userID = (String) request.getSession().getAttribute("userID"); // ログインセッションから取得
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // パスワード一致チェック
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "新しいパスワードが一致しません。");
            request.getRequestDispatcher("/Password_Change.jsp").forward(request, response);
            return;
        }

        // データベース接続と更新処理
        String selectSql = "SELECT password FROM users WHERE user_id = ?";
        String updateSql = "UPDATE users SET password = ? WHERE user_id = ?";

        try (Connection connection = Database.getConnection();
             PreparedStatement selectStmt = connection.prepareStatement(selectSql);
             PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {

            // 現在のパスワードを確認
            selectStmt.setString(1, userID);
            ResultSet rs = selectStmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");

                if (!dbPassword.equals(currentPassword)) {
                    request.setAttribute("errorMessage", "現在のパスワードが正しくありません。");
                    request.getRequestDispatcher("/Password_Change.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "ユーザー情報が見つかりません。");
                request.getRequestDispatcher("/Password_Change.jsp").forward(request, response);
                return;
            }

            // 新しいパスワードに更新
            updateStmt.setString(1, newPassword);
            updateStmt.setString(2, userID);
            int result = updateStmt.executeUpdate();

            if (result > 0) {
                request.setAttribute("successMessage", "パスワードが正常に更新されました。");
            } else {
                request.setAttribute("errorMessage", "パスワード更新中にエラーが発生しました。");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "サーバーエラーが発生しました。");
        }

        // 結果を返す
        request.getRequestDispatcher("/Password_Change.jsp").forward(request, response);
    }
}
