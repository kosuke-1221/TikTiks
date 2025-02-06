<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <!-- ...existing head要素... -->
    <title>既に提出済み</title>
</head>
<body>
    <c:import url="base.jsp">
        <c:param name="title" value="既に提出済み"></c:param>
        <c:param name="scripts"><!-- ...必要なスクリプト... --></c:param>
        <c:param name="content">
            <!-- ...existingレイアウト... -->
            <div class="message-container">
                <h2>シフト希望情報は既に提出済みです</h2>
                <p>再度提出する場合は管理者にお問い合わせください。</p>
                <button onclick="location.href='menu.jsp'">メニューへ戻る</button>
            </div>
            <!-- ...existingレイアウト... -->
        </c:param>
    </c:import>
</body>
</html>
