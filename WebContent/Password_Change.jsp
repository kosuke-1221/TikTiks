<% String prevCurrent=(String) session.getAttribute("prevCurrentPassword"); String prevNew=(String)
    session.getAttribute("prevNewPassword"); String prevConfirm=(String) session.getAttribute("prevConfirmPassword"); %>
    <!-- ...既存のHTMLヘッダー等... -->
    <form action="Password_ChangeAction" method="post">
        <label>現在のパスワード:</label>
        <input type="password" name="currentPassword" value="<%= prevCurrent != null ? prevCurrent : "" %>" />
        <br>
        <label>新しいパスワード:</label>
        <input type="password" name="newPassword" value="<%= prevNew != null ? prevNew : "" %>" />
        <br>
        <label>新しいパスワード（確認）:</label>
        <input type="password" name="confirmPassword" value="<%= prevConfirm != null ? prevConfirm : "" %>" />
        <br>
        <button type="submit">変更</button>
    </form>
    <!-- ...既存のHTMLフッター等... -->