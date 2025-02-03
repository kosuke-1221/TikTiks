package main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/get-public-key")
public class PublicKeyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 実際のVAPID公開鍵に置き換えてください
        String publicKey = "YOUR_PUBLIC_VAPID_KEY";

        response.setContentType("text/plain");
        response.getWriter().write(publicKey);
    }
}
