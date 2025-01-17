package action;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;
import dao.UserDao;

public class PasswordUpdateAction {

    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // �Z�b�V�������烆�[�U�[�����擾
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp"); // ���O�C�����Ă��Ȃ��ꍇ�̓��O�C���y�[�W�փ��_�C���N�g
            return;
        }

        // �t�H�[������f�[�^���擾
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // �G���[�`�F�b�N
        if (currentPassword == null || newPassword == null || currentPassword.isEmpty() || newPassword.isEmpty()) {
            response.getWriter().write("���ׂĂ̗�����͂��Ă��������B");
            return;
        }

        // �p�X���[�h�ύX����
        UserDao userDao = new UserDao();

        try {
            // ���݂̃p�X���[�h����v���邩�m�F
            User user = userDao.getUserByUserID(currentUser.getUserID());
            if (user != null && user.getPassword().equals(currentPassword)) {
                // �p�X���[�h���X�V
                user.setPassword(newPassword);
                boolean success = userDao.update(user);

                if (success) {
                    response.getWriter().write("�p�X���[�h���X�V����܂����I");
                } else {
                    response.getWriter().write("�p�X���[�h�̍X�V�Ɏ��s���܂����B");
                }
            } else {
                response.getWriter().write("���݂̃p�X���[�h���Ԉ���Ă��܂��B");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("�G���[���������܂����B");
        }
    }
}
