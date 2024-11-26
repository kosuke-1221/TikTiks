document.addEventListener("DOMContentLoaded", () => {
    const calendarEl = document.getElementById("calendar");
    const peopleListEl = document.getElementById("people-list-items");
    const form = document.getElementById("shift-form");
    const nameInput = document.getElementById("name");
    const dateInput = document.getElementById("date");
    const startTimeInput = document.getElementById("start-time");
    const endTimeInput = document.getElementById("end-time");

    let selectedDate = null; // クリックされた日付を保存

    // 出勤可能な人（曜日ごと）
    const peopleByDay = {
        "Monday": ["佐藤太郎", "鈴木一郎"],
        "Tuesday": ["高橋花子", "田中二郎", "山田美穂"],
        "Wednesday": ["鈴木一郎", "田中二郎"],
        "Thursday": ["佐藤太郎", "高橋花子"],
        "Friday": ["山田美穂"],
        "Saturday": ["鈴木一郎", "田中二郎"],
        "Sunday": ["佐藤太郎", "高橋花子", "山田美穂"]
    };

    // 出勤可能な人リストを表示
    function updatePeopleList(day) {
        // リストをクリア
        peopleListEl.innerHTML = "";

        // 出勤可能な人を取得
        const availablePeople = peopleByDay[day] || [];

        // 出勤可能な人をリストに追加
        availablePeople.forEach((person) => {
            const li = document.createElement("li");
            li.className = "list-group-item";
            li.textContent = person;
            li.addEventListener("click", () => {
                nameInput.value = person;
                li.classList.add("active");
                document.querySelectorAll(".list-group-item").forEach(item => {
                    if (item !== li) {
                        item.classList.remove("active");
                    }
                });
            });
            peopleListEl.appendChild(li);
        });
    }

    // カレンダーの初期化
    const calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'timeGridWeek',
        locale: 'ja',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek'
        },
        events: [],
        slotDuration: '01:00:00', // 1時間ごと
        slotMinTime: '09:00:00', // 9:00から
        slotMaxTime: '22:00:00', // 22:00まで
        slotLabelInterval: '01:00', // 1時間ごとにラベル
        columnHeaderFormat: { weekday: 'short' }, // 曜日を表示
        eventContent: function(info) {
            return { html: `${info.event.title}` };
        },

        // 日付をクリックしたときに出勤可能な人を表示
        dateClick: function(info) {
            if (selectedDate) {
                selectedDate.style.backgroundColor = ''; // 元に戻す
            }

            // クリックされた日付のセルに色を付ける
            selectedDate = info.dayEl;
            selectedDate.style.backgroundColor = '#f9f871'; // 色を変更
            dateInput.value = info.dateStr; // 日付をフォームに反映

            // 曜日を取得
            const dayOfWeek = info.date.getDay(); // 0: Sunday, 1: Monday, ..., 6: Saturday
            const daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
            const dayName = daysOfWeek[dayOfWeek];

            // 出勤可能な人リストを更新
            updatePeopleList(dayName);
        }
    });

    calendar.render();

    // シフト登録フォームの送信イベント
    form.addEventListener("submit", (e) => {
        e.preventDefault();

        const name = nameInput.value;
        const date = dateInput.value;
        const startTime = startTimeInput.value;
        const endTime = endTimeInput.value;

        if (!name || !date || !startTime || !endTime) {
            alert("名前、日付、開始時間、終了時間をすべて入力してください");
            return;
        }

        // 開始時間と終了時間を正しい形式で生成
        const startDateTime = `${date}T${startTime}`;
        const endDateTime = `${date}T${endTime}`;

        // 登録されたシフトをカレンダーに追加
        const shiftEvent = {
            title: `${name}さん`,
            start: startDateTime, // 開始時間
            end: endDateTime, // 終了時間
            description: `${name}さんのシフト`,
            backgroundColor: '#28a745', // 緑色
            borderColor: '#28a745'
        };

        calendar.addEvent(shiftEvent);

        // 登録完了後にフォームをリセット
        form.reset();
        nameInput.value = '';
        document.querySelectorAll(".list-group-item").forEach(item => {
            item.classList.remove("active");
        });
        selectedDate.style.backgroundColor = ''; // 元に戻す
    });

    // 初期表示：今日の曜日に基づいて出勤可能な人リストを表示
    const today = new Date();
    const todayDay = today.getDay();
    const daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    const todayName = daysOfWeek[todayDay];
    updatePeopleList(todayName);
});
