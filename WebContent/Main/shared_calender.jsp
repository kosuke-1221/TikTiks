<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, java.util.HashMap, java.util.Map, java.util.Arrays, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>共有カレンダー</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f9f9f9;
        }

        h1 {
            text-align: center;
        }

        .calendar-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }

        .calendar-wrapper {
            display: flex;
            justify-content: space-between;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th,
        td {
            border: 1px solid #ccc;
            text-align: center;
            padding: 10px;
            cursor: pointer;
            background-color: #fff;
        }

        th {
            background-color: #eaeaea;
        }

        td:hover {
            background-color: #f0f8ff;
        }

        .saturday {
            background-color: #add8e6;
        }

        .sunday {
            background-color: #ffcccb;
        }

        #workInfo {
            margin-top: 20px;
            padding: 10px;
            background-color: #e0f7fa;
            border: 1px solid #008cba;
            border-radius: 5px;
            font-weight: bold;
        }

        .control-panel {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }

        .worker-list {
            text-align: left;
            line-height: 1.5;
        }

        .worker-name {
            padding: 5px 10px;
            border-radius: 5px;
            margin-bottom: 5px;
            color: #fff;
        }

        .month-display {
            text-align: center;
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .shift-detail {
            text-align: left;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f7f7f7;
            border-radius: 5px;
            margin-top: 20px;
        }
        .selected {
            background-color: yellow;
        }
    </style>
</head>

<body>
    <h1>😁 共有カレンダー😁 </h1>

    <div class="calendar-container">
        <div class="month-display" id="monthDisplay">
            <%
            Calendar cal = Calendar.getInstance();
            int month = (request.getParameter("month") != null) ? Integer.parseInt(request.getParameter("month")) : cal.get(Calendar.MONTH) + 1;
            out.print(month + "月");
            %>
        </div>
    </div>

    <div class="control-panel">
        <form action="" method="get">
            <label for="month">月を選択: </label>
            <select id="month" name="month" onchange="generateCalendar()">
                <option value="10" <%= (month == 10) ? "selected" : "" %>>10月</option>
                <option value="11" <%= (month == 11) ? "selected" : "" %>>11月</option>
                <option value="12" <%= (month == 12) ? "selected" : "" %>>12月</option>
            </select>
        </form>

        <label for="day">日にちを選択: </label>
        <select id="day" onchange="showShiftInfo(this.value)">
            <!-- JavaScriptで日付を生成 -->
        </select>
    </div>

    <div class="calendar-wrapper">
        <table id="calendar">
            <%-- JSPでカレンダーを生成するコードは削除 --%>
        </table>

        <div id="shiftDetail" class="shift-detail">出勤情報: -</div>
    </div>

    <div id="workInfo">選択した日の働く時間: -</div>

    <script>
        // 月ごとの日数を定義
        const daysInMonth = {
            10: 31,
            11: 30,
            12: 31
        };

        // 従業員のデータ（名前と色）
        const workers = {
            "山田太郎": "#FFABCE",
            "鈴木花子": "#CC99CC",
            "田中一郎": "#999999",
            "佐藤二郎": "#FF9933",
            "山本五郎": "#FF8856",
            "佐々木四郎": "#008080"
        };

        // 働く時間と従業員のデータ（サンプルデータ）
        const workSchedule = {
            "2024-10-01": { time: "9:00 - 18:00", workers: ["山田太郎", "鈴木花子"] },
            "2024-10-02": { time: "10:00 - 19:00", workers: ["田中一郎", "佐藤二郎"] },
            "2024-10-03": { time: "9:00 - 17:00", workers: ["山本五郎", "佐々木四郎"] },
            "2024-10-04": { time: "9:00 - 18:00", workers: ["田中一郎", "佐々木四郎"] },
            "2024-10-05": { time: "9:00 - 18:00", workers: ["山田太郎", "鈴木花子"] },
            "2024-10-06": { time: "10:00 - 19:00", workers: ["田中一郎", "山田太郎"] },
            "2024-10-07": { time: "9:00 - 17:00", workers: ["佐藤二郎", "山本五郎"] },
            "2024-10-08": { time: "9:00 - 18:00", workers: ["山田太郎", "鈴木花子", "佐々木四郎"] },
            "2024-10-09": { time: "10:00 - 19:00", workers: ["田中一郎", "山本五郎"] },
            "2024-10-10": { time: "9:00 - 17:00", workers: ["佐藤二郎", "山本五郎"] },
            "2024-10-11": { time: "9:00 - 18:00", workers: ["鈴木花子", "佐藤二郎"] },
            "2024-10-12": { time: "9:00 - 17:00", workers: ["田中一郎", "山本五郎"] },
            "2024-10-13": { time: "10:00 - 19:00", workers: ["佐々木四郎", "鈴木花子"] },
            "2024-10-14": { time: "9:00 - 18:00", workers: ["山田太郎", "田中一郎"] },
            "2024-10-15": { time: "10:00 - 19:00", workers: ["鈴木花子", "佐藤二郎"] },
            "2024-10-16": { time: "9:00 - 17:00", workers: ["山本五郎", "佐々木四郎"] },
            "2024-10-17": { time: "休み", workers: [] },
            "2024-10-18": { time: "9:00 - 18:00", workers: ["田中一郎", "佐々木四郎"] },
            "2024-10-19": { time: "10:00 - 19:00", workers: ["山田太郎", "鈴木花子"] },
            "2024-10-20": { time: "9:00 - 17:00", workers: ["佐藤二郎", "山本五郎"] },
            "2024-10-21": { time: "9:00 - 18:00", workers: ["山田太郎", "山本五郎"] },
            "2024-10-22": { time: "10:00 - 19:00", workers: ["田中一郎", "佐々木四郎"] },
            "2024-10-23": { time: "9:00 - 17:00", workers: ["鈴木花子", "山本五郎"] },
            "2024-10-24": { time: "10:00 - 19:00", workers: ["佐藤二郎", "山本五郎"] },
            "2024-10-25": { time: "9:00 - 18:00", workers: ["山田太郎", "佐藤二郎"] },
            "2024-10-26": { time: "10:00 - 19:00", workers: ["田中一郎", "佐々木四郎"] },
            "2024-10-27": { time: "9:00 - 17:00", workers: ["山本五郎", "佐藤二郎"] },
            "2024-10-28": { time: "9:00 - 18:00", workers: ["鈴木花子", "佐藤二郎"] },
            "2024-10-29": { time: "10:00 - 19:00", workers: ["山田太郎", "鈴木花子"] },
            "2024-10-30": { time: "9:00 - 17:00", workers: ["田中一郎", "山本五郎"] },
            "2024-10-31": { time: "9:00 - 18:00", workers: ["田中一郎", "佐々木四郎"] },
        };

        // カレンダーを生成する関数
        function generateCalendar() {
            const month = document.getElementById("month").value;
            document.getElementById("monthDisplay").innerText = `${month}月`; // 選択した月を表示

            const calendar = document.getElementById("calendar");
            calendar.innerHTML = ""; // カレンダーをクリア

            const firstDay = new Date(2024, month - 1, 1).getDay(); // 月の最初の曜日
            const days = daysInMonth[month]; // 選択された月の日数

            // ヘッダー行（曜日）を生成
            const daysOfWeek = ["日", "月", "火", "水", "木", "金", "土"];
            const headerRow = document.createElement("tr");
            for (let day of daysOfWeek) {
                const th = document.createElement("th");
                th.innerText = day;
                headerRow.appendChild(th);
            }
            calendar.appendChild(headerRow);

            // 日付行を生成
            let row = document.createElement("tr");
            // 最初の行の空白を埋める
            for (let i = 0; i < firstDay; i++) {
                const emptyCell = document.createElement("td");
                row.appendChild(emptyCell);
            }

            for (let date = 1; date <= days; date++) {
                if ((firstDay + date - 1) % 7 === 0) {
                    calendar.appendChild(row); // 行を追加
                    row = document.createElement("tr");
                }
                const cell = document.createElement("td");
                cell.innerText = date;

                const dateString = '2024-' + (month < 10 ? '0' + month : month) + '-' + (date < 10 ? '0' + date : date);
                const workerList = document.createElement("div");
                workerList.classList.add("worker-list");
                workerList.id = `workers-${dateString}`;
                cell.appendChild(workerList);

                cell.onclick = function () {
                    showShiftInfo(dateString);
                };

                // 土日の背景色を設定
                if (new Date(2024, month - 1, date).getDay() === 0) {
                    cell.classList.add("sunday");
                } else if (new Date(2024, month - 1, date).getDay() === 6) {
                    cell.classList.add("saturday");
                }

                row.appendChild(cell);
            }

            calendar.appendChild(row); // 最後の行を追加
            updateDaySelect(); // 日にちの選択肢を更新
            populateCalendar(); // カレンダーに従業員情報を表示
        }

        // 出勤情報を表示する関数
        function showShiftInfo(selectedDate) {
            const workInfo = workSchedule[selectedDate];
            const workInfoDisplay = document.getElementById("workInfo");
            if (workInfo) {
                workInfoDisplay.innerText = `${selectedDate} の働く時間: ${workInfo.time}`;
                const shiftDetail = document.getElementById("shiftDetail");
                shiftDetail.innerHTML = `選択した日の詳細: ${workInfo.time}<br>出勤者: ${workInfo.workers.join(", ") || "なし"}`;
            } else {
                workInfoDisplay.innerText = "データなし";
                const shiftDetail = document.getElementById("shiftDetail");
                shiftDetail.innerHTML = "選択した日の詳細: -<br>出勤者: -";
            }

            // 選択された日付のセルをハイライト
            const allCells = document.querySelectorAll('td');
            allCells.forEach(cell => cell.classList.remove('selected'));
            const selectedCell = document.querySelector(`td[onclick*="${selectedDate}"]`);
            if (selectedCell) {
                selectedCell.classList.add('selected');
            }
        }

        // 日にちの選択肢を更新する関数
        function updateDaySelect() {
            const month = document.getElementById("month").value;
            const daySelect = document.getElementById("day");
            daySelect.innerHTML = ""; // 選択肢をクリア

            const days = daysInMonth[month]; // 選択された月の日数
            for (let date = 1; date <= days; date++) {
                const option = document.createElement("option");
                option.value = '2024-' + (month < 10 ? '0' + month : month) + '-' + (date < 10 ? '0' + date : date);
                option.innerText = date;
                daySelect.appendChild(option);
            }
        }

        function populateCalendar() {
            for (const [date, info] of Object.entries(workSchedule)) {
                const cell = document.getElementById(`workers-${date}`);
                if (cell) {
                    cell.innerHTML = '';
                    info.workers.forEach(worker => {
                        const workerName = document.createElement("div");
                        workerName.classList.add("worker-name");
                        workerName.innerText = worker;
                        workerName.style.backgroundColor = workers[worker];
                        cell.appendChild(workerName);
                    });
                }
            }
        }

        // 初期表示
        window.onload = function () {
            generateCalendar();
        };
    </script>
</body>

</html>

