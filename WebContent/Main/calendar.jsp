<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="dao.CalendarDao" %>
<%@ page import="bean.Calendar" %>
<%@ page import="java.util.List" %>
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
    <title>にこにこシフトマジック</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.css" rel="stylesheet" />
    <link href="calendar.css" rel="stylesheet" />
</head>

<body class="calendar-page">
    <c:import url="base.jsp">
        <c:param name="title"></c:param>
        <c:param name="scripts"></c:param>
        <c:param name="content">
            <section class="me-4">
                <div class="container mt-4">
                    <h2 class="mb-4">😊シフトカレンダー😊</h2>
                    <label for="yearSelect" class="form-label">表示する年を選択:</label>
                    <select id="yearSelect" class="form-select w-auto mb-3">
                        <c:forEach var="year" begin="2020" end="3000">
                            <option value="${year}" <c:if test="${year == selectedYear}">selected</c:if>>${year}</option>
                        </c:forEach>
                    </select>
                    <div class="d-flex justify-content-between mb-3">
                        <button id="prevMonthButton" class="btn btn-primary">前の月へ</button>
                        <span id="currentMonth" class="align-self-center"></span>
                        <button id="nextMonthButton" class="btn btn-primary">次の月へ</button>
                    </div>
                    <div id="calendarContainer"></div>
                </div>
            </section>
        </c:param>
    </c:import>

	<script>
	    // サーバーから取得した shiftList を JavaScript のオブジェクトに変換
	    const shiftList = ${shiftList != null ? shiftList : '[]'};

	    // shiftList のデータ構造を確認（デバッグ用）
	    console.log("取得したシフトリスト:", shiftList);
	</script>

    <script src="calendar.js"></script>

</body>

</html>