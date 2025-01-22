<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>シフト登録完了</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
            background-color: #f8f9fa;
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            max-width: 500px;
            width: 90%;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
        }
        .success-message {
            color: #4CAF50;
            margin-bottom: 30px;
            font-size: 18px;
            padding: 15px;
            background-color: #e8f5e9;
            border-radius: 4px;
        }
        .back-link {
            display: inline-block;
            text-decoration: none;
            color: #333;
            padding: 12px 24px;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: all 0.3s ease;
            background-color: white;
            font-weight: bold;
        }
        .back-link:hover {
            background-color: #f5f5f5;
            border-color: #4CAF50;
            color: #4CAF50;
            transform: translateY(-2px);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .icon {
            color: #4CAF50;
            font-size: 48px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">✓</div>
        <h1>シフト登録完了</h1>
        <p class="success-message">
            シフトの登録が正常に完了しました。<br>
            ご登録ありがとうございます。
        </p>
        <a href="ShiftRegistration" class="back-link">シフト登録画面に戻る</a>
    </div>

    <script>
        // 3秒後に自動的にシフト登録画面に戻る
        setTimeout(function() {
            window.location.href = 'ShiftRegistration';
        }, 3000);
    </script>
</body>
</html>