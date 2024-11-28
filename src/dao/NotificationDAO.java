package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import bean.Notification; // Notification クラスをインポート


public class NotificationDAO {
    private static final String URL = "jdbc:h2:~/NikoNikoShiftMagic";
    private static final String USER = "sa";
    private static final String PASSWORD = "";

    // データベースから全お知らせを取得
    public static List<Notification> getAllNotifications() {
        List<Notification> notifications = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String query = "SELECT * FROM news ORDER BY created_at DESC";
            try (Statement statement = connection.createStatement();
                 ResultSet resultSet = statement.executeQuery(query)) {
                while (resultSet.next()) {
                    String title = resultSet.getString("title");
                    String message = resultSet.getString("message");
                    Timestamp createdAt = resultSet.getTimestamp("created_at");

                    notifications.add(new Notification(title, message, createdAt));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    // お知らせをデータベースに保存
    public static void saveNotification(Notification notification) {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String query = "INSERT INTO news (title, message) VALUES (?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, notification.getTitle());
                statement.setString(2, notification.getMessage());
                statement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
