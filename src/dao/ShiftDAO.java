package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.shift;

public class ShiftDAO {
    private static final String URL = "jdbc:h2:~/NikoNikoShiftMagic";
    private static final String USER = "sa";
    private static final String PASSWORD = "";

    // データベース接続
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // シフト情報をデータベースから取得
    public List<shift> getShifts(int month, int year) {
        List<shift> shifts = new ArrayList<>();
        String query = "SELECT DATE, SHIFT_TIME, EMPLOYEE_NAME FROM SHIFTS WHERE MONTH(DATE) = ? AND YEAR(DATE) = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, month);
            pstmt.setInt(2, year);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String date = rs.getString("DATE");
                String shiftTime = rs.getString("SHIFT_TIME");
                String employeeName = rs.getString("EMPLOYEE_NAME");
                shifts.add(new shift(date, shiftTime, employeeName));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shifts;
    }
}
