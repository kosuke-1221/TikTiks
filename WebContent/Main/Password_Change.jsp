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
    <script src="Password_Change.js"></script>
</head>

<body>
    <c:import url="base.jsp">
    <c:param name="title"></c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
    <section class="me-4">

        <div class="form-container">
            <h2>😊パスワード変更😊</h2>

		    <!-- エラーメッセージ表示 -->
		    <c:if test="${not empty sessionScope.errorMessage}">
		        <div class="error-message" style="color: red;">
		            ${sessionScope.errorMessage}
		        </div>
		        <c:remove var="errorMessage" scope="session" />
		    </c:if>

		    <!-- 変更フォーム -->
            <form id="passwordUpdateForm" action="Password_Change.action" method="POST">
                <!-- 現在のパスワード -->
                <div class="form-group">
                    <label for="currentPassword">現在のパスワード</label>
                    <div class="password-container">
                        <input type="password" id="currentPassword" name="currentPassword" placeholder="現在のパスワード" required>
                        <button type="button" class="toggle-password" onclick="togglePasswordVisibility('currentPassword', this)">
                        	<span class="eye-icon"></span>
                        </button>
                    </div>
                </div>

                <!-- 新しいパスワード -->
                <div class="form-group">
                    <label for="newPassword">新しいパスワード</label>
                    <div class="password-container">
                        <input type="password" id="newPassword" name="newPassword" placeholder="パスワードは8文字以上で、大文字、小文字、数字を含めてください。" required>
                        <button type="button" class="toggle-password" onclick="togglePasswordVisibility('newPassword', this)">
                        	<span class="eye-icon"></span>
                        </button>
                    </div>
                </div>

                <!-- 確認用パスワード -->
                <div class="form-group">
                    <label for="confirmPassword">新しいパスワード（確認）</label>
                    <div class="password-container">
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="新しいパスワードを再入力" required>
                        <button type="button" class="toggle-password" onclick="togglePasswordVisibility('confirmPassword', this)">
                        	<span class="eye-icon"></span>
                        </button>
                    </div>
                </div>

                <button type="submit">変更</button>
            </form>
        </div>

    </section>
    </c:param>
    </c:import>
</body>

</html>
