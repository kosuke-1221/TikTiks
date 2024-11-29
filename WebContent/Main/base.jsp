<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%
    // セッションに管理者のroleを強制的にセット
    session.setAttribute("role", "user");
%>

<!-- サイドバー付きのbase -->
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
            <select class="headerselect" id="header-navigation" onchange="navigateToPage()">
                <option value="#user">ユーザー</option>
                <option value="Password_Change.jsp">パスワード変更</option>
                <option value="#logout">ログアウト</option>
            </select>
        </div>
    </header>

    <!-- サイドバー -->
    <div class="sidebar">

    	<!-- 従業員専用 (roleが "user" の場合に表示） -->
    	<c:if test="${sessionScope.role == 'user'}">
        <a href="menu.jsp">メニュー</a>
        <a href="shift_desired.jsp">出勤可能日時</a>
        <a href="Vacation_Desired_Date.jsp">休暇希望日</a>
        <a href="shared_calender.jsp">カレンダー</a>
        <a href="News.action">お知らせ</a>
        <img src="MAGIC.png" alt="Logo" style="vertical-align: middle; margin-right: 10px;" />
        </c:if>

        <!-- 管理者専用（roleが "admin" の場合に表示） -->
        <c:if test="${sessionScope.role == 'admin'}">
      	    <a href="shift-entry.jsp">シフト登録</a>
            <a href="#user-management">ユーザー管理</a>
            <a href="#shift-management">シフト管理</a>
            <a href="#reports">レポート</a>
            <a href="news.jsp">お知らせ</a>
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
	    // ヘッダー内メニュー
	    function navigateToPage() {
	        const selectedValue = document.getElementById("header-navigation").value;

	        if (selectedValue === "#user") {
	            // ユーザーページに遷移（#userのハッシュリンクでもOK）
	            window.location.hash = "user";  // ユーザーセクションへスクロール
	        } else if (selectedValue === "#logout") {
	            // ログアウト処理
	            // ここにログアウト処理を追加（例えばセッションを切るなど）
	            window.location.href = "logout.jsp"; // ログアウトページに遷移
	        } else {
	            // その他のページに遷移
	            window.location.href = selectedValue; // パスワード変更ページなど
	        }
	    }
	</script>

</body>

</html>