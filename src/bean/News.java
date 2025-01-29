package bean;

import java.sql.Timestamp;
import java.time.Instant;

public class News {
    private String title;
    private String message;
    private Timestamp createdAt;

    public News(String title, String message) {
        this.title = title;
        this.message = message;
        this.createdAt = Timestamp.from(Instant.now()); // 現在時刻を設定
    }

    public News(String title, String message, Timestamp createdAt) {
        this.title = title;
        this.message = message;
        this.createdAt = createdAt;
    }

    // Getter and Setter
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "News{" +
               "title='" + title + '\'' +
               ", message='" + message + '\'' +
               ", createdAt=" + createdAt +
               '}';
    }
}
