<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page trimDirectiveWhitespaces="true" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ page import="dao.UserDao" %>
                <%@ page import="java.util.*" %>
                    <%@ page import="bean.ShiftRequest" %>
                        <%@ page import="bean.User" %>

                            <% try { UserDao userDao=new UserDao(); request.setAttribute("userDao", userDao); } catch
                                (Exception e) { e.printStackTrace(); response.sendError(500, "データベースエラー: " +
                                e.getMessage()); return; } %>
                                <% HttpSession currentsession=request.getSession(false); if (currentsession==null ||
                                    currentsession.getAttribute("userID")==null) { response.sendRedirect("login.jsp");
                                    return; } %>

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
                                                text-align: center;
                                                margin: 0;
                                            }
                                        </style>
                                    </head>

                                    <body>
                                        <%-- ヘッダーのインクルード --%>
                                            <c:import url="base3.jsp">
                                                <c:param name="title"></c:param>
                                                <c:param name="scripts"></c:param>
                                                <c:param name="content">

                                                    <div class="header-container">
                                                        <a href="http://localhost:8080/TikTiks/Main/menu2.jsp"
                                                            class="return-button">トップページに戻る</a>
                                                        <h1 class="header-title">シフト登録</h1>
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
                                                                    <input type="date" id="shift_date" name="shift_date"
                                                                        readonly required>
                                                                </div>

                                                                <div class="form-group">
                                                                    <label for="start_time">開始時間:</label>
                                                                    <select id="start_time" name="start_time" required>
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
                                                                    <textarea id="note" name="note" rows="3"></textarea>
                                                                </div>

                                                                <input type="submit" value="登録">
                                                            </form>
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

                                                        function isStaffAvailable(shift, dayName) {
                                                            if (!shift.selectedDays || typeof shift.selectedDays !== 'string') {
                                                                return false;
                                                            }

                                                            var selectedDaysArray = shift.selectedDays
                                                                .toLowerCase()
                                                                .split(',')
                                                                .map(function (day) { return day.trim(); });

                                                            var normalizedDayName = dayName.toLowerCase();

                                                            return shift.alwaysAvailable === true ||
                                                                selectedDaysArray.includes(normalizedDayName);
                                                        }

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

                                                            li.onclick = function () {
                                                                handleStaffSelection(this, shift, dayName);
                                                            };

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

                                                            if (startTime && endTime) {
                                                                updateTimeSelections(startTime, endTime);
                                                            } else {
                                                                console.error('時間データが利用できません:', dayName);
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

                                                        document.addEventListener('DOMContentLoaded', function () {
                                                            var calendar = new FullCalendar.Calendar(document.getElementById('calendar'), {
                                                                initialView: 'dayGridMonth',
                                                                locale: 'ja',
                                                                headerToolbar: {
                                                                    left: 'prev,next today',
                                                                    center: 'title',
                                                                    right: 'dayGridMonth,timeGridWeek'
                                                                },
                                                                dateClick: function (info) {
                                                                    if (selectedDateEl) {
                                                                        selectedDateEl.style.backgroundColor = '';
                                                                    }

                                                                    info.dayEl.style.backgroundColor = '#e7f5ff';
                                                                    selectedDateEl = info.dayEl;

                                                                    document.getElementById('shift_date').value = info.dateStr;

                                                                    var clickedDate = new Date(info.dateStr);
                                                                    var dayOfWeek = clickedDate.getDay();
                                                                    var dayNames = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'];
                                                                    var dayName = dayNames[dayOfWeek];

                                                                    updateStaffList(dayName);
                                                                    resetForm();
                                                                }
                                                            });

                                                            calendar.render();

                                                            document.getElementById('shiftForm').onsubmit = function (e) {
                                                                var userId = document.getElementById('user_id').value;
                                                                var shiftDate = document.getElementById('shift_date').value;
                                                                var startTime = document.getElementById('start_time').value;
                                                                var endTime = document.getElementById('end_time').value;

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

                                                                return true;
                                                            };
                                                        });
                                                    </script>
                                                    <%-- フッターのインクルード --%>
                                                </c:param>
                                            </c:import>
                                    </body>

                                    </html>