<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>コンパクトな登録フォーム</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 20px;
        }

        .form-container {
            max-width: 350px;
            margin: 50px auto;
            background-color: #fff;
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 15px;
            font-size: 1.2em;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-size: 0.9em;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 0.9em;
            box-sizing: border-box;
        }

        .error {
            color: red;
            font-size: 0.8em;
            margin-bottom: 10px;
            text-align: center;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9em;
        }

        button:hover {
            background-color: #45a049;
        }

        /* ラベルと入力フィールド間の整列を調整 */
        .form-group {
            margin-bottom: 12px;
        }
    </style>
</head>

<body>

    <div class="form-container">
        <h2>😁新規登録😁</h2>
        <form id="registrationForm">
            <div class="form-group">
                <label for="email">メールアドレス</label>
                <input type="email" id="email" name="email" placeholder="example@example.com" required>
            </div>

            <div class="form-group">
                <label for="userID">ユーザーID</label>
                <input type="text" id="userID" name="userID" placeholder="IDを入力してください" required>
            </div>

            <div class="form-group">
                <label for="password">パスワード</label>
                <input type="password" id="password" name="password" placeholder="パスワードを入力してください" required>
            </div>

            <div class="form-group">
                <label for="name">名前</label>
                <input type="text" id="name" name="name" placeholder="名前を入力してください" required>
            </div>

            <div class="form-group">
                <label for="furigana">フリガナ</label>
                <input type="text" id="furigana" name="furigana" placeholder="フリガナを入力してください" required>
            </div>

            <div class="form-group">
                <label for="phone">電話番号</label>
                <input type="tel" id="phone" name="phone" placeholder="xxx-xxxx-xxxx" pattern="\d{3}-\d{4}-\d{4}" required>
            </div>

            <div id="errorMessage" class="error" style="display:none;"></div>

            <button type="submit">登録</button>
        </form>
    </div>

    <script>
        document.getElementById('registrationForm').addEventListener('submit', function (event) {
            event.preventDefault();

            // フォームの入力値を取得
            const email = document.getElementById('email').value;
            const userID = document.getElementById('userID').value;
            const password = document.getElementById('password').value;
            const name = document.getElementById('name').value;
            const furigana = document.getElementById('furigana').value;
            const phone = document.getElementById('phone').value;

            let errorMessage = '';

            // 未入力チェック
            if (!email || !userID || !password || !name || !furigana || !phone) {
                errorMessage = 'すべての欄を入力してください。';
            }

            // メール形式チェック
            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (email && !email.match(emailPattern)) {
                errorMessage = 'メールアドレスの形式が正しくありません。';
            }

            // 電話番号形式チェック
            const phonePattern = /^\d{3}-\d{4}-\d{4}$/;
            if (phone && !phone.match(phonePattern)) {
                errorMessage = '電話番号の形式が正しくありません。例: 090-1234-5678';
            }

            // エラーメッセージの表示
            const errorElement = document.getElementById('errorMessage');
            if (errorMessage) {
                errorElement.style.display = 'block';
                errorElement.textContent = errorMessage;
            } else {
                errorElement.style.display = 'none';
                // 正常な送信処理
                alert('登録が完了しました！');
                // フォームをリセット
                document.getElementById('registrationForm').reset();
                // 登録後にlogin.jspへリダイレクト
                window.location.href = 'login.jsp';
            }
        });
    </script>

</body>
</html>
