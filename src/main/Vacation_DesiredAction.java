package main;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.VacationRequest;
import dao.VacationDAO2;

@WebServlet("/Main/Vacation_DesiredAction")
public class Vacation_DesiredAction extends HttpServlet {
    private VacationDAO2 vacationDAO = new VacationDAO2();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // セッションから user_id を取得
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("user_id");

        if (userId == null) {
            // セッションが切れている場合の処理
            session.setAttribute("errorMessage", "セッションが切れています。再度ログインしてください。");
            response.sendRedirect("login.jsp");
            return;
        }

        // hiddenフィールドから休暇希望日と理由を取得
        String[] vacationDates = request.getParameter("vacation-dates").split(",");
        String[] vacationReasons = request.getParameter("vacation-reasons").split(",");

        if (vacationDates != null && vacationReasons != null && vacationDates.length == vacationReasons.length) {
            // データベースに登録
            try {
                for (int i = 0; i < vacationDates.length; i++) {
                    VacationRequest vacationRequest = new VacationRequest(userId, vacationDates[i], vacationReasons[i]);
                    vacationDAO.insertVacationRequest(vacationRequest);
                }
                session.setAttribute("successMessage", "休暇希望が送信されました。");
                response.sendRedirect("confirmation.jsp");  // 確認ページにリダイレクト
            } catch (Exception e) {
                session.setAttribute("errorMessage", "休暇希望の送信に失敗しました。");
                response.sendRedirect("error.jsp");  // エラーページにリダイレクト
            }
        } else {
            session.setAttribute("errorMessage", "休暇希望日と理由が一致しません。");
            response.sendRedirect("error.jsp");
        }
    }
}
