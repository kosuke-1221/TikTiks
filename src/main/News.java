package main;
import java.io.IOException;
import java.util.List; // List 型をインポート

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Notification; // Notification クラスをインポート
import dao.NotificationDAO;


@WebServlet("/news")
public class News extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // データベースからお知らせを取得
        List<Notification> notifications = NotificationDAO.getAllNotifications();
        request.setAttribute("notifications", notifications);

        // JSPに転送
        RequestDispatcher dispatcher = request.getRequestDispatcher("/news.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 管理者のみが登録できる
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if ("admin".equals(role)) {
            String title = request.getParameter("title");
            String message = request.getParameter("message");

            // お知らせをデータベースに保存
            NotificationDAO.saveNotification(new Notification(title, message));

            // リダイレクトして表示ページに戻す
            response.sendRedirect("news");
        } else {
            // 権限がない場合はリダイレクト
            response.sendRedirect("login");
        }
    }
}
