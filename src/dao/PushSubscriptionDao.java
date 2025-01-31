package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Notification;

public class PushSubscriptionDao {
    private Connection connection;

    public PushSubscriptionDao() {
        try {
            // H2ドライバを手動でロード
            Class.forName("org.h2.Driver");  // ここを追加
            this.connection = Database.getConnection();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();  // エラーログを出力
        }
    }

    // 通知内容をDBに保存
    public void saveNotification(Notification notification) {
        String query = "INSERT INTO push_subscriptions (endpoint, p256dh, auth, payload, title, message) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, notification.getEndpoint());
            statement.setBytes(2, notification.getP256dh());
            statement.setBytes(3, notification.getAuth());
            statement.setBytes(4, notification.getPayload());
            statement.setString(5, notification.getTitle());
            statement.setString(6, notification.getMessage());

            statement.executeUpdate();  // 挿入
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Notification> getAllNotifications() {
        List<Notification> notifications = new ArrayList<>();
        String query = "SELECT endpoint, p256dh, auth, payload FROM push_subscriptions";

        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                String endpoint = resultSet.getString("endpoint");
                byte[] p256dh = resultSet.getBytes("p256dh");
                byte[] auth = resultSet.getBytes("auth");
                byte[] payload = resultSet.getBytes("payload");

                // Notificationオブジェクトを作成してリストに追加
                notifications.add(new Notification(endpoint, p256dh, auth, payload, null, null));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notifications;
    }
}
