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

    <!-- サイドバー -->
    <div class="sidebar" id="sidebar">
        <!-- 従業員専用 (AUTHORITYがfalseの場合に表示） -->
        <c:if test="${!sessionScope.AUTHORITY}">
            <a href="menu.jsp">メニュー</a>
            <a href="shift_desired.jsp">出勤可能日時</a>
            <a href="Vacation_Desired_Date.jsp">休暇希望日</a>
            <a href="shared_calender.jsp">カレンダー</a>
            <img src="MAGIC.png" alt="Logo" style="vertical-align: middle; margin-right: 10px;" />
        </c:if>

        <!-- 管理者専用 (AUTHORITYがtrueの場合に表示） -->
        <c:if test="${sessionScope.AUTHORITY}">
            <a href="menu2.jsp">メニュー</a>
            <a href="ShiftRegistration">シフト登録</a>
            <a href="VacationRequestList">休暇希望リスト</a>
            <a href="shared_calender.jsp">カレンダー</a>
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
    // ページロード時に現在のページに応じて選択を設定
    function setInitialMenuSelection() {
        const currentUrl = window.location.href; // 現在のURL
        const menu = document.getElementById("header-navigation");

        // URLに応じて選択肢を設定
        if (currentUrl.includes("#user")) {
            menu.value = "#user";
        } else if (currentUrl.includes("logout.jsp")) {
            menu.value = "#logout";
        } else if (currentUrl.includes("Password_Change.jsp")) {
            menu.value = "Password_Change.jsp";
        } else {
            menu.value = "#user"; // デフォルト値
        }
    }

    // ページ読み込み時に初期選択を設定
    window.onload = setInitialMenuSelection;

    // ヘッダー内メニュー処理
    function navigateToPage() {
        const selectedValue = document.getElementById("header-navigation").value;

        if (selectedValue === "#user") {
            window.location.hash = "user"; // ユーザーセクションへスクロール
        } else if (selectedValue === "#logout") {
            window.location.href = "logout.jsp"; // ログアウトページに遷移
        } else {
            window.location.href = selectedValue; // その他のページ
        }
    }

    // サイドバーを表示・非表示に切り替える機能
    document.getElementById('sidebarToggle').addEventListener('click', function () {
        const sidebar = document.querySelector('.sidebar'); // サイドバーを取得
        const content = document.querySelector('.content'); // メインコンテンツを取得

        // サイドバーの表示/非表示を切り替える
        if (sidebar.style.display === 'none' || sidebar.style.display === '') {
            sidebar.style.display = 'block'; // サイドバーを表示
            content.style.display = 'none'; // メインコンテンツを非表示
        } else {
            sidebar.style.display = 'none'; // サイドバーを非表示
            content.style.display = 'block'; // メインコンテンツを表示
        }
    });
</script>

</body>

</html>
