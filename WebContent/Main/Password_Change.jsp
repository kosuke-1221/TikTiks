<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>パスワード更新</title>
    <link href="Password_Change.css" rel="stylesheet" />
</head>

<body>
    <c:import url="base.jsp">
        <c:param name="title"></c:param>
        <c:param name="scripts"></c:param>
        <c:param name="content">
            <section class="me-4">

                <div class="form-container">
                    <h2>😊パスワード変更😊</h2>

                    <!-- サーバー側のメッセージを表示 -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error">${errorMessage}</div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="success">${successMessage}</div>
                    </c:if>
						<form id="passwordUpdateForm" action="/TikTiks/main/Password_ChangeAction" method="POST">
                        <div class="form-group">
                            <label for="currentPassword">現在のパスワード</label>
                            <input type="password" id="currentPassword" name="currentPassword" placeholder="現在のパスワード" required>
                        </div>

                        <div class="form-group">
                            <label for="newPassword">新しいパスワード</label>
                            <input type="password" id="newPassword" name="newPassword" placeholder="新しいパスワード" required>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">新しいパスワード（確認）</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="新しいパスワードを再入力" required>
                        </div>

                        <button type="submit">更新</button>
                    </form>
                </div>

            </section>
        </c:param>
    </c:import>
</body>

</html>
