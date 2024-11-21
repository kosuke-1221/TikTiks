<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // 従業員データ
    Map<String, String> workers = new HashMap<>();
    workers.put("山田太郎", "#FFABCE");
    workers.put("鈴木花子", "#CC99CC");
    workers.put("田中一郎", "#999999");
    workers.put("佐藤二郎", "#FF9933");
    workers.put("山本五郎", "#FF8856");
    workers.put("佐々木四郎", "#008080");

    // 作業スケジュール
    Map<String, Map<String, Object>> workSchedule = new HashMap<>();
    Map<String, Object> sampleDay = new HashMap<>();
    sampleDay.put("time", "9:00 - 18:00");
    sampleDay.put("workers", Arrays.asList("山田太郎", "鈴木花子"));
    workSchedule.put("2024-11-02", sampleDay);
    sampleDay.put("time", "9:00 - 18:00");
    sampleDay.put("workers", Arrays.asList("田中一郎", "鈴木花子"));
    workSchedule.put("2024-11-05", sampleDay);
    sampleDay.put("time", "9:00 - 18:00");
    sampleDay.put("workers", Arrays.asList("佐々木四郎", "鈴木花子"));
    workSchedule.put("2024-11-10", sampleDay);

    // 現在の月
    int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1; // 現在の月 (1月は0なので+1)
    try {
        if (request.getParameter("month") != null) {
            currentMonth = Integer.parseInt(request.getParameter("month"));
            if (currentMonth < 1 || currentMonth > 12) {
                currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1; // デフォルト値
            }
        }
    } catch (NumberFormatException e) {
        currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1; // デフォルト値
    }

    // 動的な月の日数計算
    int days = new GregorianCalendar(2024, currentMonth - 1, 1).getActualMaximum(Calendar.DAY_OF_MONTH);
    int firstDay = new GregorianCalendar(2024, currentMonth - 1, 1).get(Calendar.DAY_OF_WEEK) - 1;
%>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>共有カレンダー</title>
    <link rel="stylesheet" href="shared_calender.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
    <h1>😁 共有カレンダー 😁</h1>

    <div class="calendar-container">
        <div class="month-display"><%= currentMonth %>月</div>
    </div>

    <div class="control-panel">
        <label for="month">月を選択: </label>
        <select id="month" onchange="updateCalendar()">
            <% for (int month = 1; month <= 12; month++) { %>
                <option value="<%= month %>" <%= month == currentMonth ? "selected" : "" %>><%= month %>月</option>
            <% } %>
        </select>
    </div>

    <div class="calendar-wrapper">
        <table id="calendar">
            <thead>
                <tr>
                    <th>日</th>
                    <th>月</th>
                    <th>火</th>
                    <th>水</th>
                    <th>木</th>
                    <th>金</th>
                    <th>土</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int currentDay = 1;
                    boolean started = false;

                    for (int i = 0; i < 6; i++) {
                        out.print("<tr>");
                        for (int j = 0; j < 7; j++) {
                            if (!started && j == firstDay) {
                                started = true;
                            }
                            if (started && currentDay <= days) {
                                String date = String.format("2024-%02d-%02d", currentMonth, currentDay);
                                Map<String, Object> workInfo = workSchedule.get(date);

                                out.print("<td onclick='getShiftDetails(\"" + date + "\")'>");
                                out.print(currentDay);

                                if (workInfo != null) {
                                    List<String> assignedWorkers = (List<String>) workInfo.get("workers");
                                    for (String worker : assignedWorkers) {
                                        String color = workers.getOrDefault(worker, "#CCCCCC");
                                        out.print("<div class='worker-name' style='background-color: ");
                                        out.print(color);
                                        out.print("'>");

                                        out.print("</div>");
                                    }
                                }
                                out.print("</td>");
                                currentDay++;
                            } else {
                                out.print("<td></td>");
                            }
                        }
                        out.print("</tr>");
                        if (currentDay > days) break;
                    }
                %>
            </tbody>
        </table>

        <div id="shiftDetail" class="shift-detail">選択した日の詳細: -<br>出勤者: -</div>
    </div>

    <div id="workInfo">選択した日の働く時間: -</div>

    <script>
        function updateCalendar() {
            const month = document.getElementById("month").value;
            window.location.href = "?month=" + month; // ページを選択した月で更新
        }


    </script>
</body>

</html>
