<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>休暇希望リスト</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/Main/vacation_request_list.css' />">
</head>
<body>
<c:import url="base.jsp">
    <c:param name="title" value="休暇希望リスト"></c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <div class="container">
            <h1>😊休暇希望リスト😊</h1>
            <c:if test="${not empty errorMessage}">
                <div class="error">${errorMessage}</div>
            </c:if>
            <form method="get" action="VacationRequestList">
                <label for="month">月を選択:</label>
                <select name="month" id="month" onchange="this.form.submit()">
                    <c:forEach var="i" begin="1" end="12">
                        <option value="${i < 10 ? '0' + i : i}" <c:if test="${param.month == (i < 10 ? '0' + i : i)}">selected</c:if>>${i}月</option>
                    </c:forEach>
                </select>
            </form>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>日付</th>
                            <th>名前</th>
                            <th>理由</th>
                            <th>電話番号</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="request" items="${vacationRequests}">
                            <tr>
                                <td>${request.vacationDate}</td>
                                <td>${request.userName}</td>
                                <td>${request.reason}</td>
                                <td>${request.phoneNumber}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:param>
</c:import>
</body>
</html>