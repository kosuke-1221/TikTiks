<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    HttpSession currentsession = request.getSession(false);
    if (currentsession == null || currentsession.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>送信完了</title>
<link href="Password_Completion.css" rel="stylesheet" />
</head>

<body>
<c:import url="base.jsp">
<c:param name="title"></c:param>
<c:param name="scripts"></c:param>
<c:param name="content">
<section class="me-4">

    <div class="container">
        <h1>😊送信が完了しました😊</h1>
        <button class="button" onclick="location.href='<%= request.getContextPath() %>/Main/menu.jsp'">メインメニューに戻る</button>
        <br>
    </div>

</section>
</c:param>
</c:import>
</body>
</body>

</html>
