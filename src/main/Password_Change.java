package main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PasswordChangeServlet")
public class PasswordChangeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // リクエストパラメータを取得
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        // 仮にセッションから現在のパスワードを取得（本来はDBから取得する）
        String storedPassword = (String) session.getAttribute("userPassword");

        String message;
        if (storedPassword == null || !storedPassword.equals(currentPassword)) {
            message = "現在のパスワードが正しくありません。";
        } else if (newPassword == null || newPassword.length() < 8) {
            message = "新しいパスワードは8文字以上にしてください。";
        } else if (!newPassword.equals(confirmPassword)) {
            message = "新しいパスワードが一致しません。";
        } else {
            // パスワード更新処理
            boolean updateSuccess = updatePasswordInDatabase(session.getAttribute("userId"), newPassword);
            if (updateSuccess) {
                session.setAttribute("userPassword", newPassword); // セッションに新パスワードを保存
                message = "パスワードが正常に更新されました。";
            } else {
                message = "パスワード更新中にエラーが発生しました。";
            }
        }

        // フロントエンドに結果を返す
        response.setContentType("application/json");
        response.getWriter().write("{\"message\": \"" + message + "\"}");
    }

    private boolean updatePasswordInDatabase(Object userId, String newPassword) {
        // 実際のDB更新ロジックをここに記述
        // ここでは仮に成功を返す
        return true;
    }
}
