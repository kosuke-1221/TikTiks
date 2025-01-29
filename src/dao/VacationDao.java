package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.VacationRequest;

public class VacationDao {

    // データベース接続情報
    private static final String JDBC_URL = "jdbc:h2:tcp://localhost/~/NSM"; // データベースのURLを設定
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

        try {
            // JDBCドライバのロード
            Class.forName("org.h2.Driver");  // H2ドライバをロード

            // データベース接続
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, request.getUserId());
                pstmt.setString(2, request.getVacationDate());
                pstmt.setString(3, request.getReason());

                // 実行
                int rowsInserted = pstmt.executeUpdate();
                return rowsInserted > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 休暇申請を全て取得するメソッド
     *
     * @return 休暇申請のリスト
     */
    public List<VacationRequest> getAllVacationRequests() {
        List<VacationRequest> vacationRequests = new ArrayList<>();
        String sql = "SELECT vr.vacation_date, u.name, vr.reason, u.phone_number FROM vacation_requests vr JOIN users u ON vr.user_id = u.user_id";

        try {
            // JDBCドライバのロード
            Class.forName("org.h2.Driver");  // H2ドライバをロード

            // データベース接続
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VacationRequest request = new VacationRequest();
                    request.setVacationDate(rs.getString("vacation_date"));
                    request.setUserName(rs.getString("name"));
                    request.setReason(rs.getString("reason"));
                    request.setPhoneNumber(rs.getString("phone_number"));
                    vacationRequests.add(request);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vacationRequests;
    }
}