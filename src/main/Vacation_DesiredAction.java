package main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.VacationRequest;
import dao.VacationDao;
import tool.Action;  // Actionクラスのインポート

public class Vacation_DesiredAction extends Action { // Actionクラスを継承

    private VacationDao vacationDAO = new VacationDao();

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // セッションから user_id を取得
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userID");

        // ユーザーIDがセッションに存在しない場合、エラーを表示
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "ログインしていません。");
            return null; // 実際にエラーを返して終了
        }

        // hiddenフィールドから休暇希望日と理由を取得
        String[] vacationDates = request.getParameter("vacation-dates").split(",");
        String[] vacationReasons = request.getParameter("vacation-reasons").split(",");

        // デバッグ用の出力
        System.out.println("vacation-dates: " + request.getParameter("vacation-dates"));
        System.out.println("vacation-reasons: " + request.getParameter("vacation-reasons"));

        // 休暇希望日と理由が一致するかを確認
        if (vacationDates != null && vacationReasons != null && vacationDates.length == vacationReasons.length) {
            // データベースに登録
            try {
                for (int i = 0; i < vacationDates.length; i++) {
                    VacationRequest vacationRequest = new VacationRequest(userId, vacationDates[i], vacationReasons[i]);
                    vacationDAO.insertVacationRequest(vacationRequest);
                }
                // 成功した場合はリダイレクト
                response.sendRedirect("send_complete.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                // エラーが発生した場合は元のページにリダイレクト
                response.sendRedirect("/Vacation_Desired_Date.jsp");
            }
        } else {
            // 休暇希望日と理由が一致しない場合
            response.sendRedirect("/Vacation_Desired_Date.jsp");
        }
        return null;
    }
}
