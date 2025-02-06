<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    HttpSession currentsession = request.getSession(false);
    if (currentsession == null || currentsession.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userID = (String) currentsession.getAttribute("userID");
    boolean alreadySubmitted = false;
    try {
        Class.forName("org.h2.Driver");
        java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:h2:tcp://localhost/~/NSM", "sa", "");
        java.sql.PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM SHIFT_REQUESTS WHERE user_id = ?");
        ps.setString(1, userID);
        java.sql.ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            alreadySubmitted = rs.getInt(1) > 0;
        }
        rs.close();
        ps.close();
        conn.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
    request.setAttribute("alreadySubmitted", alreadySubmitted);
%>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>シフト希望日</title>
    <link href="shift_desired.css" rel="stylesheet" />
</head>

<body>
	<c:import url="base.jsp">
	<c:param name="title"></c:param>
	<c:param name="scripts"></c:param>
	<c:param name="content">
	<section class="me-4">
		<h1>😊シフト希望日提出😊</h1>
		<!-- 出勤可能な曜日の案内は未提出時のみ表示 -->
		<c:if test="${!alreadySubmitted}">
		    <h2>出勤可能な曜日を選んでください</h2>
		</c:if>
		<c:choose>
            <c:when test="${alreadySubmitted}">
                <!-- 自然に溶け込むスタイルに変更 -->
                <div class="message-container" style="text-align: center; padding: 30px 40px; border: 1px solid #ddd; border-radius: 12px; background: #f8f8f8;">
                    <h2 style="color: #333; margin-bottom: 15px; font-family: 'Arial', sans-serif;">シフト希望情報は既に提出されています</h2>
                    <p style="color: #666; font-size: 18px; margin-bottom: 20px; font-family: 'Arial', sans-serif;">リセットしたい場合は管理者に連絡してください。</p>
                    <button onclick="location.href='menu.jsp'" style="padding: 12px 24px; font-size: 18px; background-color: #3c8dbc; border: none; border-radius: 6px; color: #fff; cursor: pointer; transition: background-color 0.3s;">メニューへ戻る</button>
                </div>
            </c:when>
            <c:otherwise>
                <!-- まだ提出していない場合はフォームを表示 -->
	<form action="Shift_desiredServlet" method="post" id="shiftForm" onsubmit="return validateForm() && checkTimeConflicts();">
	        <div class="Monday">
	            <span>月曜日</span>
	            <label for="monday">
	                <input type="checkbox" id="monday" name="monday" value="Monday"
	                    onchange="toggleSelect('monday-start', 'monday-end')">
	            </label>
	            <select class="shiftselect" id="monday-start" name="monday-start" disabled>
	                <option value="">開始時間</option>
	                <option value="9:00">9:00</option>
	                <option value="10:00">10:00</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>

	            </select>
	            <select class="shiftselect" id="monday-end" name="monday-end" disabled>
	                <option value="">終了時間</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	                <option value="23:00">23:00</option>
	                <option value="24:00">24:00</option>
	            </select>
	        </div>

	        <div class="Tuesday">
	            <span>火曜日</span>
	            <label for="tuesday">
	                <input type="checkbox" id="tuesday" name="tuesday" value="Tuesday"
	                    onchange="toggleSelect('tuesday-start', 'tuesday-end')">
	            </label>
	            <select class="shiftselect" id="tuesday-start" name="tuesday-start" disabled>
	                <option value="">開始時間</option>
	                <option value="9:00">9:00</option>
	                <option value="10:00">10:00</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	            </select>
	            <select class="shiftselect" id="tuesday-end" name="tuesday-end" disabled>
	                <option value="">終了時間</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	                <option value="23:00">23:00</option>
	                <option value="24:00">24:00</option>
	            </select>
	        </div>

	        <div class="Wednesday">
	            <span>水曜日</span>
	            <label for="wednesday">
	                <input type="checkbox" id="wednesday" name="wednesday" value="Wednesday"
	                    onchange="toggleSelect('wednesday-start', 'wednesday-end')">
	            </label>
	            <select class="shiftselect" id="wednesday-start" name="wednesday-start" disabled>
	                <option value="">開始時間</option>
	                <option value="9:00">9:00</option>
	                <option value="10:00">10:00</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	            </select>
	            <select class="shiftselect" id="wednesday-end" name="wednesday-end" disabled>
	                <option value="">終了時間</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	                <option value="23:00">23:00</option>
	                <option value="24:00">24:00</option>
	            </select>
	        </div>

	        <div class="Thursday">
	            <span>木曜日</span>
	            <label for="thursday">
	                <input type="checkbox" id="thursday" name="thursday" value="Thursday"
	                    onchange="toggleSelect('thursday-start', 'thursday-end')">
	            </label>
	            <select class="shiftselect" id="thursday-start" name="thursday-start" disabled>
	                <option value="">開始時間</option>
	                <option value="9:00">9:00</option>
	                <option value="10:00">10:00</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	            </select>
	            <select class="shiftselect" id="thursday-end" name="thursday-end" disabled>
	                <option value="">終了時間</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	                <option value="23:00">23:00</option>
	                <option value="24:00">24:00</option>
	            </select>
	        </div>

	        <div class="Friday">
	            <span>金曜日</span>
	            <label for="friday">
	                <input type="checkbox" id="friday" name="friday" value="Friday"
	                    onchange="toggleSelect('friday-start', 'friday-end')">
	            </label>
	            <select class="shiftselect" id="friday-start" name="friday-start" disabled>
	                <option value="">開始時間</option>
	                <option value="9:00">9:00</option>
	                <option value="10:00">10:00</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	            </select>
	            <select class="shiftselect" id="friday-end" name="friday-end" disabled>
	                <option value="">終了時間</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	                <option value="23:00">23:00</option>
	                <option value="24:00">24:00</option>
	            </select>
	        </div>

	        <div class="Saturday">
	            <span>土曜日</span>
	            <label for="saturday">
	                <input type="checkbox" id="saturday" name="saturday" value="Saturday"
	                    onchange="toggleSelect('saturday-start', 'saturday-end')">
	            </label>
	            <select class="shiftselect" id="saturday-start" name="saturday-start" disabled>
	                <option value="">開始時間</option>
	                <option value="9:00">9:00</option>
	                <option value="10:00">10:00</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	            </select>
	            <select class="shiftselect" id="saturday-end" name="saturday-end" disabled>
	                <option value="">終了時間</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	                <option value="23:00">23:00</option>
	                <option value="24:00">24:00</option>
	            </select>
	        </div>

	        <div class="Sunday">
	            <span>日曜日</span>
	            <label for="sunday">
	                <input type="checkbox" id="sunday" name="sunday" value="Sunday"
	                    onchange="toggleSelect('sunday-start', 'sunday-end')">
	            </label>
	            <select class="shiftselect" id="sunday-start" name="sunday-start" disabled>
	                <option value="">開始時間</option>
	                <option value="9:00">9:00</option>
	                <option value="10:00">10:00</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	            </select>
	            <select class="shiftselect" id="sunday-end" name="sunday-end" disabled>
	                <option value="">終了時間</option>
	                <option value="11:00">11:00</option>
	                <option value="12:00">12:00</option>
	                <option value="13:00">13:00</option>
	                <option value="14:00">14:00</option>
	                <option value="15:00">15:00</option>
	                <option value="16:00">16:00</option>
	                <option value="17:00">17:00</option>
	                <option value="18:00">18:00</option>
	                <option value="19:00">19:00</option>
	                <option value="20:00">20:00</option>
	                <option value="21:00">21:00</option>
	                <option value="22:00">22:00</option>
	                <option value="23:00">23:00</option>
	                <option value="24:00">24:00</option>
	            </select>
	        </div>

	        <div class="Anytime">
	            <span>いつでも可</span>
	            <label for="always-available">
	                <input type="checkbox" id="always-available" name="always-available" value="Always-available"
	                    onchange="toggleSelect('always-available-start', 'always-available-end')">
	            </label>
	        </div>

	        <h2>自由記入欄</h2>
	        <div class="free">
	            <textarea id="free-text" name="free-reason" placeholder="自由記入欄"></textarea>
	        </div>
	        <span class="error" id="error"></span>

	        <div id="error-messages" style="display: none; color: red;"></div>
	        <button type="submit" id="sou">送信</button>
	    </form>

	    <script src="shift_desired.js"></script>
		</c:otherwise>
        </c:choose>
	</section>
	</c:param>
	</c:import>
</body>
</html>