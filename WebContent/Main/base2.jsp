<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- サイドバー無しのbase -->
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="base2.css" rel="stylesheet" />
    <title>にこにこシフトマジック</title>
</head>

<body>
	<!-- ヘッダー -->
    <header>
        <div class="header-title">
        	😊にこにこシフトマジック😊
        </div>
    </header>
    <c:if test="${sessionScope.user == null}">
    <!-- ログインしていない場合、サイドバーを表示しない -->
    <style>
        .sidebar {
            display: none;
        }
    </style>
</c:if>

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
</body>
</html>