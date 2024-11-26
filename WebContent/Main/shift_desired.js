// 曜日ごとのチェックボックスと時間選択の連携
function toggleSelect(day) {
    const checkbox = document.getElementById(day);
    const startSelect = document.getElementById(`${day}-start`);
    const endSelect = document.getElementById(`${day}-end`);

    if (checkbox && checkbox.checked) {
        startSelect.disabled = false;
        endSelect.disabled = false;
        startSelect.required = true;
        endSelect.required = true;
    } else {
        startSelect.disabled = true;
        endSelect.disabled = true;
        startSelect.required = false;
        endSelect.required = false;
        startSelect.value = "";
        endSelect.value = "";
    }
}

// 各曜日のチェックボックスにイベントリスナーを追加
document.addEventListener('DOMContentLoaded', function () {
    const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday', 'holiday'];

    days.forEach(day => {
        const checkbox = document.getElementById(day);

        if (checkbox) {
            // ページ読み込み時に初期状態を設定
            toggleSelect(day);

            // チェックボックスの変更時に toggleSelect を呼び出す
            checkbox.addEventListener('change', function () {
                toggleSelect(day);
            });
        }
    });
});

// フォーム送信時にバリデーション
document.getElementById('shiftForm').addEventListener('submit', function(event) {
    const errorContainer = document.getElementById('error-messages');
    if (errorContainer) {
        errorContainer.style.display = 'none'; // エラーメッセージをクリア
        errorContainer.textContent = '';
    }

    if (!validateForm()) {
        event.preventDefault(); // フォーム送信を防ぐ
    }
});

function validateForm() {
    const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday', 'holiday'];

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
    let errorMessages = '';
    let hasError = false;

    // 各曜日ごとのチェック
    days.forEach(day => {
        const checkbox = document.getElementById(day);
        const startSelect = document.getElementById(`${day}-start`);
        const endSelect = document.getElementById(`${day}-end`);
        const freeInput = document.getElementById(`${day}-free`);
        const dayName = dayNames[day]; // 日本語の曜日名を取得


        // チェックボックスが選択されている場合
        if (checkbox && checkbox.checked) {
            // 開始時間と終了時間の入力チェック
            if (!startSelect.value || !endSelect.value) {
                if (!errorMessages.includes(`${dayName}日の開始時間と終了時間を選択してください。`)) {
                    errorMessages += `${dayName}日の開始時間と終了時間を選択してください。\n`;
                    hasError = true;
                }
            }
            // 開始時間が終了時間より遅くないか確認
            if (startSelect.value && endSelect.value && startSelect.value >= endSelect.value) {
                if (!errorMessages.includes(`${dayName}日の開始時間は終了時間より早くしてください。`)) {
                    errorMessages += `${dayName}日の開始時間は終了時間より早くしてください。\n`;
                    hasError = true;
                }
            }
        } else {
            // チェックボックスが選択されていない場合、自由入力欄も未入力ならエラー
            if (!freeInput || !freeInput.value) {
                if (!errorMessages.includes(`シフト希望日を1つ以上選択してください`)) {
                    errorMessages += `シフト希望日を1つ以上選択してください\n`;
                    hasError = true;
                }
            }
        }
    });

    // エラーメッセージがある場合、表示する
    if (hasError) {
        displayErrorMessages(errorMessages);
        return false; // フォーム送信を防ぐ
    }

    return true; // フォーム送信を許可
}


// エラーメッセージをページ上に表示
function displayErrorMessages(messages) {
    const errorContainer = document.getElementById('error-messages');
    if (errorContainer) {
        errorContainer.innerHTML = messages.replace(/\n/g, '<br>'); // 改行を <br> に変換
        errorContainer.style.display = 'block'; // エラーメッセージを表示
    } else {
        console.error('エラーメッセージのコンテナが見つかりません');
    }
}
