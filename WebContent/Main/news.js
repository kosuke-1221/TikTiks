document.addEventListener("DOMContentLoaded", function () {
    // お知らせ追加フォームのサブミットイベントリスナー
    const notificationForm = document.getElementById('notificationForm');

    if (notificationForm) {
        notificationForm.addEventListener('submit', function (event) {
            event.preventDefault();

            const title = document.getElementById('notificationTitle').value;
            const message = document.getElementById('notificationMessage').value;
            const date = new Date().toLocaleString(); // 現在の日付と時刻

            if (title && message) {
                addNotification(title, message, date);
                notificationForm.reset();
            }
        });
    }
});

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

if ('serviceWorker' in navigator && 'PushManager' in window) {
    navigator.serviceWorker.register('service-worker.js')
        .then(swReg => {
            console.log('Service Worker Registered', swReg);
            return swReg.pushManager.subscribe({
                userVisibleOnly: true,
                applicationServerKey: 'YOUR_PUBLIC_VAPID_KEY'
            });
        })
        .then(subscription => {
            return fetch('/subscribe', {
                method: 'POST',
                body: JSON.stringify(subscription),
                headers: { 'Content-Type': 'application/json' }
            });
        })
        .catch(error => console.error('Push Subscription Error', error));
}

