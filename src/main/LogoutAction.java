package main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tool.Action;

public class LogoutAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 既存のセッションを取得（新規セッションは作成しない）
        HttpSession session = request.getSession(false);

        if (session != null) {
            // セッションを無効化
            session.invalidate();
        }

        // ログアウト後のリダイレクト先を指定（例：ログインページ）
        response.sendRedirect(request.getContextPath() + "/Main/logoutComplete.jsp");

        return null; // リダイレクトを行ったため、フォワードは不要
    }
}