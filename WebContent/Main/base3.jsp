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
            <p>&copy; 2025 TikTiks. All rights reserved.</p>
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
</script>

</body>
</html>