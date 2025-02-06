<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // ユーザーIDと名前を取得（JOIN）
    java.sql.Connection conn = null;
    java.sql.PreparedStatement ps = null;
    java.sql.ResultSet rs = null;
    java.util.List<java.util.Map<String, String>> submittedList = new java.util.ArrayList<>();
    try {
        Class.forName("org.h2.Driver");
        conn = dao.Database.getConnection();
        // SHIFT_REQUESTS を users とJOINしてuser_idとnameを取得
        String sql = "SELECT DISTINCT sr.user_id, u.name FROM SHIFT_REQUESTS sr JOIN users u ON sr.user_id = u.user_id";
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
        while(rs.next()){
            java.util.Map<String, String> map = new java.util.HashMap<>();
            map.put("userID", rs.getString("user_id"));
            map.put("name", rs.getString("name"));
            submittedList.add(map);
        }
    } catch(Exception e){
        e.printStackTrace();
    } finally {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(conn != null) conn.close();
    }
    request.setAttribute("submittedList", submittedList);
%>
<c:import url="base.jsp">
    <c:param name="title" value="シフト提出リセット" />
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
                border: 1px solid #ccc;
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
                background-color: #28a745; /* デフォルトが全体リセット以外はそのまま緑へ変更 */
                color: #fff;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover { background-color: #1e7e34; }
            /* h2共通スタイル */
            h2 {
                text-align: center;
                color: #28a745;
                margin-top: 40px;
            }
        </style>
        <h2>😊 シフト提出リセット 😊</h2>
        <table>
            <tr>
                <th>ユーザーID</th>
                <th>名前</th>
                <th>操作</th>
            </tr>
            <c:forEach var="map" items="${submittedList}">
                <tr>
                    <td>${map.userID}</td>
                    <td>${map.name}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/AdminResetShiftSubmission" method="post">
                            <input type="hidden" name="userID" value="${map.userID}" />
                            <button type="submit">提出状態リセット</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <div class="button-group">
            <!-- 全体リセットボタンはこの画面にのみ表示 -->
            <form action="${pageContext.request.contextPath}/AdminDatabaseReset" method="post" style="display:inline;">
                <button type="submit">データベース全体リセット</button>
            </form>
            <button class="back-button" onclick="location.href='Reset.jsp'">前の画面に戻る</button>
        </div>
    </c:param>
</c:import>