package main;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;
import dao.UserDao;
import tool.Action;

public class RegisterAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userID = request.getParameter("userID");
        String name = request.getParameter("name");
        String furigana = request.getParameter("furigana");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phone");

        try {
            // 1. ユーザーIDのチェック（7桁の整数）
            if (userID == null || !userID.matches("\\d{7}")) {
                request.setAttribute("errorMessage", "ユーザーIDは7桁の整数で入力してください。");
                forwardToSignup(request, response);
                return null;
            }

            // 2. ユーザー情報の重複チェック
            UserDao userDao = new UserDao();
            if (userDao.isUserExists(userID, email, phoneNumber)) {
                request.setAttribute("errorMessage", "このユーザーID、メールアドレス、または電話番号は既に登録されています。");
                forwardToSignup(request, response);
                return null;
            }

            // 3. 電話番号のフォーマットチェックとハイフン削除
            if (phoneNumber != null) {
                phoneNumber = phoneNumber.replace("-", "");
                if (!phoneNumber.matches("\\d{10,12}")) {
                    request.setAttribute("errorMessage", "電話番号は10〜12桁の数字で入力してください。");
                    forwardToSignup(request, response);
                    return null;
                }
            }

            // 4. パスワードのバリデーション
            if (password == null || !password.matches("(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}")) {
                request.setAttribute("errorMessage", "パスワードは8文字以上で、大文字、小文字、数字を含めてください。");
                forwardToSignup(request, response);
                return null;
            }

            // 5. authorityの設定
            boolean authority = Integer.parseInt(userID) >= 1 && Integer.parseInt(userID) <= 100;

            // 6. Userオブジェクトを生成し、値を設定
            User user = new User();
            user.setUserID(userID);
            user.setName(name);
            user.setFurigana(furigana);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhoneNumber(phoneNumber);
            user.setAuthority(authority);

            // 7. DAOを使用してデータを登録
            boolean success = userDao.insert(user);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/Main/success.jsp");
                return null;
            } else {
                request.setAttribute("errorMessage", "登録に失敗しました。");
                forwardToSignup(request, response);
                return null;
            }
        } catch (Exception e) {
            // エラー処理
            e.printStackTrace();
            request.setAttribute("errorMessage", "システムエラーが発生しました: " + e.getMessage());
            forwardToSignup(request, response);
            return null;
        }
    }

    // signup.jsp にフォワードする共通メソッド
    private void forwardToSignup(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Main/signup.jsp");
        dispatcher.forward(request, response);
    }
}
