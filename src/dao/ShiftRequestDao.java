package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.ShiftRequest;

public class ShiftRequestDao {
    public void insertShift(String userId, String shiftDate, String startTime, String endTime, String note) throws ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        String sql = "INSERT INTO shifts (user_id, shift_date, start_time, end_time, note) VALUES (?, ?, ?, ?, ?)";

        try {
            con = Database.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, userId);
            ps.setDate(2, java.sql.Date.valueOf(shiftDate));
            ps.setTime(3, java.sql.Time.valueOf(startTime + ":00"));
            ps.setTime(4, java.sql.Time.valueOf(endTime + ":00"));
            ps.setString(5, note);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void deleteShift(String userId, String shiftDate, String startTime) throws ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        String sql = "DELETE FROM shifts WHERE user_id = ? AND shift_date = ? AND start_time = ?";
        try {
            con = Database.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, userId);
            ps.setDate(2, java.sql.Date.valueOf(shiftDate));
            // startTime が "HH:mm" の場合は秒を追加し、"HH:mm:ss" ならそのまま利用
            String formattedStartTime = (startTime != null && startTime.trim().length() == 5) ? startTime + ":00" : startTime;
            ps.setTime(3, java.sql.Time.valueOf(formattedStartTime));
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<ShiftRequest> getAvailableShifts() throws ClassNotFoundException {
        List<ShiftRequest> shifts = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM SHIFT_REQUESTS";

        try {
            con = Database.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                ShiftRequest shift = new ShiftRequest();
                shift.setUserId(rs.getString("user_id"));
                shift.setSelectedDays(rs.getString("selected_days"));
                shift.setMondayStartTime(rs.getString("monday_start_time"));
                shift.setMondayEndTime(rs.getString("monday_end_time"));
                shift.setTuesdayStartTime(rs.getString("tuesday_start_time"));
                shift.setTuesdayEndTime(rs.getString("tuesday_end_time"));
                shift.setWednesdayStartTime(rs.getString("wednesday_start_time"));
                shift.setWednesdayEndTime(rs.getString("wednesday_end_time"));
                shift.setThursdayStartTime(rs.getString("thursday_start_time"));
                shift.setThursdayEndTime(rs.getString("thursday_end_time"));
                shift.setFridayStartTime(rs.getString("friday_start_time"));
                shift.setFridayEndTime(rs.getString("friday_end_time"));
                shift.setSaturdayStartTime(rs.getString("saturday_start_time"));
                shift.setSaturdayEndTime(rs.getString("saturday_end_time"));
                shift.setSundayStartTime(rs.getString("sunday_start_time"));
                shift.setSundayEndTime(rs.getString("sunday_end_time"));
                shift.setAlwaysAvailable(rs.getBoolean("always_available"));
                shift.setMemo(rs.getString("memo"));
                shifts.add(shift);
            }
            return shifts;
        } catch (SQLException e) {
            e.printStackTrace();
            return shifts;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}