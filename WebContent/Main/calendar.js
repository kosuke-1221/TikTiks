document.addEventListener("DOMContentLoaded", function () {
    console.log("DOMContentLoaded fired"); // 確認用

    const yearSelect = document.getElementById("yearSelect");
    const calendarContainer = document.getElementById("calendarContainer");
    const currentMonthSpan = document.getElementById("currentMonth");
    const prevMonthButton = document.getElementById("prevMonthButton");
    const nextMonthButton = document.getElementById("nextMonthButton");

    // 現在の年と月を取得
    const currentDate = new Date();
    let currentYear = currentDate.getFullYear();
    let currentMonth = currentDate.getMonth();

    // 過去3年〜未来3年までの選択肢を追加
    for (let i = currentYear - 3; i <= currentYear + 3; i++) {
        let option = document.createElement("option");
        option.value = i;
        option.textContent = i + "年";
        yearSelect.appendChild(option);
    }
    yearSelect.value = currentYear;

    // 初回のカレンダー生成：シフト情報を取得してから生成
    generateCalendar(currentYear, currentMonth, shiftList);

    // 年変更イベント
    yearSelect.addEventListener("change", function () {
        currentYear = parseInt(this.value, 10);
        generateCalendar(currentYear, currentMonth, shiftList);
    });

    // 次の月へボタンのイベント
    nextMonthButton.addEventListener("click", function () {
        currentMonth++;
        if (currentMonth > 11) {
            currentMonth = 0;
            currentYear++;
            yearSelect.value = currentYear;
        }
        generateCalendar(currentYear, currentMonth, shiftList);
    });

    // 前の月へボタンのイベント
    prevMonthButton.addEventListener("click", function () {
        currentMonth--;
        if (currentMonth < 0) {
            currentMonth = 11;
            currentYear--;
            yearSelect.value = currentYear;
        }
        generateCalendar(currentYear, currentMonth, shiftList);
    });

    function generateCalendar(year, month, shiftList) {
        calendarContainer.innerHTML = ""; // 既存のカレンダーをクリア

        const table = document.createElement("table");
        table.id = "calendarTable";
        table.className = "calendar-table";

        // カレンダーのヘッダーを作成
        const thead = document.createElement("thead");
        const headerRow = document.createElement("tr");
        const daysOfWeek = ["日", "月", "火", "水", "木", "金", "土"];
        daysOfWeek.forEach(function (day) {
            const th = document.createElement("th");
            th.textContent = day;
            headerRow.appendChild(th);
        });
        thead.appendChild(headerRow);
        table.appendChild(thead);

        // カレンダーのボディを作成
        const tbody = document.createElement("tbody");
        const firstDayOfMonth = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        let date = 1;

        for (let i = 0; i < 6; i++) {
            const row = document.createElement("tr");

            for (let j = 0; j < 7; j++) {
                const cell = document.createElement("td");

                if (i === 0 && j < firstDayOfMonth) {
                    cell.textContent = "";
                } else if (date > daysInMonth) {
                    break;
                } else {
                    const dateNumber = document.createElement("span");
                    dateNumber.className = "date-number";
                    dateNumber.textContent = date;
                    cell.appendChild(dateNumber);

                    const dateStr = `${year}-${String(month + 1).padStart(2, '0')}-${String(date).padStart(2, '0')}`;

                    if (holidays[dateStr]) {
                        cell.classList.add("holiday");
                        const holidayLabel = document.createElement("span");
                        holidayLabel.className = "holiday-label";
                        holidayLabel.textContent = holidays[dateStr];
                        cell.appendChild(holidayLabel);
                    }

                    // DBから取得したシフト情報を表示する処理
                    const shiftInfo = shiftList.find(function (shift) {
                        return shift.shiftDate === dateStr;
                    });

                    if (shiftInfo) {
                        const shiftDetails = document.createElement("div");
                        shiftDetails.className = "shift-info";

                        const startTime = shiftInfo.startTime;
                        const endTime = shiftInfo.endTime;

                        // note が null でない、かつ空でない場合のみ表示
                        let noteContent = "";
                        if (shiftInfo.note && shiftInfo.note.trim() !== "") {
                            noteContent = `<div class="note-info">メモ<br>${shiftInfo.note}</div>`;
                        }

                        shiftDetails.innerHTML = `
                            <div>開始 ${startTime}</div>
                            <div>終了 ${endTime}</div>
                            ${noteContent} <!-- note が null でない場合のみ表示 -->
                        `;
                        cell.appendChild(shiftDetails);
                    }



                    date++;
                }
                row.appendChild(cell);
            }
            tbody.appendChild(row);
        }
        table.appendChild(tbody);
        calendarContainer.appendChild(table);

        const monthNames = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"];
        currentMonthSpan.textContent = `${year}年 ${monthNames[month]}`;
    }
});

const holidays = {
    "2025-01-01": "元日",
    "2025-01-13": "成人の日",
    "2025-02-11": "建国記念の日",
    "2025-02-23": "天皇誕生日",
    "2025-03-20": "春分の日",
    "2025-04-29": "昭和の日",
    "2025-05-03": "憲法記念日",
    "2025-05-04": "みどりの日",
    "2025-05-05": "こどもの日",
    "2025-07-21": "海の日",
    "2025-08-11": "山の日",
    "2025-09-15": "敬老の日",
    "2025-09-23": "秋分の日",
    "2025-10-13": "スポーツの日",
    "2025-11-03": "文化の日",
    "2025-11-23": "勤労感謝の日",
};