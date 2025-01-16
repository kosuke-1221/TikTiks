<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ログアウト完了</title>
    <link href="menu.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .message-container {
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 80%;
            max-width: 400px;
        }

        .message-container h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        .message-container p {
            font-size: 18px;
            color: #666;
        }

        .message-container .redirect-message {
            font-size: 16px;
            color: #007bff;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <c:import url="base2.jsp">
        <c:param name="title" value="ログアウト完了"></c:param>
        <c:param name="content">
            <section class="message-container">
                <h1>ログアウトが完了しました。</h1>
                <p>3秒後にログイン画面に戻ります。</p>
                <p class="redirect-message">自動的にログイン画面に戻ります。</p>
                <meta http-equiv="refresh" content="3;url=login.jsp">
            </section>
        </c:param>
    </c:import>
</body>
</html>
