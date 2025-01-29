package main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.News;
import dao.NewsDao;
import service.PushNotificationService;
import tool.Action;

public class NewsAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	NewsDao newsDao = new NewsDao();

        // お知らせ一覧を取得してリクエストにセット
        List<News> notifications = newsDao.getAllNotifications();
        request.setAttribute("notifications", notifications);

    	// フォームからタイトルとメッセージを取得
        String title = request.getParameter("title");
        String message = request.getParameter("message");

        // 入力チェック
        if (title == null || title.isEmpty() || message == null || message.isEmpty()) {
            request.setAttribute("errorMessage", "タイトルとメッセージの両方を入力してください。");
            request.getRequestDispatcher("/Main/news.jsp").forward(request, response);
            return null; // フォワード後はreturn nullで次の処理を実行しない
        }


        // DAOを使用してデータベースに保存
        try {
        	News news = new News(title, message);
            boolean success = newsDao.insert(news);

            if (success) {

		 // プッシュ通知送信
           	PushNotificationService pushService = new PushNotificationService();
           	pushService.sendNotificationToAll(title, message);

                notifications = newsDao.getAllNotifications();
                request.setAttribute("notifications", notifications);

                request.getRequestDispatcher("/Main/news.jsp").forward(request, response);
                return null; // フォワード後はreturn nullで次の処理を実行しない
            } else {
                request.setAttribute("errorMessage", "お知らせの登録に失敗しました。");
                request.getRequestDispatcher("/Main/news.jsp").forward(request, response);
                return null; // フォワード後はreturn nullで次の処理を実行しない
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "データベースエラーが発生しました: " + e.getMessage());
            request.getRequestDispatcher("/Main/news.jsp").forward(request, response);
            return null; // フォワード後はreturn nullで次の処理を実行しない
        }
    }
}
