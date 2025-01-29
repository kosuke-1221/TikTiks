package model;

public class PushSubscription {
    private String endpoint;
    private String p256dh;
    private String auth;

    // コンストラクタ
    public PushSubscription(String endpoint, String p256dh, String auth) {
        this.endpoint = endpoint;
        this.p256dh = p256dh;
        this.auth = auth;
    }

    // ゲッター
    public String getEndpoint() {
        return endpoint;
    }

    public String getP256dh() {
        return p256dh;
    }

    public String getAuth() {
        return auth;
    }

    // セッター
    public void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    public void setP256dh(String p256dh) {
        this.p256dh = p256dh;
    }

    public void setAuth(String auth) {
        this.auth = auth;
    }
}
