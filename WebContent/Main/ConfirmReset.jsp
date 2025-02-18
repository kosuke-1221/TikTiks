<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    HttpSession currentsession = request.getSession(false);
    if (currentsession == null || currentsession.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    // returnUrl が指定されていなければ referer を使用
    String returnUrlParam = request.getParameter("returnUrl");
    if (returnUrlParam == null || returnUrlParam.trim().isEmpty()) {
         returnUrlParam = request.getHeader("referer");
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${param.confirmTitle}" /></title>
    <link href="logout.css" rel="stylesheet" />
</head>
<body>
    <c:import url="base.jsp">
        <c:param name="title" value="${param.confirmTitle}" />
        <c:param name="scripts"></c:param>
        <c:param name="content">
            <section class="me-4">
                <div class="logout-container">
                    <h1>😊 にこにこシフトマジック 😊</h1>
                    <p><c:out value="${param.confirmMessage}" /></p>
                    <div class="confirmation" style="display: flex; gap: 10px; justify-content: center;">
                        <!-- 「はい」はPOST送信で情報を隠す -->
                        <form method="post" action="${param.actionUrl}">
                            <input type="hidden" name="returnUrl" value="<%= returnUrlParam %>" />
                            <button type="submit" class="button1">はい</button>
                        </form>
                        <!-- いいえは元の画面に戻る -->
                        <button class="button2" onclick="location.href='<%= returnUrlParam %>'">いいえ</button>
                    </div>
                </div>
            </section>
        </c:param>
    </c:import>
</body>
</html>
