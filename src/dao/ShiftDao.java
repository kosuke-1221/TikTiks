package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.ShiftCount;
import bean.ShiftDetail;

public class ShiftDao {
    public List<ShiftCount> getShiftCounts() throws ClassNotFoundException {
        List<ShiftCount> shiftCounts = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT shift_date, COUNT(*) AS count FROM shifts GROUP BY shift_date";

        try {
            con = Database.getConnection(); // Databaseクラスは既存の実装に合わせてください
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                ShiftCount sc = new ShiftCount();
                sc.setDate(rs.getDate("shift_date").toString());
                sc.setCount(rs.getInt("count"));
                shiftCounts.add(sc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return shiftCounts;
    }

    public List<ShiftDetail> getAllShiftDetails() throws ClassNotFoundException {
        List<ShiftDetail> details = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        // ユーザー名を取得するため users テーブルとJOIN
        String sql = "SELECT s.user_id, s.shift_date, s.start_time, s.end_time, s.note, u.user_name " +
                     "FROM shifts s JOIN users u ON s.user_id = u.user_id ORDER BY s.shift_date";
        try {
            con = Database.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                ShiftDetail sd = new ShiftDetail();
                sd.setUserId(rs.getString("user_id"));
                sd.setShiftDate(rs.getDate("shift_date").toString());
                sd.setStartTime(rs.getTime("start_time").toString());
                sd.setEndTime(rs.getTime("end_time").toString());
                sd.setNote(rs.getString("note"));
                sd.setUserName(rs.getString("user_name"));
                details.add(sd);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return details;
    }
}