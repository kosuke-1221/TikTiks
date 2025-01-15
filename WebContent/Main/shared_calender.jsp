<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>にこにこシフトマジック</title>
<link href="shared_calender.css" rel="stylesheet" />
</head>
<body>
<c:import url="base.jsp">
<c:param name="title"></c:param>
<c:param name="scripts"></c:param>
<c:param name="content">
<section class="calendar-section">
<h1>😊共有カレンダー😊</h1>


                <%
                    // JDBC接続設定
                    String jdbcURL = "jdbc:h2:~/NSM";  // H2データベースのURL
                    String dbUser = "sa";  // H2のデフォルトユーザー名
                    String dbPassword = "";  // H2のデフォルトパスワード（空の場合）

                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    Map<String, String> shiftInfo = new HashMap<>(); // シフト情報を格納するMap

                    try {
                        // H2データベース接続
                        Class.forName("org.h2.Driver");  // H2のJDBCドライバをロード
                        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        // シフト情報を取得するSQLクエリ
                        String sql = "SELECT DATE, SHIFT_TIME, EMPLOYEE_NAME FROM SHIFTS";
                        pstmt = conn.prepareStatement(sql);

                        rs = pstmt.executeQuery();
                        while (rs.next()) {
                            String date = rs.getString("DATE");
                            String shiftTime = rs.getString("SHIFT_TIME");
                            String employeeName = rs.getString("EMPLOYEE_NAME");

                            shiftInfo.put(date, "シフト: " + shiftTime + ", 担当者: " + employeeName);  // シフト情報をMapに格納
                        }

                        request.setAttribute("shiftInfo", shiftInfo);  // シフト情報をリクエスト属性に設定
                    } catch (Exception e) {
                        e.printStackTrace();  // エラーハンドリング
                    } finally {
                        // リソースを閉じる
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();  // エラーハンドリング
                        }
                    }
                %>

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

                    // 月の表示名
                    String[] months = {"1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"};
                    String currentMonth = months[month];
                %>

                <div class="select-form-container">
<form method="get" class="select-month">
<label for="month">月を選択:</label>
<input type="number" name="month" min="1" max="12" value="<%= selectedMonth %>" onchange="this.form.submit()">
</form>

                    <form method="get" class="select-day">
<label for="day">日にちを選択:</label>
<input type="number" name="day" min="1" max="<%= daysInMonth %>" value="<%= selectedDay %>" onchange="this.form.submit()">
<input type="hidden" name="month" value="<%= selectedMonth %>">
</form>
</div>

                <h2><%= currentMonth %></h2>

                <table class="calendar-table">
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

                                        if (day == today) { out.print(" class='today'"); }

                                        out.print(" onclick='showInfo(\"" + dateKey + "\")'>");
                                        out.print(day);

                                        // データベースから取得したシフト情報を表示
                                        if (shiftInfo.containsKey(dateKey)) {
                                            String shiftDetails = shiftInfo.get(dateKey);
                                            out.print("<br><small>" + shiftDetails + "</small>");
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

                <div id="info">日付をクリックするとシフト情報が表示されます。</div>

                <script>
                    // シフト情報をJSPで設定されたshiftInfoオブジェクトに基づいて表示
                    const shiftInfo = ${shiftInfo};  // requestで渡されたshiftInfoマップ

                    function showInfo(date) {
                        const infoBox = document.getElementById("info");

                        if (shiftInfo[date]) {
                            infoBox.innerHTML = shiftInfo[date];  // シフト情報を表示
                        } else {
                            infoBox.innerHTML = "シフト情報はありません";  // データがない場合
                        }
                        infoBox.style.display = "block";  // 情報ボックスを表示
                    }

                    window.onload = function() {
                        const selectedDay = "<%= selectedDay %>";
                        const selectedMonth = "<%= selectedMonth %>";
                        const currentYear = "<%= year %>";
                        const dateKey = currentYear + "-" + selectedMonth + "-" + selectedDay;
                        showInfo(dateKey);
                    };
</script>
</section>
</c:param>
</c:import>
</body>
</html>