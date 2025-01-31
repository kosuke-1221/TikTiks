package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bean.Notification;

public class NotificationDao {
    // DB接続を取得
    private Connection connection;

    public NotificationDao() {
        try {
            this.connection = Database.getConnection();  // Databaseクラスを使用して接続
        } catch (SQLException e) {
            e.printStackTrace();  // エラーログを出力
            // 必要に応じて処理を追加
        }
    }

    // 通知をDBに保存
    public void save(Notification notification) {
        String query = "INSERT INTO push_subscriptions (endpoint, p256dh, auth, payload) VALUES (?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, notification.getEndpoint());
            statement.setBytes(2, notification.getP256dh());
            statement.setBytes(3, notification.getAuth());
            statement.setBytes(4, notification.getPayload());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
