<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>にこにこシフトマジック</title>
<link href="news.css" rel="stylesheet" />
</head>

<body>
<c:import url="base.jsp">
<c:param name="title"></c:param>
<c:param name="content">
<section class="me-4">
    <div class="notification-container">
        <h2>お知らせ</h2>

        <!-- お知らせ追加フォーム（管理者のみ表示） -->
        <div id="adminSection" style="display: none;">
            <form id="notificationForm">
                <input type="text" id="notificationTitle" placeholder="お知らせタイトル" required>
                <textarea id="notificationMessage" placeholder="お知らせ内容" required></textarea>
                <button type="submit">お知らせを追加</button>
            </form>
        </div>

        <!-- お知らせリスト -->
        <div id="notificationList"></div>
    </div>

    <script>
    const isAdmin = true; // 管理者かどうかを示すフラグ

    window.onload = function () {
        if (isAdmin) {
            document.getElementById('adminSection').style.display = 'block';
        }

        document.getElementById('notificationForm').addEventListener('submit', function (event) {
            event.preventDefault();

            const title = document.getElementById('notificationTitle').value;
            const message = document.getElementById('notificationMessage').value;
            const date = new Date().toLocaleString(); // 現在の日付と時刻

            if (title && message) {
                addNotification(title, message, date);
                document.getElementById('notificationForm').reset();
            }
        });
    }

    function addNotification(title, message, date) {
        const notificationList = document.getElementById('notificationList');

        const notification = document.createElement('div');
        notification.classList.add('notification');

        const notificationHeader = document.createElement('div');
        notificationHeader.classList.add('notification-header');
        notificationHeader.textContent = title;
        notificationHeader.onclick = function () {
            const details = notification.querySelector('.notification-details');
            details.style.display = details.style.display === 'block' ? 'none' : 'block';
        };

        const notificationDetails = document.createElement('div');
        notificationDetails.classList.add('notification-details');
        notificationDetails.innerHTML = `
            <p>${message}</p>
            <div class="date-log">投稿日: ${date}</div>
            <div class="comment-section">
                <h4>コメント</h4>
                <div class="comment-list"></div>
                <div class="comment-input">
                    <input type="text" placeholder="コメントを入力..." />
                    <button onclick="addComment(this)">送信</button>
                </div>
            </div>
        `;

        notification.appendChild(notificationHeader);
        notification.appendChild(notificationDetails);
        notificationList.appendChild(notification);
    }

    function addComment(button) {
        const commentInput = button.previousElementSibling;
        const commentText = commentInput.value.trim();
        if (commentText) {
            const commentList = button.closest('.comment-section').querySelector('.comment-list');
            const comment = document.createElement('div');
            comment.classList.add('comment-item');

            // 現在の日付と時刻を取得し、"ゲスト"として投稿
            const date = new Date().toLocaleString();
            const userName = "ゲスト"; // 仮のユーザー名

            comment.innerHTML = `
                <strong>${userName}</strong> (${date})
                <p>${commentText}</p>
            `;

            commentList.appendChild(comment);
            commentInput.value = ''; // 入力欄をクリア
        }
    }


    </script>

</section>
</c:param>
</c:import>
</body>