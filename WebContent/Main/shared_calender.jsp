<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>共有カレンダー</title>
    <style>
        /* グローバルなスタイル */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
            flex-wrap: wrap;
            text-align: center;
        }

        h1 {
            width: 100%;
            text-align: center; /* 中央揃え */
        }
        h2{
        	width: 100%;
            text-align: center; /* 中央揃え */
        }

        /* カレンダーのデザイン */
        table {
            width: 70%; /* カレンダーを60%の幅に */
            border-collapse: collapse;
            margin: 0 auto 20px auto; /* 中央に配置し、下に20pxの余白 */
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1); /* カレンダーに影を追加 */
            border-radius: 8px; /* 角を丸める */
        }

        th, td {
            border: 1px solid #ccc;
            text-align: center;
            padding: 15px;
        }

        th {
            background-color: #f0f0f0;
        }

        .sunday {
            background-color: #ffcccb;
        }

        .saturday {
            background-color: #add8e6;
        }

        /* シフト情報のバー */
        #info {
            width: 15%; /* シフト情報の幅を10%に */
            padding: 15px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            height: 200px;
            overflow-y: auto;
            position: sticky;
            top: 20px;
        }

        /* セレクトボックスの親要素を横並びに */
        .select-form-container {
            display: flex; /* フォームを横並びにする */
            justify-content: flex-end; /* 右端に揃える */
            margin-top: 100px; /* 上部に余白を追加 */
            margin-right: 20px; /* 右端に余白を追加 */
        }

        .select-form-container {
            position: absolute; /* 親要素を絶対位置で配置 */
            top: 20px; /* 上から20pxの位置 */
            right: 20px; /* 右から20pxの位置 */
            display: flex; /* フォームを横並びにする */
        }

        /* 月選択フォームと日付選択フォームの間に余白を追加 */
        .select-month, .select-day {
            margin-right: 10px; /* フォーム間の隙間を調整 */
        }

        /* インプットフィールドのデザイン */
        .select-month input, .select-day input {
            padding: 8px;
            font-size: 1rem;
            border-radius: 4px;
            border: 1px solid #ccc;
            width: 50px;
        }

        /* カレンダー内の日付のデザイン */
        td {
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        td:hover {
            background-color: #f0f0f0;
        }

        /* モバイル対応 */
        @media (max-width: 768px) {
            body {
                flex-direction: column;
                align-items: center;
            }

            table {
                width: 90%;
            }

            #info {
                width: 100%;
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>
    <h1>😁共有カレンダー😁</h1>

    <%
        String selectedMonth = request.getParameter("month");
        String selectedDay = request.getParameter("day");

        if (selectedMonth == null) {
            Calendar cal = Calendar.getInstance();
            selectedMonth = String.valueOf(cal.get(Calendar.MONTH) + 1);
        }

        if (selectedDay == null) {
            selectedDay = "1";
        }

        int year = Calendar.getInstance().get(Calendar.YEAR);
        int month = Integer.parseInt(selectedMonth) - 1;
        int today = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        int startDay = cal.get(Calendar.DAY_OF_WEEK);
        int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        Map<String, String> shiftData = new HashMap<>();
        shiftData.put(year + "-" + (month + 1) + "-5", "9:00 - 18:00 (山田 太郎, 鈴木 花子)");
        shiftData.put(year + "-" + (month + 1) + "-10", "10:00 - 19:00 (田中 一郎)");
        shiftData.put(year + "-" + (month + 1) + "-15", "休み");

        String[] months = {"1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"};
        String currentMonth = months[month];
    %>

    <!-- 月選択フォームと日付選択フォームを横並びにする親要素 -->
    <div class="select-form-container">
        <!-- 月選択フォーム -->
        <form method="get" class="select-month">
            <label for="month">月を選択:</label>
            <input type="number" name="month" min="1" max="12" value="<%= selectedMonth %>" onchange="this.form.submit()">
        </form>

        <!-- 日選択フォーム -->
        <form method="get" class="select-day">
            <label for="day">日を選択:</label>
            <input type="number" name="day" min="1" max="<%= daysInMonth %>" value="<%= selectedDay %>" onchange="this.form.submit()">
        </form>
    </div>

    <h2 style="text-align: center;"><%= currentMonth %></h2>

    <!-- カレンダー -->
    <table>
        <thead>
            <tr>
                <th class="sunday">日</th>
                <th>月</th>
                <th>火</th>
                <th>水</th>
                <th>木</th>
                <th>金</th>
                <th class="saturday">土</th>
            </tr>
        </thead>
        <tbody>
            <%
                int day = 1;
                boolean started = false;

                for (int i = 0; i < 6; i++) {
                    out.println("<tr>");
                    for (int j = 1; j <= 7; j++) {
                        if (!started && j == startDay) {
                            started = true;
                        }

                        if (started && day <= daysInMonth) {
                            String dateKey = year + "-" + (month + 1) + "-" + day;

                            out.print("<td");
                            if (j == 1) { out.print(" class='sunday'"); }
                            else if (j == 7) { out.print(" class='saturday'"); }

                            if (day == today) { out.print(" style='font-weight: bold;'"); }

                            out.print(" onclick='showInfo(\"" + dateKey + "\")'>");
                            out.print(day);

                            if (shiftData.containsKey(dateKey)) {
                                out.print("<br><small>" + shiftData.get(dateKey).split(" ")[0] + "</small>");
                            }
                            out.print("</td>");

                            day++;
                        } else {
                            out.print("<td></td>");
                        }
                    }
                    out.println("</tr>");
                    if (day > daysInMonth) break;
                }
            %>
        </tbody>
    </table>

    <!-- シフト情報 -->
    <div id="info">日付をクリックするとシフト情報が表示されます。</div>

    <script>
        function showInfo(date) {
            const info = {
                <% for (Map.Entry<String, String> entry : shiftData.entrySet()) { %>
                    "<%= entry.getKey() %>": "<%= entry.getValue() %>",
                <% } %>
            };
            const infoBox = document.getElementById("info");
            infoBox.innerHTML = date + " のシフト情報: " + (info[date] || "データなし");
        }
    </script>
</body>
</html>
