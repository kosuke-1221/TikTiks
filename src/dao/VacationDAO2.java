package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bean.VacationRequest;

public class VacationDAO2 {
    private static final String DB_URL = "jdbc:h2:tcp://localhost/~/NSM";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "";

    // DB接続メソッド
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // 休暇希望日をDBに登録する
    public void insertVacationRequest(VacationRequest request) throws SQLException {
        String sql = "INSERT INTO vacation_requests (user_id, vacation_date, reason) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, request.getUserId());
            stmt.setString(2, request.getVacationDate());
            stmt.setString(3, request.getReason());
            stmt.executeUpdate();
        }
    }
}
