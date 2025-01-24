package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;
import tool.Action;  // Actionクラスをインポート

public class Password_ChangeAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // フォームデータを取得
        String userID = (String) request.getSession().getAttribute("userID"); // ログインセッションから取得
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // パスワード一致チェック
        if (!newPassword.equals(confirmPassword)) {
            request.getSession().setAttribute("errorMessage", "新しいパスワードが一致しません。");
            System.out.println("Error: 新しいパスワードが一致しません。");
            response.sendRedirect("Password_Change.jsp"); // リダイレクトしてフォームを再表示
            return null;
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

                // プレーンテキストのパスワードを直接比較
                if (!dbPassword.equals(currentPassword)) {
                    request.getSession().setAttribute("errorMessage", "現在のパスワードが正しくありません。");
                    System.out.println("Error: 現在のパスワードが正しくありません");
                    response.sendRedirect("Password_Change.jsp"); // リダイレクトしてフォームを再表示
                    return null;
                }
            } else {
                request.getSession().setAttribute("errorMessage", "ユーザー情報が見つかりません。");
                System.out.println("Error: ユーザー情報が見つかりません");
                response.sendRedirect("Password_Change.jsp"); // リダイレクトしてフォームを再表示
                return null;
            }

            // 新しいパスワードに更新
            updateStmt.setString(1, newPassword);  // ハッシュ化せずにそのまま保存
            updateStmt.setString(2, userID);
            int result = updateStmt.executeUpdate();

            if (result > 0) {
                System.out.println("パスワードが正常に更新されました。");
                response.sendRedirect("Password_Completion.jsp"); //変更完了ページ
            } else {
                request.getSession().setAttribute("errorMessage", "パスワード更新中にエラーが発生しました。");
                System.out.println("Error: パスワード更新中にエラーが発生しました");
                response.sendRedirect("Password_Change.jsp"); // リダイレクトしてフォームを再表示
                return null;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "サーバーエラーが発生しました。");
            System.out.println("Error: サーバーエラーが発生しました");
            response.sendRedirect("Password_Change.jsp"); // リダイレクトしてフォームを再表示
            return null;
        }
        return null;
    }
}
