<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
        	😊にこにこシフトマジック😊
        </div>
        <div class="header-select">
            <select id="header-navigation" onchange="navigateToPage()">
                <option value="#user">ユーザー</option>
                <option value="#password-change">パスワード変更</option>
                <option value="#logout">ログアウト</option>
            </select>
        </div>
    </header>

    <!-- サイドバー -->
    <div class="sidebar">

    	<!-- 従業員用 -->
        <a href="#available-dates">出勤可能日時</a>
        <a href="#vacation-days">休暇希望日</a>
        <a href="#calendar">カレンダー</a>

        <!-- 管理者専用リンク（roleが "admin" の場合に表示） -->
        <c:if test="${sessionScope.role == 'admin'}">
      	    <a href="#shift-registration">シフト登録</a>
            <a href="#user-management">ユーザー管理</a>
            <a href="#shift-management">シフト管理</a>
            <a href="#reports">レポート</a>
        </c:if>

    </div>

    <!-- メインコンテンツ -->
    <div class="main-content">
        	<!-- ここに必要なコンテンツを追加 -->
    </div>

    <!-- フッター -->
    <footer class="footer">
        <div class="footer-content">
            <p>&copy; 2024 TikTiks. All rights reserved.</p>
        </div>
    </footer>

    <script>
        function navigateToPage() {
            const select = document.getElementById("header-navigation");
            const value = select.value;

            // Handle navigation based on selected option
            if (value) {
                window.location.hash = value; // Change the URL hash to the selected value
            }
        }
    </script>

</body>

</html>