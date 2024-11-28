package main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;
import dao.UserDao;
import tool.Action;

public class RegisterAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 入力データを取得
        String userID = request.getParameter("userID");
        String name = request.getParameter("name");
        String furigana = request.getParameter("furigana");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phone");

        // ユーザーIDのチェックとauthorityの設定
        boolean authority;
        try {
            int numericUserID = Integer.parseInt(userID);
            authority = numericUserID >= 1 && numericUserID <= 100; // 1~100は管理者
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ユーザーIDは数値で入力してください。");
            return "/Main/signup.jsp";  // 再度登録画面に戻る
        }

        // ユーザー情報の重複チェック
        UserDao userDao = new UserDao();
        if (userDao.isUserExists(userID, email, phoneNumber)) {
            request.setAttribute("errorMessage", "このユーザーID、メールアドレス、または電話番号は既に登録されています。");
            return "/Main/signup.jsp"; // 再度登録画面に戻る
        }

        // 電話番号の長さチェックとハイフンの削除（12文字以内に調整）
        if (phoneNumber != null) {
            phoneNumber = phoneNumber.replace("-", ""); // ハイフンを取り除く
            if (phoneNumber.length() > 12) {
                request.setAttribute("errorMessage", "電話番号は12文字以内で入力してください。");
                return "/Main/signup.jsp"; // 再度登録画面に戻る
            }
        }

        // Userオブジェクトを生成し、値を設定
        User user = new User();
        user.setUserID(userID);
        user.setName(name);
        user.setFurigana(furigana);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhoneNumber(phoneNumber);
        user.setAuthority(authority); // 設定したauthorityを適用

        // DAOを使用してデータを登録
        try {
            boolean success = userDao.insert(user);

            if (success) {
                // 登録成功後、成功画面にリダイレクト
                response.sendRedirect(request.getContextPath() + "/Main/success.jsp");
                return null; // ここでは遷移しないのでnullを返す
            } else {
                request.setAttribute("errorMessage", "登録に失敗しました。");
                return "/Main/signup.jsp"; // エラー時、再度登録画面を表示
            }
        } catch (Exception e) {
            // 例外処理の追加
            e.printStackTrace(); // エラーログを表示
            request.setAttribute("errorMessage", "データベースエラーが発生しました: " + e.getMessage());
            return "/Main/signup.jsp"; // エラー時、再度登録画面を表示
        }
    }
}
