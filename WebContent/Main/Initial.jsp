<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>にこにこシフトマジック</title>
<link href="Initial.css" rel="stylesheet" />
</head>

<body>
<c:import url="base2.jsp">
<c:param name="title"></c:param>
<c:param name="scripts"></c:param>
<c:param name="content">
<section class="me-4">
    <main class="container">
        <div class="box">
            <div class="section">
                <h2>😊登録済みの方はこちら😊</h2>
                <p>いつものアカウントでログインして<br>シフトを簡単に確認・管理しましょう。</p>
                <button class="button" onclick="location.href='<%= request.getContextPath() %>/Main/login.jsp'">ログイン</button>
            </div>
            <div class="section">
                <h2>😊新規ユーザーはこちら😊</h2>
                <p>初めてのご利用ですか？<br>簡単な登録でシフト管理を始められます。</p>
                <button class="button" onclick="location.href='<%= request.getContextPath() %>/Main/signup.jsp'">新規登録</button>
            </div>
        </div>
    </main>
</section>
</c:param>
</c:import>
</body>

</html>
