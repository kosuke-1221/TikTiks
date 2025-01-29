package service;

import java.util.List;

import dao.PushSubscriptionDao;
import model.PushSubscription;
import util.PushSender;

public class PushNotificationService {
    public void sendNotificationToAll(String title, String message) {
        PushSubscriptionDao subscriptionDao = new PushSubscriptionDao();
        List<PushSubscription> subscriptions = subscriptionDao.getAllSubscriptions();

        for (PushSubscription sub : subscriptions) {
            PushSender.send(sub, title, message);
        }
    }
}
