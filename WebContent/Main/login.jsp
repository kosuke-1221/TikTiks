<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>にこにこシフトマジックシステム - ログイン</title>
    <link rel="stylesheet" href="login.css"> <!-- 外部CSSファイルをリンク -->
</head>

<body>
    <!-- ヘッダー -->
    <header>
        <div class="header-title">
            <span>😁</span>にこにこシフトマジック<span>😁</span>
        </div>
    </header>

    <div class="container">
        <h2>😁 ログイン 😁</h2>
        <form action="login_action.jsp" method="POST">
            <label for="userID">ユーザーID</label>
            <input type="text" id="userID" name="userID" required>

            <label for="password">パスワード</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">ログイン</button>
        </form>
        <div class="register-link">
            <p>新規ですか？ <a href="register.jsp">登録はこちら</a></p>
        </div>
    </div>

    <!-- フッター -->
    <footer>© 2024 にこにこシフトマジック. All rights reserved.</footer>
</body>

</html>
