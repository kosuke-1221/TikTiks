package bean;

public class Notification {
    private String endpoint;
    private byte[] p256dh;
    private byte[] auth;
    private byte[] payload; // 例：プッシュ通知のペイロード（必要な場合）
    private String title; // 通知のタイトル
    private String message; // 通知のメッセージ

    // 引数を持つコンストラクタ
    public Notification(String endpoint, byte[] p256dh, byte[] auth, byte[] payload, String title, String message) {
        this.endpoint = endpoint;
        this.p256dh = p256dh;
        this.auth = auth;
        this.payload = payload;
        this.title = title;
        this.message = message;
    }

    // 引数なしのコンストラクタ（必要に応じて）
    public Notification() {}

    // ゲッターとセッター
    public String getEndpoint() {
        return endpoint;
    }

    public void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    public byte[] getP256dh() {
        return p256dh;
    }

    public void setP256dh(byte[] p256dh) {
        this.p256dh = p256dh;
    }

    public byte[] getAuth() {
        return auth;
    }

    public void setAuth(byte[] auth) {
        this.auth = auth;
    }

    public byte[] getPayload() {
        return payload;
    }

    public void setPayload(byte[] payload) {
        this.payload = payload;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
