<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="base3.css" rel="stylesheet" />
    <title>にこにこシフトマジック</title> <%-- 各ページで適切なタイトルを設定 --%>
</head>
<body>

    <header>
        <button class="sidebar-toggle" id="sidebarToggle">☰</button>
        <div class="header-title">
            <a href="<c:choose>
                    <c:when test="${!sessionScope.AUTHORITY}">menu.jsp</c:when>
                    <c:otherwise>menu2.jsp</c:otherwise>
                </c:choose>">😊にこにこシフトマジック😊</a>
        </div>

        <div class="header-user">
            ${sessionScope.name} 様
        </div>

        <div class="header-select">
            <select class="headerselect" id="header-navigation" onchange="navigateToPage()">
                <option value="#user" selected>ユーザー</option>
                <option value="Password_Change.jsp">パスワード変更</option>
                <option value="#logout">ログアウト</option>
            </select>
        </div>
    </header>

    <script>
        // ... (ヘッダーのJavaScriptコードはそのまま)
    </script>

    <div class="content">
        <%-- ここに各ページの内容 --%>
            ${param.content}
    </div>

    <footer class="footer">
        <div class="footer-content">
            <p>&copy; 2024 TikTiks. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>