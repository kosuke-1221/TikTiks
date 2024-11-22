package Main;
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

@WebServlet("/ShiftRequestServlet")
public class Shift_desired extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // データベース接続情報（必要に応じて修正）
    private static final String DB_URL = "jdbc:h2:~/NikoNikoShiftMagic";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // フォームデータを取得
        String employeeId = request.getParameter("employee_id"); // 従業員IDはセッションなどから取得
        String dayOfWeek = request.getParameter("day_of_week");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String comments = request.getParameter("comments");

        // データベースに保存
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO shift_requests (employee_id, day_of_week, start_time, end_time, comments) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, employeeId);
                pstmt.setString(2, dayOfWeek);
                pstmt.setString(3, startTime);
                pstmt.setString(4, endTime);
                pstmt.setString(5, comments);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データベースエラーが発生しました。");
            return;
        }

        // 管理者への通知（メール送信など）
        notifyAdmin(dayOfWeek, startTime, endTime, comments);

        // 成功時のリダイレクト
        response.sendRedirect("send_complete.jsp");
    }

    // 管理者への通知メソッド（例）
    private void notifyAdmin(String dayOfWeek, String startTime, String endTime, String comments) {
        // メール送信の実装
        /*
        String adminEmail = "admin@example.com";
        String subject = "新しいシフト希望が届きました";
        String message = String.format("希望日: %s\n開始時間: %s\n終了時間: %s\n備考: %s", dayOfWeek, startTime, endTime, comments);

        // メール送信処理を追加
        */
    }
}
