package util;

import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

import org.apache.http.HttpResponse;

import com.google.gson.JsonObject;

import model.PushSubscription;
import nl.martijndwars.webpush.PushService;

public class PushSender {
    private static final String PUBLIC_KEY = "YOUR_PUBLIC_VAPID_KEY";
    private static final String PRIVATE_KEY = "YOUR_PRIVATE_VAPID_KEY";
    private static final String SUBJECT = "mailto:your-email@example.com";

    public static void send(PushSubscription sub, String title, String message) {
        try {
            PushService pushService = new PushService(PUBLIC_KEY, PRIVATE_KEY, SUBJECT);

            // メッセージをJSONとして作成
            JsonObject payload = new JsonObject();
            payload.addProperty("title", title);
            payload.addProperty("message", message);

            byte[] jsonBytes = payload.toString().getBytes(StandardCharsets.UTF_8);
            byte[] userAuth = Base64.getUrlDecoder().decode(sub.getAuth());
            byte[] userPublicKeyBytes = Base64.getUrlDecoder().decode(sub.getP256dh());

            // PublicKey に変換
            KeyFactory keyFactory = KeyFactory.getInstance("EC");
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(userPublicKeyBytes);
            PublicKey userPublicKey = keyFactory.generatePublic(keySpec);

            // 通知の作成
            nl.martijndwars.webpush.Notification notification = new nl.martijndwars.webpush.Notification(
                sub.getEndpoint(),
                userPublicKey,
                userAuth,
                jsonBytes
            );

            HttpResponse response = pushService.send(notification);
            System.out.println("Push Notification Sent: " + response.getStatusLine());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
