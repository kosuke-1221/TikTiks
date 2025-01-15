<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="base.css" rel="stylesheet" />
    <title>にこにこシフトマジック</title>
</head>

<body>

    <!-- ヘッダー -->
    <header>
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
                <option value="#user">ユーザー</option>
                <option value="Password_Change.jsp">パスワード変更</option>
                <option value="#logout">ログアウト</option>
            </select>
        </div>
    </header>

    <!-- サイドバー -->
    <div class="sidebar">
        <!-- 従業員専用 (AUTHORITYがfalseの場合に表示） -->
        <c:if test="${!sessionScope.AUTHORITY}">
            <a href="menu.jsp">メニュー</a>
            <a href="shift_desired.jsp">出勤可能日時</a>
            <a href="Vacation_Desired_Date.jsp">休暇希望日</a>
            <a href="shared_calender.jsp">カレンダー</a>
            <a href="News.action">お知らせ</a>
            <img src="MAGIC.png" alt="Logo" style="vertical-align: middle; margin-right: 10px;" />
        </c:if>

        <!-- 管理者専用 (AUTHORITYがtrueの場合に表示） -->
        <c:if test="${sessionScope.AUTHORITY}">
            <a href="menu2.jsp">メニュー</a>
            <a href="shift-entry.jsp">シフト登録</a>
            <a href="shared_calender.jsp">カレンダー</a>
            <a href="News.action">お知らせ</a>
            <img src="MAGIC.png" alt="Logo" style="vertical-align: middle; margin-right: 10px;" />
        </c:if>
    </div>

    <!-- メインコンテンツ -->
    <div class="content">
        ${param.content}
    </div>

    <!-- フッター -->
    <footer class="footer">
        <div class="footer-content">
            <p>&copy; 2024 TikTiks. All rights reserved.</p>
        </div>
    </footer>

    <script>
        function navigateToPage() {
            const selectedValue = document.getElementById("header-navigation").value;

            if (selectedValue === "#user") {
                window.location.hash = "user";
            } else if (selectedValue === "#logout") {
                window.location.href = "logout.jsp";
            } else {
                window.location.href = selectedValue;
            }
        }
    </script>

</body>

</html>
