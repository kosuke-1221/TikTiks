<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>にこにこシフトマジック</title>
    <link href="login.css" rel="stylesheet" />
    <style>
        .password-container {
            position: relative;
            width: 100%;
        }

        #password {
            width: 100%;
            padding-right: 3rem; /* ボタン分の余白を確保 */
            box-sizing: border-box; /* フィールド全体の幅を調整 */
        }

        .toggle-password {
            position: absolute;
            right: 0.5rem; /* フィールドの右端から適切な余白 */
            top: 35%; /* 垂直位置を微調整 */
            transform: translateY(-50%);
            cursor: pointer;
            background: transparent;
            border: none;
            font-size: 1rem;
            color: #333;
            padding: 0;
            height: 20px;
            width: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>

<body>
<c:import url="base2.jsp">
    <c:param name="title">ログイン</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section>
            <div class="container">
                <h2>😊 ログイン 😊</h2>

                <!-- ログインフォーム -->
                <form action="Login.action" method="POST">
                    <!-- ユーザーID入力 -->
                    <label for="userID">ユーザーID</label>
                    <input type="text" id="userID" name="userID" placeholder="例: 0001001" value="${param.userID}" required />

                    <!-- パスワード入力 -->
                    <label for="password">パスワード</label>
                    <div class="password-container">
                        <input type="password" id="password" name="password" placeholder="パスワードを入力" required />
                        <button type="button" class="toggle-password" onclick="togglePasswordVisibility()">
                        	<span class="eye-icon"></span>
                        </button>
                    </div>

                    <!-- エラーメッセージ表示 -->
                    <c:if test="${not empty errorMessage}">
                        <p class="error-message">${errorMessage}</p>
                    </c:if>

                    <!-- ログインボタン -->
                    <button type="submit">ログイン</button>
                </form>

                <!-- 新規登録リンク -->
                <div class="register-link">
                    <p>新規ですか？ <a href="signup.jsp">登録はこちら</a></p>
                </div>
            </div>
        </section>
    </c:param>
</c:import>

<script>
    function togglePasswordVisibility() {
        const passwordInput = document.getElementById("password");
        const button = document.querySelector(".toggle-password"); // ボタンの参照を取得
        const type = passwordInput.type === "password" ? "text" : "password";
        passwordInput.type = type;
        // アイコンの切り替え
        button.classList.toggle('active');
    }
</script>
</body>
</html>