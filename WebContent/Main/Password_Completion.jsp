<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    HttpSession currentsession = request.getSession(false);
    if (currentsession == null || currentsession.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>変更完了</title>
        <link href="Password_Completion.css" rel="stylesheet" />
    </head>
    <body>
        <c:import url="base.jsp">
            <c:param name="title"></c:param>
            <c:param name="scripts"></c:param>
            <c:param name="content">
                <section class="me-4">
                    <div class="container">
                        <h1>😊変更が完了しました😊</h1>
                        <%
                            // ユーザーの役割をセッションから取得
                            Boolean role = (Boolean) session.getAttribute("AUTHORITY");
                            // "AUTHORITY" は Boolean 型
                             String targetPage = "menu2.jsp"; // デフォルトは管理者のページ
                            // もし役割が "user" （管理者ではない）であれば、従業員用ページに変更
                             if (role != null && !role) {
                                 targetPage = "menu.jsp";
                             }
                        %>
                        <button class="button" onclick="location.href='<%= request.getContextPath() %>/Main/<%= targetPage %>'">メインメニューに戻る</button>
                        <br>
                    </div>
                </section>
            </c:param>
        </c:import>
    </body>
</html>