<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ja">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>新規登録 - にこにこシフトマジック</title>
            <link rel="stylesheet" href="signup.css">
            <style>
                /* スクロール可能な領域 */
                .form-container {
                    max-height: 80vh;
                    overflow-y: auto;
                    padding: 20px;
                }
            </style>
        </head>

        <body>
            <jsp:include page="base2.jsp">
                <jsp:param name="title" value="新規登録" />
                <jsp:param name="scripts" value="" />
                <jsp:param name="content" value="
            <div class='form-container'>
                <h2>😊新規登録😊</h2>
                <form action='Register.action' method='POST' class='signup-form'>
                    <div class='form-group'>
                        <label for='userID'>ユーザーID</label>
                        <input type='text' id='userID' name='userID' placeholder='例: 1010101' value='${param.userID}' required>
                    </div>
                    <div class='form-group'>
                        <label for='name'>名前</label>
                        <input type='text' id='name' name='name' placeholder='例: 山田 太郎' value='${param.name}' required>
                    </div>
                    <div class='form-group'>
                        <label for='furigana'>フリガナ</label>
                        <input type='text' id='furigana' name='furigana' placeholder='例: ヤマダ タロウ' value='${param.furigana}' required>
                    </div>
                    <div class='form-group'>
                        <label for='email'>メールアドレス</label>
                        <input type='email' id='email' name='email' placeholder='例: example@example.com' value='${param.email}' required>
                    </div>
                    <div class='form-group'>
                        <label for='password'>パスワード</label>
                        <input type='password' id='password' name='password' placeholder='パスワードは8文字以上で、大文字、小文字、数字を含めてください。' value='${param.password}' required>
                    </div>
                    <div class='form-group'>
                        <label for='phone'>電話番号</label>
                        <input type='tel' id='phone' name='phone' placeholder='例: 090-1234-5678' pattern='\\d{3}-\\d{4}-\\d{4}' value='${param.phone}' required>
                    </div>
                    <c:if test='${not empty errorMessage}'>
                        <div class='error-message'>
                            ${errorMessage}
                        </div>
                    </c:if>
                    <c:if test='${not empty successMessage}'>
                        <div class='success-message'>
                            ${successMessage}
                        </div>
                    </c:if>
                    <div class='form-actions'>
                        <button type='submit' class='submit-btn'>登録</button>
                    </div>
                    <p>既にアカウントをお持ちですか？ <a href='login.jsp'>ログイン</a></p>
                </form>
            </div>
        " />
            </jsp:include>

            <!-- 電話番号自動ハイフン挿入のJavaScript -->
            <script>
                // 電話番号入力時にハイフンを自動挿入
                document.getElementById('phone').addEventListener('input', function (e) {
                    var input = e.target;
                    var value = input.value.replace(/\D/g, '');  // 数字以外を取り除く
                    if (value.length >= 7) {
                        value = value.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
                    } else if (value.length >= 4) {
                        value = value.replace(/(\d{3})(\d{0,4})/, '$1-$2');
                    }
                    input.value = value;
                });
            </script>
        </body>

        </html>