<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>パスワード更新</title>

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