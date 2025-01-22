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
                😊管理者画面😊
            </div>
            <!-- メインコンテンツ -->
            <div class="container">
                <!-- カード1 -->
                <a href="ShiftRegistration" class="card">
                    <h3>シフト登録</h3>
                    <p>簡単にシフトを登録できます。</p>
                </a>

                <!-- カード3 -->
                <a href="shared_calender.jsp" class="card">
                    <h3>共有カレンダー</h3>
                    <p>全員のシフトを視覚的にチェック。</p>
                </a>
            </div>
        </section>
    </c:param>
</c:import>
</body>
</html>
