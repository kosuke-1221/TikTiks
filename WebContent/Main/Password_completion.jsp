<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>完了画面</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            color: #333;
        }

        .container {
            text-align: center;
            max-width: 500px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        button {
            padding: 10px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #258f2f;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #258f2f;
        }

        a {
            color: green;
        }
    </style>
</head>

<body>

    <div class="container">
        <h1>変更が完了しました</h1>
        <button onclick="window.location.href='main.jsp'">メインメニューに戻る</button>
        <br>
    </div>

</body>

</html>
