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

            // サーバーから公開鍵を取得して、base64url形式に変換
            fetch('/get-public-key')  // サーバー側で公開鍵を取得するエンドポイントを作成
                .then(response => response.text())
                .then(publicKey => {
                    // Base64形式の公開鍵をBase64URL形式に変換
                    const applicationServerKey = base64UrlEncode(publicKey);

                    // PushManagerで購読を開始
                    return swReg.pushManager.subscribe({
                        userVisibleOnly: true,
                        applicationServerKey: base64UrlToUint8Array(applicationServerKey)
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
        })
        .catch(error => console.error('Service Worker Registration Error', error));
}

// Base64URL形式に変換する関数
function base64UrlEncode(input) {
    // Base64 -> Base64URL (パディング、+、/を変換)
    return input.replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');  // パディング（=）を削除
}

function base64UrlToUint8Array(base64Url) {
    let base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');  // constをletに変更

    // Base64文字列の長さが4の倍数になるようにパディング（'='）を追加
    const padding = base64.length % 4;
    if (padding) {
        base64 += '='.repeat(4 - padding);
    }

    // Base64文字列をデコードしてUint8Arrayに変換
    const binary = atob(base64);
    const uint8Array = new Uint8Array(binary.length);
    for (let i = 0; i < binary.length; i++) {
        uint8Array[i] = binary.charCodeAt(i);
    }
    return uint8Array;
}
