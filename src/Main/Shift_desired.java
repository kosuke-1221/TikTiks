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

@WebServlet("/Shift_desiredServlet")
public class Shift_desired extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // データベース接続情報（必要に応じて修正）
    private static final String DB_URL = "jdbc:h2:~/NikoNikoShiftMagic";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // フォームデータを取得
        String userId = request.getParameter("user_id"); // 従業員IDはセッションなどから取得
        String dayWeek = request.getParameter("day_week");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String memo = request.getParameter("memo");

        // データベースに保存
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO shift_requests (user_id, day_week, start_time, end_time, memo) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, userId);
                pstmt.setString(2, dayWeek);
                pstmt.setString(3, startTime);
                pstmt.setString(4, endTime);
                pstmt.setString(5, memo);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データベースエラーが発生しました。");
            return;
        }

        // 成功時のリダイレクト
        response.sendRedirect("send_complete.jsp");
    }
}
