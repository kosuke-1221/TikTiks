<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="success.css">


<c:import url="base2.jsp">
    <c:param name="content">
        <div class="success-container">
            <div class="message-box">
                <h2>😊 登録完了！ 😊</h2>
                <p>ご登録ありがとうございます！</p>
                <p>アカウントの作成が完了しました。</p>
                <a href="login.jsp" class="cta-button">ログインページへ</a>
            </div>
        </div>
    </c:param>
</c:import>
