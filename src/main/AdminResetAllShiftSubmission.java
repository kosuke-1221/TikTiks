package main;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import dao.Database;
import javax.servlet.RequestDispatcher;

@WebServlet("/AdminResetAllShiftSubmission")
public class AdminResetAllShiftSubmission extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            Class.forName("org.h2.Driver");
            conn = Database.getConnection();
            
            // 全スタッフの SHIFT_REQUESTS をリセット（削除）する
            String deleteSQL = "DELETE FROM SHIFT_REQUESTS";
            ps = conn.prepareStatement(deleteSQL);
            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "エラーが発生しました。");
        } finally {
            try { if(ps != null) ps.close(); } catch(Exception e) { }
            try { if(conn != null) conn.close(); } catch(Exception e) { }
        }
        // リセット完了画面へフォワードし、自動で戻る仕組みにする
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Main/Reset_Completion.jsp");
        dispatcher.forward(request, response);
    }
}
