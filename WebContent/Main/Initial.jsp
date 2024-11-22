<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>😊にこにこシフトマジック😊</title>
    <style>
        /* ベーススタイル */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: #f9f9f9;
            color: #333;
        }
        a {
            text-decoration: none;
            color: inherit;
        }
        /* ヘッダー */
        .header {
            background: #4caf50;
            color: #fff;
            padding: 10px 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .header h1 {
            margin: 0;
            font-size: 1.8rem;
        }
        /* コンテナ */
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 90vh;
            padding: 20px;
        }
        .box {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            width: 80%;
            max-width: 800px;
            background: #fff;
            border: 5px solid #4caf50;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        /* 各セクション */
        .section {
            flex: 1;
            padding: 40px 20px;
            text-align: center;
            color: #333;
        }
        .section h2 {
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .section p {
            font-size: 1rem;
            margin-bottom: 20px;
            color: #666;
        }
        .button {
            padding: 15px 20px;
            font-size: 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background: #4caf50;
            color: #fff;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .button:hover {
            background: #388e3c;
        }
        .button:active {
            transform: scale(0.95);
        }
        /* フッター */
        .footer {
            background: #4caf50; /* ヘッダーと同じ色 */
            color: #fff;
            text-align: center;
            padding: 10px 20px;
            margin-top: auto;
        }
        .footer p {
            margin: 0;
            font-size: 0.9rem;
        }
        /* レスポンシブデザイン */
        @media (max-width: 768px) {
            .box {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- ヘッダー -->
    <header class="header">
        <h1>😊にこにこシフトマジック😊</h1>
    </header>
    <!-- メインコンテンツ -->
    <main class="container">
        <div class="box">
            <div class="section">
                <h2>登録済みの方はこちら</h2>
                <p>いつものアカウントでログインして<br>シフトを簡単に確認・管理しましょう。</p>
                <button class="button" onclick="location.href='<%= request.getContextPath() %>/Main/login.jsp'">ログイン</button>
            </div>
            <div class="section">
                <h2>新規ユーザーはこちら</h2>
                <p>初めてのご利用ですか？<br>簡単な登録でシフト管理を始められます。</p>
                <button class="button" onclick="location.href='<%= request.getContextPath() %>/Main/signup.jsp'">新規登録</button>
            </div>
        </div>
    </main>
    <!-- フッター -->
    <footer class="footer">
        <p>© 2024 😊にこにこシフトマジック😊 All Rights Reserved.</p>
    </footer>
</body>
</html>
