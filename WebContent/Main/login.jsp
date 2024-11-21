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
<c:param name="title"></c:param>
<c:param name="scripts"></c:param>
<c:param name="content">
<section class="me-4">
    <div class="container">
        <h2>😊ログイン😊</h2>
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
</section>
</c:param>
</c:import>
</body>

</html>
