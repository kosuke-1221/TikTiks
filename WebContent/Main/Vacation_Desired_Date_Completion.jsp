<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>提出完了</title>
<link href="Password_Completion.css" rel="stylesheet" />
</head>

<body>
<c:import url="base.jsp">
<c:param name="title"></c:param>
<c:param name="scripts"></c:param>
<c:param name="content">
<section class="me-4">

    <div class="container">
        <h1>😊提出が完了しました😊</h1>
        <button onclick="window.location.href='main.jsp'">メインメニューに戻る</button>
        <br>
    </div>

</section>
</c:param>
</c:import>
</body>

</html>