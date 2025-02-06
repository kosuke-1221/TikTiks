<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="base.jsp">
    <c:param name="title" value="管理者リセット機能" />
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
            .menu {
                max-width: 600px;
                margin: 40px auto;
                padding: 20px;
                background-color: #ffffff;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                border-radius: 8px;
                text-align: center;
            }
            button {
                padding: 12px 24px;
                margin: 10px;
                border: none;
                border-radius: 4px;
                background-color: #007acc;
                color: #fff;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover { background-color: #005fa3; }
            /* 前に戻るボタン専用スタイル */
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
        <h2>😊 管理者リセット機能 😊</h2>
        <div class="menu">
            <button onclick="location.href='ResetShiftSubmission.jsp'">出勤可能日時（シフト提出）リセット</button>
            <button onclick="location.href='EmployeeList.jsp'">従業員パスワードリセット</button>
            <br>
            <button class="back-button" onclick="location.href='menu2.jsp'">前の画面に戻る</button>
        </div>
    </c:param>
</c:import>