package Main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;

public class Base {
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // リクエストからセッションを取得
        HttpSession session = req.getSession(false); // 既存のセッションを取得。存在しない場合はnullを返す

        if (session == null) {
            // セッションがない場合はログインページにリダイレクト
            res.sendRedirect("login.jsp");
            return; // それ以降の処理は実行しない
        }

        // セッションからユーザーオブジェクトを取得
        User user = (User) session.getAttribute("user");

        if (user != null) {
            // ユーザーオブジェクトから役割を取得
            String role = user.getRole(); // 役割を取得

            // 管理者の場合は追加の処理（必要に応じて）
            if ("admin".equals(role)) {
                // 管理者向け処理
                session.setAttribute("role", "admin"); // セッションに管理者役割をセット
            } else {
                // 一般ユーザーの場合
                session.setAttribute("role", "user"); // セッションにユーザー役割をセット
            }
        } else {
            // ユーザーがセッションに存在しない場合はログインページにリダイレクト
            res.sendRedirect("login.jsp");
        }
    }
}
