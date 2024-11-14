<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>にこにこシフトマジックシステム - ログイン</title>
    <style>
        /* CSSスタイル */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
        }

        header {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            background-color: #4caf50;
            color: white;
            padding: 15px;
            font-size: 1.5em;
            font-weight: bold;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 20;
        }

        .header-title {
            display: flex;
            align-items: center;
        }

        .header-title span {
            margin: 0 10px;
        }

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            box-sizing: border-box;
            margin-top: 80px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #218838;
        }

        .register-link {
            text-align: center;
            margin-top: 10px;
        }

        .register-link a {
            color: #007bff;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        footer {
            margin-top: auto;
            padding: 10px;
            text-align: center;
            font-size: 12px;
            color: #fff;
            background-color: #4caf50;
            width: 100%;
            position: absolute;
            bottom: 0;
            left: 0;
        }
    </style>
</head>

<body>
    <!-- ヘッダー -->
    <header>
        <div class="header-title">
            <span>😁</span>にこにこシフトマジック<span>😁</span>
        </div>
    </header>

    <div class="container">
        <h2>😁 ログイン 😁</h2>
        <form action="login" method="POST">
            <label for="userID">ユーザーID</label>
            <input type="text" id="userID" name="userID" required>

            <label for="password">パスワード</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">ログイン</button>
        </form>
        <div class="register-link">
            <p>新規ですか？ <a href="register.jsp">登録はこちら</a></p>
        </div>
    </div>

    <!-- フッター -->
    <footer>© 2024 にこにこシフトマジック. All rights reserved.</footer>
</body>

</html>
