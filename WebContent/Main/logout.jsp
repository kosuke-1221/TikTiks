<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ログアウト</title>
<link href="logout.css" rel="stylesheet" />
</head>

<body>
<c:import url="base2.jsp">
<c:param name="title"></c:param>
<c:param name="scripts"></c:param>
<c:param name="content">
<section class="me-4">

    <div class="logout-container">
        <h1>😊にこにこシフトマジック😊</h1>
        <p>ログアウトしますか？</p>
        <div class="confirmation">
            <button class="button1" onclick="location.href='<%= request.getContextPath() %>/Main/logoutAction'">はい</button>
            <button class="button2" onclick="location.href='<%= request.getContextPath() %>/Main/menu.jsp'">いいえ</button>
        </div>
    </div>

</section>
</c:param>
</c:import>
</body>

</html>