<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- シフト登録フォームとカレンダーを直接ここに配置 --%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>シフト管理デモ</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            display: flex;
            flex-direction: row;
            height: 100vh;
            margin: 0;
        }
        #shift-details {
            flex: 1;
            margin: 20px;
        }
        #calendar {
            flex: 3;
            margin: 20px;
        }
        .highlighted {
            background-color: #f9f871;
        }
        .active {
            background-color: #007bff;
            color: white;
        }
        .fc-col-header-cell {
            text-align: center;
        }
    </style>
</head>
<body>
    <!-- 出勤可能な人 -->
    <div id="shift-details">
        <h3>出勤可能な人</h3>
        <ul id="people-list-items" class="list-group"></ul>
    </div>

    <!-- カレンダー -->
    <div id="calendar"></div>

    <!-- シフト登録 -->
    <div id="shift-form">
        <h3>シフト登録</h3>
        <form id="shift-form">
            <div class="mb-3">
                <label for="name" class="form-label">名前:</label>
                <input type="text" id="name" class="form-control" readonly>
            </div>
            <div class="mb-3">
                <label for="date" class="form-label">日付:</label>
                <input type="date" id="date" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="start-time" class="form-label">開始時間:</label>
                <select id="start-time" class="form-control" required>
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
                    <option value="21:00">21:00</option>
                    <option value="22:00">22:00</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="end-time" class="form-label">終了時間:</label>
                <select id="end-time" class="form-control" required>
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
                    <option value="21:00">21:00</option>
                    <option value="22:00">22:00</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">登録</button>
        </form>
    </div>

    <script src="script.js"></script>
</body>
</html>
