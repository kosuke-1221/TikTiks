<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>😁 シフト登録 😁</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }

        h1 {
            text-align: center;
        }

        .container {
            display: flex;
        }

        .sidebar {
            flex: 1;
            margin-right: 20px;
        }

        .month {
            margin: 20px 0;
            border: 1px solid #ccc;
            padding: 10px;
            background-color: #fff;
            text-align: center;
        }

        .calendar {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 10px;
        }

        .day {
            border: 1px solid #ccc;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            background-color: #fff;
            transition: background-color 0.3s;
        }

        .day:hover {
            background-color: #e0f7fa;
        }

        button {
            display: block;
            margin: 10px auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .hidden {
            display: none;
        }

        .message {
            text-align: center;
            margin: 20px 0;
        }

        .employee-list {
            margin: 10px 0;
        }

        .employee-item {
            margin: 5px 0;
            cursor: pointer;
            padding: 5px;
            background-color: #e9ecef;
            transition: background-color 0.3s;
        }

        .employee-item:hover {
            background-color: #adb5bd;
        }

        .selected-date {
            margin-left: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #fff;
        }

        .selected-info {
            margin-top: 10px;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ccc;
        }

        .text-area {
            width: 100%;
            height: 100px;
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #fff;
        }

        .month-navigation {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 10px 0;
        }

        .month-navigation button {
            padding: 5px 10px;
        }

        .shift-display {
            margin-top: 20px;
        }

        select {
            width: 100%;
            padding: 5px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <h1>😁 シフト登録 😁</h1>

    <div class="container">
        <div class="sidebar">
            <div class="message" id="selectedDayMessage">日付を選択してください。</div>

            <div class="employee-list" id="employeeListContainer">
                <h3>従業員一覧</h3>
                <!-- 従業員リストがここに表示されます -->
            </div>

            <input type="text" id="employeeNameInput" placeholder="従業員名を入力" />
            <button onclick="registerEmployee()">登録</button>

            <select id="shiftContentSelect" class="hidden">
                <option value="">シフト内容を選択</option>
                <option value="業務内容A">業務内容A</option>
                <option value="業務内容B">業務内容B</option>
                <option value="業務内容C">業務内容C</option>
                <option value="業務内容D">業務内容D</option>
            </select>

            <button id="registerButton" class="hidden" onclick="registerShift()">シフトを登録</button>

            <div class="shift-display" id="shiftDisplay"></div>
        </div>

        <div class="calendar-area">
            <div class="month-navigation">
                <button onclick="changeMonth(-1)">&lt;</button>
                <div id="calendarContainer"></div>
                <button onclick="changeMonth(1)">&gt;</button>
            </div>
        </div>

        <div class="selected-info">
            <h3>選択中の情報</h3>
            <div id="selectedDateDisplay">希望日時: なし</div>
            <div>
                <select id="timeSelect" onchange="showShiftContentSelect()">
                    <option value="">時間を選択</option>
                    <option value="09:00">09:00</option>
                    <option value="10:00">10:00</option>
                    <option value="11:00">11:00</option>
                    <option value="12:00">12:00</option>
                    <option value="13:00">13:00</option>
                    <option value="14:00">14:00</option>
                    <option value="15:00">15:00</option>
                    <option value="16:00">16:00</option>
                    <option value="17:00">17:00</option>
                    <option value="18:00">18:00</option>
                    <option value="19:00">19:00</option>
                    <option value="20:00">20:00</option>
                </select>
            </div>
            <div id="selectedTimeDisplay" class="hidden">希望時間: <span id="selectedTimeValue"></span></div>
            <textarea id="freeText" class="text-area" placeholder="自由欄 (例: 特別な希望やメモを記入)"></textarea>
        </div>
    </div>

    <script>
        let selectedDate = '';
        let selectedEmployee = '';
        let selectedTime = '';
        let selectedShiftContent = '';
        let currentYear = 2024;
        let currentMonth = 1; // 1月から開始
        let employeeList = []; // 従業員リスト
        let shiftData = {}; // シフトデータ

        // ページ読み込み時にlocalStorageからシフトデータを取得
        window.onload = function () {
            loadShiftData();
            generateCalendar(currentYear, currentMonth);
            updateEmployeeList(); // 従業員リストを初期化
        };

        // シフトデータをlocalStorageに保存する関数
        function saveShiftData() {
            localStorage.setItem('shiftData', JSON.stringify(shiftData));
        }

        // シフトデータをlocalStorageから読み込む関数
        function loadShiftData() {
            var storedShiftData = localStorage.getItem('shiftData');
            if (storedShiftData) {
                shiftData = JSON.parse(storedShiftData);
            }
        }

        // 従業員登録関数
        function registerEmployee() {
            var employeeName = document.getElementById('employeeNameInput').value;

            if (employeeName) {
                employeeList.push(employeeName);
                document.getElementById('employeeNameInput').value = ''; // 入力欄をクリア
                updateEmployeeList(); // リストを更新
                alert(employeeName + ' さんが登録されました。');
            } else {
                alert('従業員名を入力してください。');
            }
        }

        // 従業員リストを更新して画面に表示
        function updateEmployeeList() {
            var employeeListContainer = document.getElementById('employeeListContainer');
            employeeListContainer.innerHTML = ''; // 既存リストをクリア

            if (employeeList.length > 0) {
                employeeList.forEach(function(employee) {
                    var employeeDiv = document.createElement('div');
                    employeeDiv.className = 'employee-item';
                    employeeDiv.innerText = employee;
                    employeeDiv.onclick = function () { selectEmployee(employee); };
                    employeeListContainer.appendChild(employeeDiv);
                });
            } else {
                var noEmployeeMessage = document.createElement('div');
                noEmployeeMessage.innerText = '登録された従業員はいません。';
                employeeListContainer.appendChild(noEmployeeMessage);
            }
        }

        // 1か月分のカレンダーを生成
        function generateCalendar(year, month) {
            var calendarContainer = document.getElementById('calendarContainer');
            calendarContainer.innerHTML = ''; // 既存のカレンダーをクリア

            var monthDiv = document.createElement('div');
            monthDiv.className = 'month';
            monthDiv.innerHTML = '<h2>' + year + '年 ' + month + '月</h2>';
            var calendar = document.createElement('div');
            calendar.className = 'calendar';

            var daysInMonth = new Date(year, month, 0).getDate(); // 月の最終日を取得

            for (var day = 1; day <= daysInMonth; day++) {
                var dayDiv = document.createElement('div');
                dayDiv.className = 'day';
                dayDiv.innerText = day;
                var formattedDate = year + '-' + (month < 10 ? '0' : '') + month + '-' + (day < 10 ? '0' : '') + day;
                dayDiv.onclick = function (date) {
                    return function() {
                        selectDay(date);
                    }
                }(formattedDate);
                calendar.appendChild(dayDiv);
            }

            monthDiv.appendChild(calendar);
            calendarContainer.appendChild(monthDiv);
        }

        function updateSelectedDayMessage() {
            var message = selectedDate ? selectedDate + ' を選択しました。' : '日付を選択してください。';
            document.getElementById('selectedDayMessage').innerText = message;
            document.getElementById('selectedDateDisplay').innerText = '希望日時: ' + (selectedDate || 'なし');
            displayShiftForDate(); // 選択された日に登録されたシフトを表示
        }

        function selectDay(date) {
            selectedDate = date;
            updateSelectedDayMessage(); // 日付メッセージを更新
            showEmployeeList(); // 従業員リストを表示
        }

        // 日付に対応する従業員リストを表示
        function showEmployeeList() {
            var employeeListContainer = document.getElementById('employeeListContainer');
            employeeListContainer.innerHTML = ''; // リストをクリア

            var employeesForDate = shiftData[selectedDate] ? Object.keys(shiftData[selectedDate]) : [];

            if (employeesForDate.length > 0) {
                employeesForDate.forEach(function(employee) {
                    var employeeDiv = document.createElement('div');
                    employeeDiv.className = 'employee-item';
                    employeeDiv.innerText = employee;
                    employeeDiv.onclick = function () { selectEmployee(employee); };
                    employeeListContainer.appendChild(employeeDiv);
                });
            } else {
                var noEmployeeMessage = document.createElement('div');
                noEmployeeMessage.innerText = '該当する従業員はいません。';
                employeeListContainer.appendChild(noEmployeeMessage);
            }
        }

        function selectEmployee(employee) {
            selectedEmployee = employee;
        }

        function showShiftContentSelect() {
            selectedTime = document.getElementById('timeSelect').value;
            var selectedTimeDisplay = document.getElementById('selectedTimeDisplay');
            var selectedTimeValue = document.getElementById('selectedTimeValue');

            if (selectedTime) {
                selectedTimeValue.textContent = selectedTime;
                selectedTimeDisplay.classList.remove('hidden');
                document.getElementById('shiftContentSelect').classList.remove('hidden');
                document.getElementById('registerButton').classList.remove('hidden');
            } else {
                selectedTimeDisplay.classList.add('hidden');
                document.getElementById('shiftContentSelect').classList.add('hidden');
                document.getElementById('registerButton').classList.add('hidden');
            }
        }

        // シフト登録
        function registerShift() {
            selectedShiftContent = document.getElementById('shiftContentSelect').value;
            var freeText = document.getElementById('freeText').value;

            if (selectedEmployee && selectedDate && selectedTime && selectedShiftContent) {
                if (!shiftData[selectedDate]) {
                    shiftData[selectedDate] = {};
                }

                shiftData[selectedDate][selectedEmployee] = {
                    time: selectedTime,
                    content: selectedShiftContent,
                    memo: freeText
                };

                saveShiftData(); // シフトデータをlocalStorageに保存

                alert('シフト登録完了\n従業員: ' + selectedEmployee + '\n日時: ' + selectedDate + ' ' + selectedTime + '\nシフト内容: ' + selectedShiftContent + '\n備考: ' + freeText);
            } else {
                alert('すべての項目を選択してください。');
            }
        }

        // 選択した日に登録されたシフトを表示
        function displayShiftForDate() {
            var shiftDisplay = document.getElementById('shiftDisplay');
            shiftDisplay.innerHTML = ''; // シフト表示をクリア

            if (shiftData[selectedDate]) {
                var shiftInfo = shiftData[selectedDate];
                for (var employee in shiftInfo) {
                    var shiftDetails = shiftInfo[employee];
                    shiftDisplay.innerHTML += '<p>従業員: ' + employee + '<br>時間: ' + shiftDetails.time + '<br>シフト内容: ' + shiftDetails.content + '<br>備考: ' + shiftDetails.memo + '</p>';
                }
            } else {
                shiftDisplay.innerHTML = '選択した日に登録されたシフトはありません。';
            }
        }

        function changeMonth(direction) {

            currentMonth += direction;
            if (currentMonth > 12) {
                currentMonth = 1;
                currentYear++;
            } else if (currentMonth < 1) {
                currentMonth = 12;
                currentYear--;
            }
            generateCalendar(currentYear, currentMonth); // カレンダーを更新
        }

        // 初期カレンダー生成
        generateCalendar(currentYear, currentMonth);
    </script>
</body>
</html>