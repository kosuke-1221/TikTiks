document.addEventListener('DOMContentLoaded', function () {
    // 休暇日と理由を保存する配列
    const offDayList = [];

    // 一覧を表示するためのDOM要素
    const offDayListElement = document.getElementById('off-day-list');
    // 休暇日入力フィールド
    const offDateInput = document.getElementById('off-date');
    // 理由入力フィールド
    const reasonInput = document.getElementById('reason');
    // 休暇日追加ボタン
    const addOffDayButton = document.getElementById('add-off-day');

    // 休暇日を追加する処理
    addOffDayButton.addEventListener('click', function () {
        // 入力された休暇日と理由を取得
        const offDate = offDateInput.value;
        const reason = reasonInput.value.trim();

        // 休暇日が選択されているか確認
        if (offDate) {
            // 同じ日付がすでに追加されていないか確認
            if (!offDayList.some(entry => entry.date === offDate)) {
                // 休暇日と理由をリストに追加
                offDayList.push({ date: offDate, reason: reason || "理由なし" });

                // 一覧に新しい行を追加
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${offDate}</td>
                    <td>${reason || "理由なし"}</td>
                    <td><button class="delete-btn">削除</button></td>
                `;
                offDayListElement.appendChild(row);

                // 削除ボタンをクリックした時の処理
                row.querySelector('.delete-btn').addEventListener('click', function () {
                    // クリックされた行をリストから削除
                    const index = Array.from(offDayListElement.children).indexOf(row);
                    offDayList.splice(index, 1);  // 配列から削除
                    offDayListElement.removeChild(row);  // DOMから削除
                });

                // 入力フィールドをリセット
                offDateInput.value = '';
                reasonInput.value = '';
            } else {
                // 同じ日付がすでに追加されている場合のエラーメッセージ
                alert('この日はすでに追加されています。');
            }
        } else {
            // 休暇日が選択されていない場合のエラーメッセージ
            alert('日付を選択してください。');
        }
    });

    // フォーム送信前に休暇日をhiddenフィールドに追加
    document.getElementById('submit-off-days').addEventListener('click', function () {
        // リストが空の場合は送信しない
        if (offDayList.length === 0) {
            alert('休暇希望日が選択されていません。');
            return false;  // 送信を止める
        }

        // リストの休暇日と理由をそれぞれhiddenフィールドにセット
        const vacationDates = offDayList.map(entry => entry.date);
        const vacationReasons = offDayList.map(entry => entry.reason);

        // hiddenフィールドにセット
        document.getElementById('vacation-dates').value = vacationDates.join(',');
        document.getElementById('vacation-reasons').value = vacationReasons.join(',');

        // フォームを送信
        return true;
    });
});
