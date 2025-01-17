package action;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;
import dao.UserDao;

public class PasswordUpdateAction {

    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // セッションからユーザー情報を取得
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp"); // ログインしていない場合はログインページへリダイレクト
            return;
        }

        // フォームからデータを取得
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // エラーチェック
        if (currentPassword == null || newPassword == null || currentPassword.isEmpty() || newPassword.isEmpty()) {
            response.getWriter().write("すべての欄を入力してください。");
            return;
        }

        // パスワード変更処理
        UserDao userDao = new UserDao();

        try {
            // 現在のパスワードが一致するか確認
            User user = userDao.getUserByUserID(currentUser.getUserID());
            if (user != null && user.getPassword().equals(currentPassword)) {
                // パスワードを更新
                user.setPassword(newPassword);
                boolean success = userDao.update(user);

                if (success) {
                    response.getWriter().write("パスワードが更新されました！");
                } else {
                    response.getWriter().write("パスワードの更新に失敗しました。");
                }
            } else {
                response.getWriter().write("現在のパスワードが間違っています。");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("エラーが発生しました。");
        }
    }
}
