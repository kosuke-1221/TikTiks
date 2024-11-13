package bean;

public class User {
    private String username;
    private String role; // ユーザーの役割

    // コンストラクタ
    public User(String username, String role) {
        this.username = username;
        this.role = role;
    }

    // getterメソッド
    public String getUsername() {
        return username;
    }

    public String getRole() {
        return role;
    }

    // setterメソッド（必要に応じて）
    public void setUsername(String username) {
        this.username = username;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
