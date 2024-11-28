package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    // サーバーモードのH2データベース接続情報
    private static final String URL = "jdbc:h2:tcp://localhost/~/NSM"; // サーバーモード用の接続URL
    private static final String USER = "sa";            // デフォルトのユーザー名
    private static final String PASSWORD = "";          // デフォルトではパスワードなし

    // データベース接続を取得するメソッド
    public static Connection getConnection() throws SQLException {
        try {
            // H2データベースドライバをロード (必要に応じて)
            Class.forName("org.h2.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("データベースドライバが見つかりませんでした。");
        }

        // 接続を返す
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
