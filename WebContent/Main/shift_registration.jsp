<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page trimDirectiveWhitespaces="true" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <%@ page import="dao.UserDao, dao.ShiftDao, dao.VacationDao" %>
                    <%@ page import="bean.ShiftCount, bean.ShiftRequest, bean.User, bean.ShiftDetail, bean.VacationRequest" %>
                        <%@ page import="java.util.List" %>

                            <% try { UserDao userDao=new UserDao(); ShiftDao shiftDao=new ShiftDao(); // シフト情報を取得
                                List<ShiftDetail> shiftDetails = shiftDao.getAllShiftDetails();
                                request.setAttribute("shiftDetails", shiftDetails);

                                request.setAttribute("userDao", userDao);

                                // シフト日付ごとの登録人数を取得してrequestにセット
                                List<ShiftCount> shiftCounts = shiftDao.getShiftCounts();
                                    request.setAttribute("shiftCounts", shiftCounts);

                                    // 休暇希望日を取得してrequestにセット
                                    VacationDao vacationDao = new VacationDao();
                                    List<VacationRequest> vacationRequests = vacationDao.getAllVacationRequests();
                                    request.setAttribute("vacationRequests", vacationRequests);
                                    } catch (Exception e) {
                                    e.printStackTrace();
                                    response.sendError(500, "データベースエラー: " + e.getMessage());
                                    return;
                                    }

                                    HttpSession currentsession = request.getSession(false);
                                    if (currentsession == null || currentsession.getAttribute("userID") == null) {
                                    response.sendRedirect("login.jsp");
                                    return;
                                    }
                                    %>

                                    <!DOCTYPE html>
                                    <html>

                                    <head>
                                        <meta charset="UTF-8">
                                        <title>シフト登録</title>
                                        <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.css"
                                            rel="stylesheet" />
                                        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.js"></script>
                                        <script
                                            src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.js"></script>
                                        <style>
                                            body {
                                                font-family: Arial, sans-serif;
                                                margin: 0;
                                                padding: 20px;
                                                background-color: #f8f9fa;
                                            }

                                            .container {
                                                display: flex;
                                                margin: 20px;
                                                gap: 20px;
                                            }

                                            .staff-list-container {
                                                flex: 1;
                                                min-width: 200px;
                                                max-width: 250px;
                                                padding: 15px;
                                                background-color: white;
                                                border-radius: 5px;
                                                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                                            }

                                            .calendar-container {
                                                flex: 2;
                                                background-color: white;
                                                padding: 15px;
                                                border-radius: 5px;
                                                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                                            }

                                            .form-container {
                                                flex: 1;
                                                min-width: 300px;
                                                padding: 20px;
                                                background-color: white;
                                                border-radius: 5px;
                                                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                                            }

                                            #available-staff-list {
                                                list-style: none;
                                                padding: 0;
                                            }

                                            #available-staff-list li {
                                                padding: 10px;
                                                margin-bottom: 5px;
                                                background-color: #f8f9fa;
                                                border-radius: 4px;
                                                cursor: pointer;
                                                transition: all 0.3s ease;
                                            }

                                            #available-staff-list li:hover {
                                                background-color: #e9ecef;
                                            }

                                            #available-staff-list li.selected {
                                                background-color: #e7f5ff;
                                                border: 1px solid #339af0;
                                            }

                                            .form-group {
                                                margin-bottom: 15px;
                                            }

                                            label {
                                                display: block;
                                                margin-bottom: 5px;
                                                font-weight: bold;
                                            }

                                            select,
                                            input[type="text"],
                                            input[type="date"] {
                                                width: 100%;
                                                padding: 8px;
                                                border: 1px solid #ddd;
                                                border-radius: 4px;
                                                box-sizing: border-box;
                                            }

                                            input[type="submit"] {
                                                background-color: #4CAF50;
                                                color: white;
                                                padding: 10px;
                                                border: none;
                                                border-radius: 4px;
                                                cursor: pointer;
                                                width: 100%;
                                            }

                                            input[type="submit"]:hover {
                                                background-color: #45a049;
                                            }

                                            .alert {
                                                padding: 15px;
                                                margin-bottom: 20px;
                                                border: 1px solid transparent;
                                                border-radius: 4px;
                                            }

                                            .alert-danger {
                                                color: #721c24;
                                                background-color: #f8d7da;
                                                border-color: #f5c6cb;
                                            }

                                            .header-container {
                                                display: flex;
                                                align-items: center;
                                                justify-content: center;
                                                margin-top: 90px;
                                                position: relative;
                                            }

                                            .return-button {
                                                position: absolute;
                                                left: 20px;
                                                display: inline-block;
                                                padding: 8px 16px;
                                                font-size: 14px;
                                                background-color: transparent;
                                                border: 1px solid #8BC34A;
                                                /* 明るい緑色の枠線に変更 */
                                                color: #558B2F;
                                                /* 文字色を濃い緑に変更 */
                                                text-decoration: none;
                                                border-radius: 4px;
                                                transition: background-color 0.3s, color 0.3s, border-color 0.3s;
                                                /* ホバー時の枠線のアニメーションを追加 */
                                            }

                                            .return-button:hover {
                                                background-color: #DCEDC8;
                                                /* ホバー時の背景色を薄い黄緑に変更 */
                                                border-color: #689F38;
                                                /* ホバー時の枠線を濃い緑に変更 */
                                                color: #33691E;
                                                /* ホバー時の文字色をさらに濃い緑に変更 */
                                                text-decoration: none;
                                            }

                                            .header-title {
                                                color: #4caf50;
                                                /* 基本文字色 */
                                                text-align: center;
                                                margin: 0;
                                            }

                                            .fc-day-sat {
                                                color: blue;
                                            }

                                            .fc-day-sun {
                                                color: red;
                                            }

                                            .fc-daygrid-day.fc-day-today {
                                                background-color: #e7f5ff;
                                            }

                                            .fc-daygrid-day.fc-day-selected {
                                                background-color: #d4edda;
                                            }

                                            .modal {
                                                display: none;
                                                position: fixed;
                                                z-index: 1000;
                                                left: 0;
                                                top: 0;
                                                width: 100%;
                                                height: 100%;
                                                overflow: auto;
                                                background-color: rgba(0, 0, 0, 0.5);
                                            }

                                            .modal-content {
                                                background-color: #fefefe;
                                                margin: 15% auto;
                                                padding: 20px;
                                                border: 1px solid #888;
                                                width: 50%;
                                                border-radius: 8px;
                                            }

                                            .close-modal {
                                                color: #aaa;
                                                float: right;
                                                font-size: 28px;
                                                font-weight: bold;
                                            }

                                            .close-modal:hover,
                                            .close-modal:focus {
                                                color: black;
                                                cursor: pointer;
                                            }

                                            @media (max-width: 768px) {
                                                .container {
                                                    flex-direction: column;
                                                    gap: 10px;
                                                }

                                                .staff-list-container,
                                                .calendar-container,
                                                .form-container {
                                                    width: 100%;
                                                    max-width: 100%;
                                                    min-width: auto;
                                                    padding: 10px;
                                                }

                                                .return-button {
                                                    font-size: 16px;
                                                    padding: 10px 20px;
                                                    position: absolute;
                                                    left: 20px;
                                                    bottom: 10px;
                                                    /* ここでボタンを下に配置 */
                                                    background-color: transparent;
                                                    border: 1px solid #8BC34A;
                                                    color: #558B2F;
                                                    text-decoration: none;
                                                    border-radius: 4px;
                                                    transition: background-color 0.3s, color 0.3s, border-color 0.3s;
                                                }

                                                input[type="submit"] {
                                                    font-size: 16px;
                                                    padding: 12px;
                                                }

                                                label {
                                                    font-size: 14px;
                                                }

                                                select,
                                                input[type="text"],
                                                input[type="date"] {
                                                    font-size: 14px;
                                                    padding: 10px;
                                                }

                                                .header-container {
                                                    display: flex;
                                                    align-items: center;
                                                    justify-content: center;
                                                    margin-top: 90px;
                                                    position: relative;
                                                }

                                                .return-button:hover {
                                                    background-color: #DCEDC8;
                                                    border-color: #689F38;
                                                    color: #33691E;
                                                    text-decoration: none;
                                                }
                                            }

                                            .vacation {
                                                background-color: #ccc; /* グレー色 */
                                                color: red; /* スタッフ名称の色を赤に変更 */
                                                cursor: not-allowed;
                                            }
                                        </style>
                                    </head>

                                    <body>
                                        <%-- デバッグ出力部分をコメントアウトまたは削除 --%>
                                            <!--
    <c:if test="${not empty shiftCounts}">
        <c:forEach var="sc" items="${shiftCounts}">
            <p>
                <strong>Date:</strong>
                <c:out value="${sc.date}" />
                <strong>Count:</strong>
                <c:out value="${sc.count}" />
            </p>
        </c:forEach>
    </c:if>
    <c:if test="${empty shiftCounts}">
        <p>No shift counts found.</p>
    </c:if>
    -->
                                            <%-- ヘッダーのインクルード --%>
                                                <c:import url="base3.jsp">
                                                    <c:param name="title"></c:param>
                                                    <c:param name="scripts"></c:param>
                                                    <c:param name="content">

                                                        <div class="header-container">
                                                            <a href="http://localhost:8080/TikTiks/Main/menu2.jsp"
                                                                class="return-button">トップページに戻る</a>
                                                            <h1 class="header-title">😊シフト登録😊</h1>
                                                        </div>

                                                        <c:if test="${not empty errorMessage}">
                                                            <div class="alert alert-danger">
                                                                ${errorMessage}
                                                            </div>
                                                        </c:if>

                                                        <div class="container">
                                                            <div class="staff-list-container">
                                                                <h3>出勤可能なスタッフ</h3>
                                                                <ul id="available-staff-list"></ul>
                                                            </div>

                                                            <div class="calendar-container">
                                                                <div id="calendar"></div>
                                                            </div>

                                                            <div class="form-container">
                                                                <h3>シフト登録フォーム</h3>
                                                                <form action="ShiftRegistration" method="post"
                                                                    id="shiftForm">
                                                                    <div class="form-group">
                                                                        <label for="user_id">ユーザーID:</label>
                                                                        <input type="text" id="user_id" name="user_id"
                                                                            readonly required>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label for="shift_date">シフト日付:</label>
                                                                        <input type="date" id="shift_date"
                                                                            name="shift_date" readonly required>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label for="start_time">開始時間:</label>
                                                                        <select id="start_time" name="start_time"
                                                                            required>
                                                                            <option value="">選択してください</option>
                                                                        </select>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label for="end_time">終了時間:</label>
                                                                        <select id="end_time" name="end_time" required>
                                                                            <option value="">選択してください</option>
                                                                        </select>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label for="note">メモ:</label>
                                                                        <textarea id="note" name="note"
                                                                            rows="3"></textarea>
                                                                    </div>

                                                                    <input type="submit" value="登録">
                                                                </form>
                                                            </div>
                                                        </div>

                                                        <!-- モーダル用HTML追加 -->
                                                        <div id="staffDetailsModal" class="modal">
                                                            <div class="modal-content">
                                                                <span class="close-modal" id="closeModal">&times;</span>
                                                                <h3>登録されたスタッフ詳細</h3>
                                                                <pre id="modalContent"
                                                                    style="white-space: pre-wrap;"></pre>
                                                            </div>
                                                        </div>
                                                        <script>
                                                            var selectedDateEl = null;
                                                            var shiftsData = [
                                                                <c:forEach var="shift" items="${availableShifts}" varStatus="status">
                                                                    {
                                                                        userId: "${shift.userId}",
                                                                    userName: "${userDao.getUserName(shift.userId)}",
                                                                    selectedDays: "${shift.selectedDays}",
                                                                    mondayStartTime: "${shift.mondayStartTime}",
                                                                    mondayEndTime: "${shift.mondayEndTime}",
                                                                    tuesdayStartTime: "${shift.tuesdayStartTime}",
                                                                    tuesdayEndTime: "${shift.tuesdayEndTime}",
                                                                    wednesdayStartTime: "${shift.wednesdayStartTime}",
                                                                    wednesdayEndTime: "${shift.wednesdayEndTime}",
                                                                    thursdayStartTime: "${shift.thursdayStartTime}",
                                                                    thursdayEndTime: "${shift.thursdayEndTime}",
                                                                    fridayStartTime: "${shift.fridayStartTime}",
                                                                    fridayEndTime: "${shift.fridayEndTime}",
                                                                    saturdayStartTime: "${shift.saturdayStartTime}",
                                                                    saturdayEndTime: "${shift.saturdayEndTime}",
                                                                    sundayStartTime: "${shift.sundayStartTime}",
                                                                    sundayEndTime: "${shift.sundayEndTime}",
                                                                    alwaysAvailable: ${shift.alwaysAvailable}
                        }<c:if test="${!status.last}">,</c:if>
                                                                </c:forEach>
                                                            ];

                                                            var registeredShifts = [
                                                                <c:forEach var="sd" items="${shiftDetails}" varStatus="status">
                                                                    {
                                                                        userId: "${sd.userId}",
                                                                    userName: "${sd.userName}",
                                                                    shiftDate: "${sd.shiftDate}",
                                                                    startTime: "${sd.startTime}",
                                                                    endTime: "${sd.endTime}",
                                                                    note: "${sd.note}"
                        }<c:if test="${!status.last}">,</c:if>
                                                                </c:forEach>
                                                            ];

                                                            // 休暇希望日のJS配列（{ userId:"", vacationDate:"YYYY-MM-DD" }形式）
                                                            var vacationRequests = [
                                                                <c:forEach var="vac" items="${vacationRequests}" varStatus="status">
                                                                    { userId: "${vac.userId}", vacationDate: "${vac.vacationDate}", reason: "${vac.reason}" }<c:if test="${!status.last}">,</c:if>
                                                                </c:forEach>
                                                            ];

                                                            function generateTimeOptions(startTime, endTime) {
                                                                console.log('時間選択肢生成:', { startTime, endTime });

                                                                var options = ['<option value="">選択してください</option>'];

                                                                try {
                                                                    var [startHour] = startTime.split(':').map(Number);
                                                                    var [endHour] = endTime.split(':').map(Number);

                                                                    if (isNaN(startHour) || isNaN(endHour)) {
                                                                        throw new Error('不正な時間形式');
                                                                    }

                                                                    for (var hour = startHour; hour <= endHour; hour++) {
                                                                        var paddedHour = (hour < 10 ? '0' : '') + hour;
                                                                        var timeStr = paddedHour + ':00';
                                                                        options.push('<option value="' + timeStr + '">' + timeStr + '</option>');
                                                                    }
                                                                } catch (error) {
                                                                    console.error('時間選択肢生成エラー:', error);
                                                                }

                                                                return options.join('');
                                                            }

                                                            // 修正: alwaysAvailableがtrueの場合は常に利用可能とする
                                                            function isStaffAvailable(shift, dayName) {
                                                                if (shift.alwaysAvailable === true) {
                                                                    return true;
                                                                }
                                                                if (!shift.selectedDays || typeof shift.selectedDays !== 'string') {
                                                                    return false;
                                                                }
                                                                var selectedDaysArray = shift.selectedDays.toLowerCase().split(',').map(function (day) {
                                                                    return day.trim();
                                                                });
                                                                var normalizedDayName = dayName.toLowerCase();
                                                                return selectedDaysArray.includes(normalizedDayName);
                                                            }

                                                            // 関数：指定のスタッフが選択日で休暇希望かチェック
                                                            function isOnVacation(userId, selectedDate) {
                                                                return vacationRequests.some(function(vac) {
                                                                    return vac.userId === userId && vac.vacationDate === selectedDate;
                                                                });
                                                            }

                                                            function displayVacationReason(userId, selectedDate) {
                                                                var vac = vacationRequests.find(function(vac) {
                                                                    return vac.userId === userId && vac.vacationDate === selectedDate;
                                                                });
                                                                if (vac) {
                                                                    var modal = document.getElementById('staffDetailsModal');
                                                                    var modalContent = document.getElementById('modalContent');
                                                                    modalContent.textContent = "休みたい理由: " + vac.reason;
                                                                    modal.style.display = "block";
                                                                } else {
                                                                    alert("休暇情報が見つかりません。");
                                                                }
                                                            }

                                                            // モーダルクローズ用のイベントを設定
                                                            document.getElementById('closeModal').onclick = function() {
                                                                document.getElementById('staffDetailsModal').style.display = "none";
                                                            };

                                                            function updateStaffList(dayName) {
                                                                console.log('スタッフリスト更新:', dayName);

                                                                var staffList = document.getElementById('available-staff-list');
                                                                staffList.innerHTML = '';

                                                                shiftsData.forEach(function (shift) {
                                                                    if (isStaffAvailable(shift, dayName)) {
                                                                        var li = createStaffListItem(shift, dayName);
                                                                        staffList.appendChild(li);
                                                                    }
                                                                });
                                                            }

                                                            function createStaffListItem(shift, dayName) {
                                                                var li = document.createElement('li');
                                                                li.textContent = shift.userName || shift.userId;

                                                                var startTimeKey = dayName.toLowerCase() + 'StartTime';
                                                                var endTimeKey = dayName.toLowerCase() + 'EndTime';

                                                                if (shift[startTimeKey] && shift[endTimeKey]) {
                                                                    li.title = shift[startTimeKey] + '-' + shift[endTimeKey];
                                                                }

                                                                var selectedDate = document.getElementById('shift_date').value;
                                                                // 休暇希望の場合は色変更とクリック無効化
                                                                if (selectedDate && isOnVacation(shift.userId, selectedDate)) {
                                                                    li.classList.add('vacation');
                                                                    li.onclick = function() {
                                                                        displayVacationReason(shift.userId, selectedDate);
                                                                    };
                                                                } else {
                                                                    li.onclick = function () {
                                                                        handleStaffSelection(this, shift, dayName);
                                                                    };
                                                                }
                                                                return li;
                                                            }

                                                            function handleStaffSelection(listItem, shift, dayName) {
                                                                console.log('スタッフ選択:', { shift, dayName });

                                                                var startTimeKey = dayName.toLowerCase() + 'StartTime';
                                                                var endTimeKey = dayName.toLowerCase() + 'EndTime';

                                                                document.querySelectorAll('#available-staff-list li').forEach(function (item) {
                                                                    item.classList.remove('selected');
                                                                });
                                                                listItem.classList.add('selected');

                                                                document.getElementById('user_id').value = shift.userId;

                                                                var startTime = shift[startTimeKey];
                                                                var endTime = shift[endTimeKey];

                                                                // いつでも可の場合は固定の開始～終了時刻で、ユーザーが自分で選択できるようにする
                                                                if (shift.alwaysAvailable === true) {
                                                                    updateTimeSelections("09:00", "24:00");
                                                                } else {
                                                                    if (startTime && endTime) {
                                                                        updateTimeSelections(startTime, endTime);
                                                                    } else {
                                                                        console.error('時間データが利用できません:', dayName);
                                                                    }
                                                                }
                                                            }

                                                            function updateTimeSelections(startTime, endTime) {
                                                                console.log('時間選択の更新:', { startTime, endTime });

                                                                var startSelect = document.getElementById('start_time');
                                                                var endSelect = document.getElementById('end_time');

                                                                try {
                                                                    startSelect.innerHTML = generateTimeOptions(startTime, endTime);

                                                                    startSelect.onchange = function () {
                                                                        if (this.value) {
                                                                            endSelect.innerHTML = generateTimeOptions(this.value, endTime);
                                                                        } else {
                                                                            endSelect.innerHTML = '<option value="">選択してください</option>';
                                                                        }
                                                                    };

                                                                    endSelect.innerHTML = '<option value="">選択してください</option>';
                                                                } catch (error) {
                                                                    console.error('時間選択の更新エラー:', error);
                                                                }
                                                            }

                                                            function resetForm() {
                                                                document.getElementById('user_id').value = '';
                                                                document.getElementById('start_time').innerHTML = '<option value="">選択してください</option>';
                                                                document.getElementById('end_time').innerHTML = '<option value="">選択してください</option>';
                                                                document.getElementById('note').value = '';

                                                                document.querySelectorAll('#available-staff-list li').forEach(function (item) {
                                                                    item.classList.remove('selected');
                                                                });
                                                            }

                                                            // 登録済みシフトをFullCalendar用イベントに変換（※削除：詳細シフトはカレンダーに表示しない）
                                                            var calendarEvents = []; // 詳細イベントは含めず、シフト日ごとの登録人数のみ表示

                                                            document.addEventListener('DOMContentLoaded', function () {
                                                                var calendar = new FullCalendar.Calendar(document.getElementById('calendar'), {
                                                                    initialView: 'dayGridMonth',
                                                                    locale: 'ja',
                                                                    initialDate: localStorage.getItem('calendarDate') || new Date(),  // 本日の日付を表示
                                                                    displayEventTime: false, // 時刻を非表示に設定
                                                                    headerToolbar: {
                                                                        left: 'prev,next today',
                                                                        center: 'title',
                                                                        right: 'dayGridMonth'
                                                                    },
                                                                    // カレンダーイベントはシフト登録人数のみ
                                                                    events: [
                                                                        <c:forEach var="shiftCount" items="${shiftCounts}" varStatus="status">
                                                                            {
                                                                                title: '${shiftCount.count}人',
                                                                            start: '${shiftCount.date}'
                                }<c:if test="${!status.last}">,</c:if>
                                                                        </c:forEach>
                                                                    ],
                                                                    eventContent: function (arg) {
                                                                        return { html: '<div style="font-size:14px; text-align:center;">' + arg.event.title + '</div>' };
                                                                    },
                                                                    eventClick: function (info) {
                                                                        var modal = document.getElementById('staffDetailsModal');
                                                                        var modalContent = document.getElementById('modalContent');
                                                                        var targetDate = info.event.startStr;
                                                                        var staffList = registeredShifts.filter(function(shift) {
                                                                            return shift.shiftDate === targetDate;
                                                                        });
                                                                        var detailsHTML = "<h4>" + targetDate + " のシフト登録スタッフ</h4><ul>";
                                                                        if (staffList.length > 0) {
                                                                            staffList.forEach(function(shift) {
                                                                                detailsHTML += "<li>" + shift.userName + " (" + shift.userId + ") " +
                                                                                               shift.startTime + "～" + shift.endTime +
                                                                                               " メモ: " + shift.note + " " +
                                                                                               "<button class='delete-btn' data-userid='" + shift.userId +
                                                                                               "' data-shiftdate='" + shift.shiftDate +
                                                                                               "' data-starttime='" + shift.startTime + "'>削除</button></li>";
                                                                            });
                                                                        } else {
                                                                            detailsHTML += "<li>登録されたスタッフはいません</li>";
                                                                        }
                                                                        detailsHTML += "</ul>";
                                                                        modalContent.innerHTML = detailsHTML;
                                                                        modal.style.display = "block";

                                                                        // 削除ボタンのイベントを設定
                                                                        document.querySelectorAll('.delete-btn').forEach(function(button) {
                                                                            button.addEventListener('click', function(e) {
                                                                                e.stopPropagation();
                                                                                if (confirm("このシフトを削除してもよろしいですか？")) {
                                                                                    var form = document.createElement('form');
                                                                                    form.method = 'post';
                                                                                    form.action = 'ShiftDeletion';

                                                                                    var inputUserId = document.createElement('input');
                                                                                    inputUserId.type = 'hidden';
                                                                                    inputUserId.name = 'user_id';
                                                                                    inputUserId.value = this.getAttribute('data-userid');
                                                                                    form.appendChild(inputUserId);

                                                                                    var inputShiftDate = document.createElement('input');
                                                                                    inputShiftDate.type = 'hidden';
                                                                                    inputShiftDate.name = 'shift_date';
                                                                                    inputShiftDate.value = this.getAttribute('data-shiftdate');
                                                                                    form.appendChild(inputShiftDate);

                                                                                    var inputStartTime = document.createElement('input');
                                                                                    inputStartTime.type = 'hidden';
                                                                                    inputStartTime.name = 'start_time';
                                                                                    inputStartTime.value = this.getAttribute('data-starttime');
                                                                                    form.appendChild(inputStartTime);

                                                                                    document.body.appendChild(form);
                                                                                    form.submit();
                                                                                }
                                                                            });
                                                                        });
                                                                    },
                                                                    dateClick: function (info) {
                                                                        if (selectedDateEl) {
                                                                            selectedDateEl.classList.remove('fc-day-selected');
                                                                        }
                                                                        info.dayEl.classList.add('fc-day-selected');
                                                                        selectedDateEl = info.dayEl;
                                                                        document.getElementById('shift_date').value = info.dateStr;
                                                                        var clickedDateObj = new Date(info.dateStr);
                                                                        var dayOfWeek = clickedDateObj.getDay();
                                                                        var dayNames = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'];
                                                                        updateStaffList(dayNames[dayOfWeek]);
                                                                        resetForm();
                                                                    }
                                                                });

                                                                calendar.render();

                                                                document.getElementById('shiftForm').onsubmit = function (e) {
                                                                    var userId = document.getElementById('user_id').value;
                                                                    var shiftDate = document.getElementById('shift_date').value;
                                                                    var startTime = document.getElementById('start_time').value;
                                                                    var endTime = document.getElementById('end_time').value;

                                                                    // バリデーション
                                                                    if (!userId || !shiftDate || !startTime || !endTime) {
                                                                        alert('すべての必須項目を入力してください');
                                                                        e.preventDefault();
                                                                        return false;
                                                                    }

                                                                    if (startTime >= endTime) {
                                                                        alert('終了時間は開始時間より後にしてください');
                                                                        e.preventDefault();
                                                                        return false;
                                                                    }

                                                                    // 休暇希望を出しているスタッフかチェックするように修正
                                                                    if (vacationRequests.some(function(vac) {
                                                                        return vac.userId === userId && vac.vacationDate === shiftDate;
                                                                    })) {
                                                                        alert("選択されたスタッフは休暇希望を出しているため、登録できません。");
                                                                        e.preventDefault();
                                                                        return false;
                                                                    }

                                                                    // カレンダーの現在の日付を保存
                                                                    localStorage.setItem('calendarDate', calendar.getDate().toISOString());
                                                                    return true;
                                                                };

                                                                document.getElementById('closeModal').onclick = function () {
                                                                    document.getElementById('staffDetailsModal').style.display = "none";
                                                                };
                                                                window.onclick = function (event) {
                                                                    if (event.target == document.getElementById('staffDetailsModal')) {
                                                                        document.getElementById('staffDetailsModal').style.display = "none";
                                                                    }
                                                                };

                                                                // シフト人数リストのクリックイベント付与（必要に応じて）
                                                                document.querySelectorAll('#shift-count-list li').forEach(function(item) {
                                                                    item.addEventListener('click', function() {
                                                                        var targetDate = this.getAttribute('data-date');
                                                                        var detailsHTML = "<h4>" + targetDate + " のシフト登録スタッフ</h4><ul>";
                                                                        detailsHTML += registeredShifts.filter(function(shift) {
                                                                            return shift.shiftDate === targetDate;
                                                                        }).map(function(shift) {
                                                                            return "<li>" + shift.userName + " (" + shift.userId + ") " +
                                                                                   shift.startTime + "～" + shift.endTime +
                                                                                   " メモ: " + shift.note + "</li>";
                                                                        }).join("");
                                                                        detailsHTML += "</ul>";
                                                                        var modal = document.getElementById('staffDetailsModal');
                                                                        var modalContent = document.getElementById('modalContent');
                                                                        modalContent.innerHTML = detailsHTML;
                                                                        modal.style.display = "block";
                                                                    });
                                                                });
                                                            });
                                                        </script>

                                                    </c:param>
                                                </c:import>
                                    </body>

                                    </html>