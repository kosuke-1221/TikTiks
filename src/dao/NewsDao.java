package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.News;

public class NewsDao {

    // お知らせをデータベースに登録するメソッド
    public boolean insert(News news) throws SQLException {
        String sql = "INSERT INTO news (title, message, created_at) VALUES (?, ?, CURRENT_TIMESTAMP)";

        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, news.getTitle());
            statement.setString(2, news.getMessage());

            int result = statement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("お知らせの登録に失敗しました。", e);
        }
    }

    // 全てのお知らせを取得するメソッド
    public List<News> getAllNotifications() throws SQLException {
        String sql = "SELECT * FROM news ORDER BY created_at DESC";
        List<News> notifications = new ArrayList<>();

        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                News notification = new News(
                    resultSet.getString("title"),
                    resultSet.getString("message"),
                    resultSet.getTimestamp("created_at")
                );
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("お知らせの取得に失敗しました。", e);
        }

        return notifications;
    }
    // 削除機能
    public boolean delete(int newsId) throws SQLException {
        String sql = "DELETE FROM news WHERE id = ?";
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, newsId);
            int rowsAffected = statement.executeUpdate();

            return rowsAffected > 0; // 削除が成功した場合、1以上が返る
        }
    }
}
