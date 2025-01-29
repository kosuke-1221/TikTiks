package util;

import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.util.Base64;

import org.apache.http.HttpResponse;

import com.google.gson.JsonObject;

import bean.Notification; // bean.Notificationをインポート
import model.PushSubscription;
import nl.martijndwars.webpush.PushService;

public class PushSender {
    private static final String PUBLIC_KEY = "YOUR_PUBLIC_VAPID_KEY";
    private static final String PRIVATE_KEY = "YOUR_PRIVATE_VAPID_KEY";
    private static final String SUBJECT = "mailto:your-email@example.com";

    public static void send(PushSubscription sub, String title, String message) {
        try {
            PushService pushService = new PushService(PUBLIC_KEY, PRIVATE_KEY, SUBJECT);

            JsonObject payload = new JsonObject();
            payload.addProperty("title", title);
            payload.addProperty("message", message);

            byte[] jsonBytes = payload.toString().getBytes(StandardCharsets.UTF_8);
            byte[] userAuth = Base64.getUrlDecoder().decode(sub.getAuth());
            byte[] userPublicKey = Base64.getUrlDecoder().decode(sub.getP256dh());

            // Notificationクラスのインスタンスを作成
            Notification notification = new Notification(
                sub.getEndpoint(),
                userPublicKey,
                userAuth,
                jsonBytes
            );

            HttpResponse response = pushService.send(notification);
            System.out.println("Push Notification Sent: " + response.getStatusLine());
        } catch (GeneralSecurityException | Exception e) {
            e.printStackTrace();
        }
    }
}
