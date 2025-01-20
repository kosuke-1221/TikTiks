package main;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.VacationRequest;
import dao.VacationDao;

/**
 * 休暇申請を処理するアクション
 */
@WebServlet("/submitVacation")
public class VacationAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // リクエストからJSONデータを取得
        String jsonData = request.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);

        // JSONデータを解析してVacationRequestリストを生成
        List<VacationRequest> vacationRequests = VacationRequest.parseFromJsonString(jsonData);

        VacationDao vacationDao = new VacationDao();
        boolean allInserted = true;

        // データベースに挿入
        for (VacationRequest requestData : vacationRequests) {
            boolean success = vacationDao.insertVacationRequest(requestData);
            if (!success) {
                allInserted = false;
                break;
            }
        }

        // レスポンス
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (allInserted) {
            String responseJson = "{ \"success\": true, \"message\": \"休暇申請が正常に送信されました。\" }";
            out.print(responseJson);
        } else {
            String responseJson = "{ \"success\": false, \"message\": \"休暇申請の送信に失敗しました。\" }";
            out.print(responseJson);
        }

        out.flush();
    }
}
