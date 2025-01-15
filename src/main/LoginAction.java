package main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;
import dao.UserDao;
import tool.Action;

public class LoginAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userID = request.getParameter("userID");
        String password = request.getParameter("password");

        UserDao userDao = new UserDao();
        HttpSession session = request.getSession();

        try {
            // ユーザーIDのバリデーション
            if (userID == null || userID.length() != 7) {
                request.setAttribute("errorMessage", "ユーザーIDは7桁で入力してください。");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return null;
            }

            // ユーザー情報を取得
            User user = userDao.getUserByUserID(userID);

            if (user == null) {
                request.setAttribute("errorMessage", "入力されたユーザーIDは存在しません。");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return null;
            }

            // パスワードのチェック
            if (!user.getPassword().equals(password)) {
                request.setAttribute("errorMessage", "パスワードが正しくありません。");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return null;
            }

            // ログイン成功処理
            session.setAttribute("userID", user.getUserID());
            session.setAttribute("name", user.getName());
            session.setAttribute("AUTHORITY", user.isAuthority());

            // 管理者と従業員でリダイレクト先を変更
            if (user.isAuthority()) {
                response.sendRedirect("menu2.jsp");
            } else {
                response.sendRedirect("menu.jsp");
            }
            return null;

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "システムエラーが発生しました。");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return null;
        }
    }
}
