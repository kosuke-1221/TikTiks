package main;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.VacationRequest;
import dao.VacationDao;

@WebServlet("/Main/VacationRequestList")
public class VacationRequestListAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String monthParam = request.getParameter("month");
            final String month;
            if (monthParam != null && monthParam.length() == 1) {
                month = "0" + monthParam; // 月の値を2桁にフォーマット
            } else {
                month = monthParam;
            }
            VacationDao vacationDao = new VacationDao();
            List<VacationRequest> vacationRequests = vacationDao.getAllVacationRequests();

            if (month != null && !month.isEmpty()) {
                vacationRequests = vacationRequests.stream()
                        .filter(vacationRequest -> vacationRequest.getVacationDate().substring(5, 7).equals(month))
                        .collect(Collectors.toList());
            }

            request.setAttribute("vacationRequests", vacationRequests);
            request.setAttribute("selectedMonth", month);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/Main/vacation_request_list.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "システムエラーが発生しました");
            request.getRequestDispatcher("/Main/vacation_request_list.jsp").forward(request, response);
        }
    }
}