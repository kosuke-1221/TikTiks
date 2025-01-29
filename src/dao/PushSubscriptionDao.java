package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.PushSubscription;

public class PushSubscriptionDao {
    public List<PushSubscription> getAllSubscriptions() throws SQLException {
        String sql = "SELECT * FROM push_subscriptions";
        List<PushSubscription> subscriptions = new ArrayList<>();

        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                subscriptions.add(new PushSubscription(
                    resultSet.getString("endpoint"),
                    resultSet.getString("p256dh"),
                    resultSet.getString("auth")
                ));
            }
        }
        return subscriptions;
    }
}
