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
            <select class="headerselect" id="header-navigation" onchange="navigateToPage()">
                <option value="#user">ユーザー</option>
                <option value="Password_Change.jsp">パスワード変更</option>
                <option value="#logout">ログアウト</option>
            </select>
        </div>
    </header>

    <!-- サイドバー -->
    <div class="sidebar">

    	<!-- 従業員用 -->
        <a href="shift_desired.jsp">出勤可能日時</a>
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
	            // ユーザーページに遷移（#userのハッシュリンクでもOK）
	            window.location.hash = "user";  // ユーザーセクションへスクロール
	        } else if (selectedValue === "#logout") {
	            // ログアウト処理
	            alert("ログアウトします");
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