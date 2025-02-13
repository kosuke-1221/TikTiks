package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import bean.Calendar;

public class CalendarDao {
    private static final String URL = "jdbc:h2:tcp://localhost/~/NSM";
    private static final String USER = "sa";
    private static final String PASSWORD = "";

    public List<Calendar> getShiftsByUser(String userId) {
        List<Calendar> shiftList = new ArrayList<>();
        String sql = "SELECT shift_date, start_time, end_time, note FROM shifts WHERE user_id = ? ORDER BY shift_date";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userId);
            System.out.println("SQL 実行: " + stmt); // SQL ログ出力

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Calendar shift = new Calendar();
                shift.setUserId(userId);
                shift.setShiftDate(rs.getString("shift_date"));

                // start_time, end_time の処理を確認
                String startTimeStr = rs.getString("start_time");
                String endTimeStr = rs.getString("end_time");
                if (startTimeStr != null) {
                    System.out.println("start_time: " + startTimeStr);
                    shift.setStartTime(LocalTime.parse(startTimeStr));
                }
                if (endTimeStr != null) {
                    System.out.println("end_time: " + endTimeStr);
                    shift.setEndTime(LocalTime.parse(endTimeStr));
                }

                shift.setNote(rs.getString("note"));
                shiftList.add(shift);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("取得したシフトデータ: " + shiftList);
        return shiftList;
    }

}
