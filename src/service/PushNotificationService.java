package service;

import java.util.List;

import bean.Notification;
import dao.PushSubscriptionDao;


public class PushNotificationService {
    private PushSubscriptionDao pushSubscriptionDao;

    public PushNotificationService() {
        this.pushSubscriptionDao = new PushSubscriptionDao();
    }

    public void sendNotificationToAll(String title, String message) {
        List<Notification> notifications = pushSubscriptionDao.getAllNotifications(); // 全ての通知情報を取得

        for (Notification notification : notifications) {
            // 取得した通知情報を使用して通知を作成
            notification.setTitle(title);
            notification.setMessage(message);

            // 通知情報をデータベースに保存
            pushSubscriptionDao.saveNotification(notification);
        }
    }



}
