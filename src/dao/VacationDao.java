package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bean.VacationRequest;

public class VacationDao {

    // データベース接続情報
    private static final String JDBC_URL = "jdbc:h2:~/NSM"; // データベースのURLを設定
    private static final String DB_USER = "sa"; // ユーザー名
    private static final String DB_PASSWORD = ""; // パスワード

    /**
     * 休暇申請をデータベースに挿入するメソッド
     *
     * @param request VacationRequest オブジェクト
     * @return 挿入成功なら true、失敗なら false
     */
    public boolean insertVacationRequest(VacationRequest request) {
        String sql = "INSERT INTO vacation_requests (user_id, vacation_date, reason) VALUES (?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // パラメータを設定
            pstmt.setString(1, request.getUserId());
            pstmt.setString(2, request.getVacationDate());
            pstmt.setString(3, request.getReason());

            // 実行
            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
