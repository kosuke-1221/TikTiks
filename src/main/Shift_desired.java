package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Main/Shift_desiredServlet")
public class Shift_desired extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // データベース接続情報（必要に応じて修正）
    private static final String DB_URL = "jdbc:h2:tcp://localhost/~/NSM";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // フォームデータを取得
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userID");  // セッションからユーザーIDを取得

        // ユーザーIDがセッションに存在しない場合、エラーを表示
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "ログインしていません。");
            return;
        }

        // 追加: すでにシフト希望が提出済みか確認し、提出済みならリダイレクト
        try {
            Class.forName("org.h2.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM SHIFT_REQUESTS WHERE user_id = ?")) {
                ps.setString(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        response.sendRedirect("shift_alreadySubmitted.jsp");
                        return;
                    }
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        }

        // 曜日ごとの選択状態を取得し、選択された曜日をカンマ区切りでまとめる
        StringBuilder selectedDays = new StringBuilder();

        if (request.getParameter("monday") != null) selectedDays.append("Monday,");
        if (request.getParameter("tuesday") != null) selectedDays.append("Tuesday,");
        if (request.getParameter("wednesday") != null) selectedDays.append("Wednesday,");
        if (request.getParameter("thursday") != null) selectedDays.append("Thursday,");
        if (request.getParameter("friday") != null) selectedDays.append("Friday,");
        if (request.getParameter("saturday") != null) selectedDays.append("Saturday,");
        if (request.getParameter("sunday") != null) selectedDays.append("Sunday,");

        // 最後のカンマを削除
        if (selectedDays.length() > 0) {
            selectedDays.setLength(selectedDays.length() - 1);
        }

        // 曜日ごとの開始・終了時間を取得（選択されていない場合はnullを設定）
        String mondayStart = request.getParameter("monday-start");
        String mondayEnd = request.getParameter("monday-end");
        if (mondayStart == null || mondayEnd == null) {
            mondayStart = null;
            mondayEnd = null;
        }

        String tuesdayStart = request.getParameter("tuesday-start");
        String tuesdayEnd = request.getParameter("tuesday-end");
        if (tuesdayStart == null || tuesdayEnd == null) {
            tuesdayStart = null;
            tuesdayEnd = null;
        }

        String wednesdayStart = request.getParameter("wednesday-start");
        String wednesdayEnd = request.getParameter("wednesday-end");
        if (wednesdayStart == null || wednesdayEnd == null) {
            wednesdayStart = null;
            wednesdayEnd = null;
        }

        String thursdayStart = request.getParameter("thursday-start");
        String thursdayEnd = request.getParameter("thursday-end");
        if (thursdayStart == null || thursdayEnd == null) {
            thursdayStart = null;
            thursdayEnd = null;
        }

        String fridayStart = request.getParameter("friday-start");
        String fridayEnd = request.getParameter("friday-end");
        if (fridayStart == null || fridayEnd == null) {
            fridayStart = null;
            fridayEnd = null;
        }

        String saturdayStart = request.getParameter("saturday-start");
        String saturdayEnd = request.getParameter("saturday-end");
        if (saturdayStart == null || saturdayEnd == null) {
            saturdayStart = null;
            saturdayEnd = null;
        }

        String sundayStart = request.getParameter("sunday-start");
        String sundayEnd = request.getParameter("sunday-end");
        if (sundayStart == null || sundayEnd == null) {
            sundayStart = null;
            sundayEnd = null;
        }


        // "いつでも可能" のチェックボックスを取得
        boolean alwaysAvailable = request.getParameter("always-available") != null;

        // メモを取得
        String memo = request.getParameter("free-reason");

        // データベースに保存
        try {
            // JDBCドライバを手動でロード
            Class.forName("org.h2.Driver"); // H2ドライバのクラスをロード

            // データベース接続
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = "INSERT INTO SHIFT_REQUESTS "
                        + "(user_id, selected_days, monday_start_time, monday_end_time, "
                        + "tuesday_start_time, tuesday_end_time, wednesday_start_time, wednesday_end_time, "
                        + "thursday_start_time, thursday_end_time, friday_start_time, friday_end_time, "
                        + "saturday_start_time, saturday_end_time, sunday_start_time, sunday_end_time, "
                        + "always_available, memo) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, userId);
                    pstmt.setString(2, selectedDays.toString());

                    // 曜日ごとの開始・終了時間をセット
                    pstmt.setString(3, mondayStart);
                    pstmt.setString(4, mondayEnd);
                    pstmt.setString(5, tuesdayStart);
                    pstmt.setString(6, tuesdayEnd);
                    pstmt.setString(7, wednesdayStart);
                    pstmt.setString(8, wednesdayEnd);
                    pstmt.setString(9, thursdayStart);
                    pstmt.setString(10, thursdayEnd);
                    pstmt.setString(11, fridayStart);
                    pstmt.setString(12, fridayEnd);
                    pstmt.setString(13, saturdayStart);
                    pstmt.setString(14, saturdayEnd);
                    pstmt.setString(15, sundayStart);
                    pstmt.setString(16, sundayEnd);
                    pstmt.setBoolean(17, alwaysAvailable);
                    pstmt.setString(18, memo);

                    pstmt.executeUpdate();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データベースエラーが発生しました。");
                return;
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "JDBCドライバが見つかりません。");
            return;
        }

        // 成功時のリダイレクト
        response.sendRedirect("send_complete.jsp");
    }
}
