<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>休暇希望日提出</title>
    <link rel="stylesheet" href="Vacation_Desired_Date.css">
</head>
<body>
<c:import url="base.jsp">
<c:param name="title"></c:param>
<c:param name="scripts"></c:param>
<c:param name="content">
<section class="me-4">
    <div class="container">
        <h1>😊休暇希望日提出😊</h1>

        <label for="off-date">休暇希望日を選択してください:</label>
        <input type="date" id="off-date" required>

        <button id="add-off-day">休暇日を追加</button>

        <table id="off-day-table">
            <thead>
                <tr>
                    <th>休暇希望日</th>
                    <th>削除</th>
                </tr>
            </thead>
            <tbody id="off-day-list"></tbody>
        </table>

        <button id="submit-off-days">休暇希望を送信</button>

        <div id="result"></div>
    </div>

    <script>
        const offDayList = [];
        const offDayListElement = document.getElementById('off-day-list');

        document.getElementById('add-off-day').addEventListener('click', function () {
            const offDate = document.getElementById('off-date').value;
            if (offDate) {
                if (!offDayList.includes(offDate)) {
                    offDayList.push(offDate);
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${offDate}</td>
                        <td><button class="delete-btn">削除</button></td>
                    `;
                    offDayListElement.appendChild(row);

                    row.querySelector('.delete-btn').addEventListener('click', function () {
                        const index = Array.from(offDayListElement.children).indexOf(row);
                        offDayList.splice(index, 1);
                        offDayListElement.removeChild(row);
                    });

                    document.getElementById('off-date').value = '';
                } else {
                    alert('この日はすでに追加されています。');
                }
            } else {
                alert('日付を選択してください。');
            }
        });

        document.getElementById('submit-off-days').addEventListener('click', function () {
            if (offDayList.length > 0) {
                const resultText = offDayList.map(date => `休暇希望日: ${date}`).join('\n');
                document.getElementById('result').innerText = `送信した休暇日:\n${resultText}`;
            } else {
                document.getElementById('result').innerText = '休暇希望日が選択されていません。';
            }
        });
    </script>
</section>
</c:param>
</c:import>
</body>
</html>