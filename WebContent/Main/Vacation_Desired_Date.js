document.addEventListener('DOMContentLoaded', function () {
    const offDayList = [];
    const offDayListElement = document.getElementById('off-day-list');
    const offDateInput = document.getElementById('off-date');

    // 休暇日を追加する
    document.getElementById('add-off-day').addEventListener('click', function () {
        const offDate = offDateInput.value;
        if (offDate) {
            if (!offDayList.includes(offDate)) {
                offDayList.push(offDate);
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${offDate}</td>
                    <td><button class="delete-btn">削除</button></td>
                `;
                offDayListElement.appendChild(row);

                // 削除ボタンをクリックした時の処理
                row.querySelector('.delete-btn').addEventListener('click', function () {
                    const index = Array.from(offDayListElement.children).indexOf(row);
                    offDayList.splice(index, 1);
                    offDayListElement.removeChild(row);
                });

                // 入力フィールドをリセット
                offDateInput.value = '';
            } else {
                alert('この日はすでに追加されています。');
            }
        } else {
            alert('日付を選択してください。');
        }
    });

    // 休暇希望日を送信する
    document.getElementById('submit-off-days').addEventListener('click', function () {
        if (offDayList.length > 0) {
            const resultText = offDayList.map(date => `休暇希望日: ${date}`).join('\n');
            document.getElementById('result').innerText = `送信した休暇日:\n${resultText}`;
        } else {
            document.getElementById('result').innerText = '休暇希望日が選択されていません。';
        }
    });
});
