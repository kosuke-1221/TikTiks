<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <!-- メインバナー -->
    <div class="main-banner">
        シフト管理がもっと簡単に
    </div>

    <!-- メインコンテンツ -->
    <div class="container">
        <!-- カード1 -->
        <div class="card">
            <h3>シフト希望を提出</h3>
            <p>簡単にシフトの希望を出せます。</p>
        </div>

        <!-- カード2 -->
        <div class="card">
            <h3>休暇希望日を申請</h3>
            <p>休暇の予定を素早く申請。</p>
        </div>

        <!-- カード3 -->
        <div class="card">
            <h3>カレンダーで確認</h3>
            <p>全員のシフトを視覚的にチェック。</p>
        </div>
    </div>
</section>
</c:param>
</c:import>
</body>
</html>

