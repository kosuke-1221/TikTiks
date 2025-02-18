<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="menu.css" rel="stylesheet" />
</head>
<body>
<c:import url="base.jsp">
    <c:param name="title"></c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
			<div class="main-banner">
                😊シフト管理がもっと簡単に😊
            </div>
            <!-- メインコンテンツ -->
            <div class="container">
                <!-- カード1 -->
                <a href="shift_desired.jsp" class="card">
                    <h3>シフト希望を提出</h3>
                    <p>簡単にシフトの希望を申請できます</p>
                </a>

                <!-- カード2 -->
                <a href="Vacation_Desired_Date.jsp" class="card">
                    <h3>休暇希望日を申請</h3>
                    <p>休暇の予定を素早く申請できます</p>
                </a>

                <!-- カード3 -->
                <a href="CalendarAction" class="card">
                    <h3>シフトカレンダー</h3>
                    <p>自分のシフトを視覚的にチェックできます</p>
                </a>
            </div>
        </section>
    </c:param>
</c:import>
</body>
</html>
