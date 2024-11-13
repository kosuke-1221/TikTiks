<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>パスワード更新</title>
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
            font-size: 1.3em;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-size: 0.9em;
        }

        input[type="password"] {
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
    </style>
</head>

<body>

    <div class="form-container">
        <h2>😁パスワード更新😁</h2>
        <form id="passwordUpdateForm">
            <div class="form-group">
                <label for="currentPassword">現在のパスワード</label>
                <input type="password" id="currentPassword" name="currentPassword" placeholder="現在のパスワード" required>
            </div>

            <div class="form-group">
                <label for="newPassword">新しいパスワード</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="新しいパスワード" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">新しいパスワード（確認）</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="新しいパスワードを再入力" required>
            </div>

            <div id="errorMessage" class="error" style="display:none;"></div>

            <button type="submit">更新</button>
        </form>
    </div>

    <script>
        document.getElementById('passwordUpdateForm').addEventListener('submit', function (event) {
            event.preventDefault();

            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            let errorMessage = '';

            if (!currentPassword || !newPassword || !confirmPassword) {
                errorMessage = 'すべての欄を入力してください。';
            } else if (newPassword.length < 8) {
                errorMessage = '新しいパスワードは8文字以上にしてください。';
            } else if (newPassword !== confirmPassword) {
                errorMessage = '新しいパスワードが一致しません。';
            }

            const errorElement = document.getElementById('errorMessage');
            if (errorMessage) {
                errorElement.style.display = 'block';
                errorElement.textContent = errorMessage;
            } else {
                errorElement.style.display = 'none';
                alert('パスワードが更新されました！');
                document.getElementById('passwordUpdateForm').reset();
            }
        });
    </script>

</body>

</html>
?