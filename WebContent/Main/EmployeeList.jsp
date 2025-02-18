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
            /* 共通のボタンスタイル */
            .button-common {
                padding: 12px 24px;
                margin: 10px;
                border: none;
                border-radius: 4px;
                background-color: #dc3545; /* 操作ボタンは赤 */
                color: #fff;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .button-common:hover {
                background-color: #c82333;
            }
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
            /* レスポンシブ対応 */
    @media (max-width: 768px) {
        table {
            width: 100%; /* スマホなど小さい画面で幅を100%にする */
        }
        th, td {
            padding: 8px; /* スマホでの見やすさのためにパディングを調整 */
        }
        .button-common {
            padding: 10px 20px; /* ボタンのサイズを小さくしてタッチ操作をしやすく */
        }
        .button-group {
            margin: 10px; /* ボタン間のスペースを調整 */
        }
    }

    @media (max-width: 480px) {
        h2 {
            font-size: 18px; /* タイトル文字サイズを小さくして画面に収まるように */
        }
        .button-common {
            width: 90%; /* ボタンを横幅いっぱいに広げる */
        }
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
                        <button class="button-common" type="button" onclick="location.href='ConfirmReset.jsp?confirmTitle=従業員パスワードリセット確認&amp;confirmMessage=従業員のパスワードをリセットしますか？&amp;actionUrl=${pageContext.request.contextPath}/AdminResetPassword?userID=${map.userID}&amp;returnUrl=${pageContext.request.contextPath}/WebContent/Main/EmployeeList.jsp'">
                            パスワードリセット
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <div class="button-group">
            <button class="button-common back-button" onclick="location.href='Reset.jsp'">前の画面に戻る</button>
        </div>
    </c:param>
</c:import>
