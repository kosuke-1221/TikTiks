<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>お知らせ</title>
<link href="news.css" rel="stylesheet" />
</head>

<body>
<c:import url="base.jsp">
<c:param name="title"></c:param>
<c:param name="content">
<section class="me-4">
    <div class="notification-container">
        <h2>😊お知らせ😊</h2>

        <!-- お知らせ追加フォーム（管理者のみ表示） -->
        <c:if test="${sessionScope.role == 'admin'}">
        	<div id="adminSection" style="display: none;">
            	<form id="notificationForm">
                	<input type="text" id="notificationTitle" placeholder="お知らせタイトル" required>
                	<textarea id="notificationMessage" placeholder="お知らせ内容" required></textarea>
                	<button type="submit">お知らせを追加</button>
            	</form>
        	</div>
        </c:if>

        <!-- お知らせリスト -->
        <div id="notificationList"></div>
    </div>

    <script src="news.js"></script>

</section>
</c:param>
</c:import>
</body>