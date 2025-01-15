<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>にこにこシフトマジック</title>
    <link href="login.css" rel="stylesheet" />
</head>

<body>
<c:import url="base2.jsp">
    <c:param name="title">ログイン</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section>
            <div class="container">
                <h2>😊 ログイン 😊</h2>

                <!-- ログインフォーム -->
                <form action="Login.action" method="POST">
                    <!-- ユーザーID入力 -->
                    <label for="userID">ユーザーID</label>
                    <input type="text" id="userID" name="userID" required />

                    <!-- パスワード入力 -->
                    <label for="password">パスワード</label>
                    <input type="password" id="password" name="password" required />

                    <!-- エラーメッセージ表示 -->
                    <c:if test="${not empty errorMessage}">
                        <p class="error-message">${errorMessage}</p>
                    </c:if>

                    <!-- ログインボタン -->
                    <button type="submit">ログイン</button>
                </form>

                <!-- 新規登録リンク -->
                <div class="register-link">
                    <p>新規ですか？ <a href="signup.jsp">登録はこちら</a></p>
                </div>
            </div>
        </section>
    </c:param>
</c:import>
</body>
</html>
