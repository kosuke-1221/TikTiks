package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;



public class Password_ChangeAction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // �t�H�[���f�[�^���擾
        String userID = (String) request.getSession().getAttribute("userID"); // ���O�C���Z�b�V��������擾
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // �p�X���[�h��v�`�F�b�N
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "�V�����p�X���[�h����v���܂���B");
            request.getRequestDispatcher("/Password_Change.jsp").forward(request, response);
            return;
        }

        // �f�[�^�x�[�X�ڑ��ƍX�V����
        String selectSql = "SELECT password FROM users WHERE user_id = ?";
        String updateSql = "UPDATE users SET password = ? WHERE user_id = ?";

        try (Connection connection = Database.getConnection();
             PreparedStatement selectStmt = connection.prepareStatement(selectSql);
             PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {

            // ���݂̃p�X���[�h���m�F
            selectStmt.setString(1, userID);
            ResultSet rs = selectStmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");

                if (!dbPassword.equals(currentPassword)) {
                    request.setAttribute("errorMessage", "���݂̃p�X���[�h������������܂���B");
                    request.getRequestDispatcher("/Password_Change.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "���[�U�[��񂪌�����܂���B");
                request.getRequestDispatcher("/Password_Change.jsp").forward(request, response);
                return;
            }

            // �V�����p�X���[�h�ɍX�V
            updateStmt.setString(1, newPassword);
            updateStmt.setString(2, userID);
            int result = updateStmt.executeUpdate();

            if (result > 0) {
                request.setAttribute("successMessage", "�p�X���[�h������ɍX�V����܂����B");
            } else {
                request.setAttribute("errorMessage", "�p�X���[�h�X�V���ɃG���[���������܂����B");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "�T�[�o�[�G���[���������܂����B");
        }

        // ���ʂ�Ԃ�
        request.getRequestDispatcher("/Password_Change.jsp").forward(request, response);
    }
}
