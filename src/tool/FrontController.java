package tool;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"*.action", "/main/*"})
public class FrontController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String path = request.getServletPath().substring(1); // /Main/Register.action => Main/Register.action
            String name = path.replace(".action", ""); // "Main/Register"
            name = name.substring(0, 1).toLowerCase() + name.substring(1); // "Main/Register" => "main/Register"
            name = name.replace('/', '.'); // "main.Register"

            name += "Action"; // "main.RegisterAction"

            System.out.println("★ servlet path -> " + request.getServletPath());
            System.out.println("★ class name ->" + name);
            Action action = (Action) Class.forName(name).getDeclaredConstructor().newInstance();
            action.execute(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/Main/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
