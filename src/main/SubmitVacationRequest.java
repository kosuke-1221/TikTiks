package main;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SubmitVacationRequest")
public class SubmitVacationRequest extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public static void main(String[] args) throws IOException, ServletException {
        // テスト用のエントリポイントとして記載
        System.out.println("SubmitVacationRequest サーブレットが開始されました。");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // リクエストの文字エンコーディングを設定
        request.setCharacterEncoding("UTF-8");

        // フォームからのパラメータ取得
        String vacationDate = request.getParameter("vacationDate");
        String reason = request.getParameter("reason");
        String userId = "123"; // ユーザーIDはセッションや認証情報から取得する想定

        // データベース接続準備
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // データベース接続情報
            String url = "jdbc:h2:~/NSM://localhost:3306/your_database";
            String user = "sa";
            String password = "";

            // データベース接続
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            // SQLクエリ作成
            String sql = "INSERT INTO VACATION_REQUESTS (USER_ID, VACATION_DATE, REASON) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, vacationDate);
            pstmt.setString(3, reason);

            // クエリ実行
            int rowsInserted = pstmt.executeUpdate();

            // 実行結果に応じたメッセージ設定
            if (rowsInserted > 0) {
                request.setAttribute("message", "休暇希望が正常に送信されました。");
            } else {
                request.setAttribute("message", "休暇希望の送信に失敗しました。");
            }
        } catch (ClassNotFoundException | SQLException e) {
            // エラーハンドリング
            e.printStackTrace();
            request.setAttribute("message", "エラーが発生しました: " + e.getMessage());
        } finally {
            // リソースのクローズ
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // 結果をJSPへフォワード
        request.getRequestDispatcher("Vacation_Desired_Date.jsp").forward(request, response);
    }
}
