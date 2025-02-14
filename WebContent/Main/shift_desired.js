// 曜日ごとのチェックボックスと時間選択の連携
function toggleSelect(day) {
    // 指定された曜日のチェックボックス、開始時間、終了時間の要素を取得
    const checkbox = document.getElementById(day);
    const startSelect = document.getElementById(`${day}-start`);
    const endSelect = document.getElementById(`${day}-end`);
    const alwaysAvailable = document.getElementById('always-available'); // いつでも可のチェックボックス

    // チェックボックスが選択されている場合、時間選択を有効にする
    if (checkbox && checkbox.checked) {
        startSelect.disabled = false;
        endSelect.disabled = false;
        // いつでも可が選択されていない場合にのみ必須とする
        startSelect.required = !alwaysAvailable.checked;
        endSelect.required = !alwaysAvailable.checked;
    } else {
        // チェックボックスが選択されていない場合、時間選択を無効にする
        startSelect.disabled = true;
        endSelect.disabled = true;
        startSelect.required = false;
        endSelect.required = false;
        startSelect.value = "";  // 開始時間をリセット
        endSelect.value = "";    // 終了時間をリセット
    }
}



// 各曜日のチェックボックスにイベントリスナーを追加
document.addEventListener('DOMContentLoaded', function () {
    const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday', 'holiday'];

    // 各曜日に対して初期状態を設定
    days.forEach(day => {
        const checkbox = document.getElementById(day);
        if (checkbox) {
            toggleSelect(day); // ページ読み込み時に初期状態を設定
            checkbox.addEventListener('change', function () {
                toggleSelect(day); // チェックボックスの変更時に連携を更新
            });
        }
    });

    // いつでも可が選択されたとき、他の曜日の必須設定を調整
    const alwaysAvailable = document.getElementById('always-available');
    if (alwaysAvailable) {
        alwaysAvailable.addEventListener('change', function () {
            days.forEach(day => toggleSelect(day)); // 曜日ごとの必須設定を更新
        });
    }
});




// フォーム送信時にバリデーション
document.getElementById('shiftForm').addEventListener('submit', function (event) {
    const errorContainer = document.getElementById('error-messages');
    if (errorContainer) {
        errorContainer.style.display = 'none'; // エラーメッセージをクリア
        errorContainer.textContent = '';
    }

    // フォームが無効な場合、送信を防ぐ
    if (!validateForm()) {
        event.preventDefault(); // フォーム送信を防ぐ
    }
});



// フォームバリデーション
function validateForm() {
    // 曜日ごとの設定
    const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday', 'holiday'];
    const alwaysAvailable = document.getElementById('always-available'); // いつでも可のチェックボックス

    // 日本語の曜日名をマッピング
    const dayNames = {
        'monday': '月曜',
        'tuesday': '火曜',
        'wednesday': '水曜',
        'thursday': '木曜',
        'friday': '金曜',
        'saturday': '土曜',
        'sunday': '日曜',
        'holiday': '祝'
    };

    let errorMessages = '';  // エラーメッセージの初期化
    let hasError = false;    // エラーがあるかどうかのフラグ
    let isAnyCheckboxChecked = false; // チェックボックスが選択されているかを確認するフラグ

    // 「いつでも可」が選択されている場合、他の曜日を無視して送信可能にする
    if (alwaysAvailable && alwaysAvailable.checked) {
        return true; // バリデーション成功
    }

    // 各曜日ごとのチェック
    days.forEach(day => {
        const checkbox = document.getElementById(day);
        const startSelect = document.getElementById(`${day}-start`);
        const endSelect = document.getElementById(`${day}-end`);
        const dayName = dayNames[day]; // 日本語の曜日名を取得

        // チェックボックスが選択されている場合
        if (checkbox && checkbox.checked) {
            isAnyCheckboxChecked = true; // チェックボックスが1つでも選択されていればフラグを立てる

            // 開始時間と終了時間の入力チェック
            if (!startSelect.value || !endSelect.value) {
                if (!errorMessages.includes(`${dayName}日の開始時間と終了時間を選択してください。`)) {
                    errorMessages += `${dayName}日の開始時間と終了時間を選択してください。\n`; // エラーメッセージを追加
                    hasError = true;  // エラーフラグを立てる
                }
            } else {
                const startTime = parseInt(startSelect.value, 10); // 数値に変換
                const endTime = parseInt(endSelect.value, 10);   // 数値に変換

                // 開始時間が終了時間より遅くないか確認
                if (startTime >= endTime) {
                    if (!errorMessages.includes(`${dayName}日の開始時間は終了時間より早くしてください。`)) {
                        errorMessages += `${dayName}日の開始時間は終了時間より早くしてください。\n`; // エラーメッセージを追加
                        hasError = true; // エラーフラグを立てる
                    }
                }
            }
        }
    });

    // チェックボックスが1つも選択されていない場合にエラーを表示
    if (!isAnyCheckboxChecked) {
        errorMessages += 'シフト希望日を1つ以上選択してください\n';  // エラーメッセージを追加
        hasError = true;  // エラーフラグを立てる
    }

    // エラーメッセージがある場合、表示する
    if (hasError) {
        displayErrorMessages(errorMessages);  // エラーメッセージを表示
        return false; // フォーム送信を防ぐ
    }

    return true; // フォーム送信を許可
}




// エラーメッセージをページ上に表示
function displayErrorMessages(messages) {
    const errorContainer = document.getElementById('error-messages');
    if (errorContainer) {
        errorContainer.innerHTML = messages.replace(/\n/g, '<br>'); // 改行を <br> に変換して表示
        errorContainer.style.display = 'block'; // エラーメッセージを表示
    } else {
        console.error('エラーメッセージのコンテナが見つかりません');
    }
}

// ...existing code...

// エラーメッセージをページ上に表示
function displayErrorMessages(messages) {
    const errorContainer = document.getElementById('error-messages');
    if (errorContainer) {
        errorContainer.innerHTML = messages.replace(/\n/g, '<br>'); // 改行を <br> に変換して表示
        errorContainer.style.display = 'block'; // エラーメッセージを表示
    } else {
        console.error('エラーメッセージのコンテナが見つかりません');
    }
}

// ページ読み込み時に送信ボタンの無効化状態を復元
document.addEventListener('DOMContentLoaded', function () {
    restoreSubmitButtonState();

    // フォームの送信イベントにリスナーを追加
    const form = document.querySelector('form');
    if (form) {
        form.addEventListener('submit', function (event) {
        });
    }
    // ...existing code...
});