package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.User;

public class UserDao {

    /**
     * ユーザー情報を登録するメソッド
     * @param user 登録するユーザー情報
     * @return 登録成功ならtrue、それ以外はfalse
     */
    public boolean insert(User user) {
        String sql = "INSERT INTO users (user_id, name, furigana, email, password, phone_number, authority) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getUserID());
            statement.setString(2, user.getName());
            statement.setString(3, user.getFurigana());
            statement.setString(4, user.getEmail());
            statement.setString(5, user.getPassword());
            statement.setString(6, user.getPhoneNumber());
            statement.setBoolean(7, user.isAuthority()); // authorityをbooleanで設定

            int result = statement.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * ユーザーIDに基づいてユーザー情報を取得するメソッド
     * @param userID ユーザーID
     * @return ユーザー情報のUserオブジェクト
     * @throws SQLException
     */
    public User getUserByUserID(String userID) throws SQLException {
        User user = null;
        String sql = "SELECT * FROM users WHERE user_id = ?"; // ユーザーIDで検索するSQL文

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // パラメータをセット
            stmt.setString(1, userID);

            // クエリを実行
            ResultSet rs = stmt.executeQuery();

            // 結果を取得
            if (rs.next()) {
                user = new User();
                user.setUserID(rs.getString("user_id"));
                user.setName(rs.getString("name"));
                user.setFurigana(rs.getString("furigana"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setAuthority(rs.getBoolean("authority"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ユーザー情報の取得に失敗しました。", e);
        }

        return user; // ユーザー情報を返す
    }

    /**
     * ユーザーID、メールアドレス、電話番号の重複を確認するメソッド
     * @param userID ユーザーID
     * @param email メールアドレス
     * @param phoneNumber 電話番号
     * @return 重複があればtrue、それ以外はfalse
     */
    public boolean isUserExists(String userID, String email, String phoneNumber) {
        String sql = "SELECT COUNT(*) FROM users WHERE user_id = ? OR email = ? OR phone_number = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // パラメータをセット
            stmt.setString(1, userID);
            stmt.setString(2, email);
            stmt.setString(3, phoneNumber);

            // クエリを実行
            ResultSet rs = stmt.executeQuery();

            // 結果を取得
            if (rs.next()) {
                return rs.getInt(1) > 0; // 1以上なら重複あり
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false; // 重複なし
    }
}
