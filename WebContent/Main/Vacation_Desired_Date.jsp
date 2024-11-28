<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>休暇希望日提出</title>
    <link rel="stylesheet" href="Vacation_Desired_Date.css">
</head>
<body>
    <!-- ヘッダーの共通部分をインクルード -->
    <jsp:include page="base.jsp" />

    <section class="me-4">
        <div class="container">
            <h1>😊休暇希望日提出😊</h1>

            <label for="off-date">休暇希望日を選択してください:</label>
            <input type="date" id="off-date" required>

            <label for="reason">理由を記載してください:</label>
            <textarea id="reason" rows="3" placeholder="休暇の理由を記載してください"></textarea>

            <button id="add-off-day">休暇日を追加</button>

            <table id="off-day-table">
                <thead>
                    <tr>
                        <th>休暇希望日</th>
                        <th>理由</th>
                        <th>削除</th>
                    </tr>
                </thead>
                <tbody id="off-day-list"></tbody>
            </table>

            <button id="submit-off-days">休暇希望を送信</button>

            <div id="result"></div>
        </div>

        <!-- JavaScriptファイルを読み込み -->
        <script src="Vacation_Desired_Date.js"></script>
    </section>
</body>
</html>
