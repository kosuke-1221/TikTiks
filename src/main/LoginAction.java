package main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;
import dao.UserDao;
import tool.Action;  // Action クラスをインポート

public class LoginAction extends Action {  // Action クラスを継承

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userID = request.getParameter("userID");
        String password = request.getParameter("password");

        UserDao userDao = new UserDao();
        HttpSession session = request.getSession();

        try {
            // ユーザー情報を取得
            User user = userDao.getUserByUserID(userID);

            // ユーザーが存在し、パスワードが一致する場合
            if (user != null && user.getPassword().equals(password)) {
                // セッションにユーザー情報を保存
                session.setAttribute("userID", user.getUserID());
                session.setAttribute("name", user.getName());
                session.setAttribute("authority", user.isAuthority()); // true: 管理者, false: 従業員

                // ログイン成功後のリダイレクト先を決定
                if (user.isAuthority()) {
                    response.sendRedirect("menu2.jsp"); // 管理者用
                } else {
                    response.sendRedirect("menu.jsp"); // 従業員用
                }
                return null; // リダイレクト処理後、ここで終了
            } else {
                // ログイン失敗時の処理
                request.setAttribute("errorMessage", "ユーザーIDまたはパスワードが正しくありません。");
                return "login.jsp";  // フォワードするページ
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "ログイン処理中にエラーが発生しました。");
            return "login.jsp";  // フォワードするページ
        }
    }
}
