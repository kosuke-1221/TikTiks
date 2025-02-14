<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    HttpSession currentsession = request.getSession(false);
    if (currentsession == null || currentsession.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>休暇希望日提出</title>
    <link rel="stylesheet" href="Vacation_Desired_Date.css">
</head>
<body>
    <!-- ヘッダーの共通部分をインクルード -->
	<c:import url="base.jsp">
	<c:param name="title"></c:param>
	<c:param name="scripts"></c:param>
	<c:param name="content">
	<section class="me-4">
        <div class="container">
            <h1>😊休暇希望日提出😊</h1>

            <!-- エラーメッセージがあれば表示 -->
            <c:if test="${not empty sessionScope.errorMessage}">
                <p style="color: red;">${sessionScope.errorMessage}</p>
                <c:remove var="errorMessage" />  <!-- メッセージ表示後、セッションから削除 -->
            </c:if>

			<form action="Vacation_Desired.action" method="post">
			    <label for="off-date">休暇希望日を選択してください:</label>
			    <input type="date" id="off-date" name="off-date">

			    <label for="reason">理由を記載してください:</label>
			    <textarea id="reason" name="reason" rows="3" placeholder="休暇の理由を記載してください"></textarea>

			    <button type="button" id="add-off-day">休暇日を追加</button>

			    <table id="off-day-table">
			        <thead>
			            <tr>
			                <th>休暇希望日</th>
			                <th>理由</th>
			                <th>削除</th>
			            </tr>
			        </thead>
			        <tbody id="off-day-list"></tbody>
			    </table>

			    <input type="hidden" id="vacation-dates" name="vacation-dates">
			    <input type="hidden" id="vacation-reasons" name="vacation-reasons">

			    <button type="submit" id="submit-off-days">休暇希望を送信</button>
			</form>
        </div>

        <!-- JavaScriptファイルを読み込み -->
        <script src="Vacation_Desired_Date.js"></script>
    </section>
    </c:param>
    </c:import>
</body>
</html>
