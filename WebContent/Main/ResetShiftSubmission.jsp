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
<%
    HttpSession currentsession = request.getSession(false);
    if (currentsession == null || currentsession.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
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
            .button-common {
                padding: 12px 24px;
                border: none;
                border-radius: 4px;
                background-color: #28a745; /* デフォルトが全体リセット以外はそのまま緑へ変更 */
                color: #fff;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .button-common:hover { background-color: #1e7e34; }
            /* h2共通スタイル */
            h2 {
                text-align: center;
                color: #28a745;
                margin-top: 40px;
            }
            /* レスポンシブ対応 */
		    @media (max-width: 768px) {
		        table {
		            width: 100%;
		            margin: 10px 0;
		        }
		        th, td {
		            padding: 8px;
		        }
		        .button-common {
		            padding: 10px 20px;
		        }
		        h2 {
		            font-size: 1.5rem;
		        }
		    }

		    @media (max-width: 480px) {
		        .button-common {
		            width: 100%;
		            padding: 10px;
		        }
		        .button-group .button-common {
		            margin-bottom: 15px; /* 下のボタンとの間に隙間を追加 */
		        }
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
                        <!-- シフト提出リセット確認画面へ遷移 -->
                        <button class="button-common" type="button" onclick="location.href='ConfirmReset.jsp?confirmTitle=提出状態リセット確認&amp;confirmMessage=シフト提出状態をリセットしますか？&amp;actionUrl=${pageContext.request.contextPath}/AdminResetShiftSubmission?userID=${map.userID}&amp;returnUrl=${pageContext.request.contextPath}/WebContent/Main/ResetShiftSubmission.jsp'">
                            提出状態リセット
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <div class="button-group">
            <!-- 全体リセット確認画面へ遷移 -->
            <button type="button" class="button-common" onclick="location.href='ConfirmReset.jsp?confirmTitle=提出状態全体リセット確認&amp;confirmMessage=全てのシフト提出状態をリセットしますか？&amp;actionUrl=${pageContext.request.contextPath}/AdminResetAllShiftSubmission&amp;returnUrl=${pageContext.request.contextPath}/WebContent/Main/ResetShiftSubmission.jsp'">
                提出状態全体リセット
            </button>
            <button class="button-common" onclick="location.href='Reset.jsp'">前の画面に戻る</button>
        </div>
    </c:param>
</c:import>