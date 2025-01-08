package main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NewsDao;
import tool.Action;

public class DeleteNewsAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String newsId = request.getParameter("newsId");

        if (newsId == null || newsId.isEmpty()) {
            request.setAttribute("errorMessage", "削除するお知らせのIDがありません。");
            request.getRequestDispatcher("/Main/news.jsp").forward(request, response);
            return null;
        }

        NewsDao newsDao = new NewsDao();

        try {
            // お知らせIDを基に削除処理
            boolean success = newsDao.delete(Integer.parseInt(newsId));

            if (success) {
                // 削除後に最新のお知らせ一覧を取得して表示
                request.setAttribute("notifications", newsDao.getAllNotifications());
                request.getRequestDispatcher("/Main/news.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "お知らせの削除に失敗しました。");
                request.getRequestDispatcher("/Main/news.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "削除中にエラーが発生しました: " + e.getMessage());
            request.getRequestDispatcher("/Main/news.jsp").forward(request, response);
        }

        return null;
    }
}
