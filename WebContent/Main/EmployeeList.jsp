<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // 従業員一覧を取得（user_id と name を取得）
    java.sql.Connection conn = null;
    java.sql.PreparedStatement ps = null;
    java.sql.ResultSet rs = null;
    java.util.List<java.util.Map<String, String>> employeeList = new java.util.ArrayList<>();
    try {
        Class.forName("org.h2.Driver");
        conn = dao.Database.getConnection();
        String sql = "SELECT user_id, name FROM users";
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
        while(rs.next()){
            java.util.Map<String, String> map = new java.util.HashMap<>();
            map.put("userID", rs.getString("user_id"));
            map.put("name", rs.getString("name"));
            employeeList.add(map);
        }
    } catch(Exception e){
        e.printStackTrace();
    } finally {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(conn != null) conn.close();
    }
    request.setAttribute("employeeList", employeeList);
%>
<c:import url="base.jsp">
    <c:param name="title" value="従業員パスワードリセット" />
    <c:param name="scripts" value="" />
    <c:param name="content">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: #ffffff; /* 白背景 */
                margin: 0;
                padding: 0;
            }
            h1 { text-align: center; color: #333; }
            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            th, td {
                padding: 12px;
                border: 1px solid #aaa;
                text-align: center;
            }
            .button-group {
                text-align: center;
                margin: 20px;
            }
            button {
                padding: 12px 24px;
                border: none;
                border-radius: 4px;
                background-color: #dc3545; /* 操作ボタンは赤 */
                color: #fff;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover { background-color: #c82333; }
            /* 戻るボタン専用は緑に統一 */
            .back-button {
                background-color: #28a745;
            }
            .back-button:hover {
                background-color: #1e7e34;
            }
            /* h2共通スタイル */
            h2 {
                text-align: center;
                color: #28a745;
                margin-top: 40px;
            }
        </style>
        <h2>😊 従業員パスワードリセット 😊</h2>
        <table>
            <tr>
                <th>ユーザーID</th>
                <th>名前</th>
                <th>操作</th>
            </tr>
            <c:forEach var="map" items="${employeeList}">
                <tr>
                    <td>${map.userID}</td>
                    <td>${map.name}</td>
                    <td>
                        <!-- パスワードリセット確認画面へ遷移 -->
                        <button type="button" onclick="location.href='ConfirmReset.jsp?confirmTitle=従業員パスワードリセット確認&amp;confirmMessage=従業員のパスワードをリセットしますか？&amp;actionUrl=${pageContext.request.contextPath}/AdminResetPassword?userID=${map.userID}&amp;returnUrl=${pageContext.request.contextPath}/WebContent/Main/EmployeeList.jsp'">
                            パスワードリセット
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <div class="button-group">
            <button class="back-button" onclick="location.href='Reset.jsp'">前の画面に戻る</button>
        </div>
    </c:param>
</c:import>