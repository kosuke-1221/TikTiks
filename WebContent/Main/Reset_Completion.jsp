<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ja">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="refresh" content="2; URL=Reset.jsp">
    <title>リセット完了</title>
    <style>
	    body {
			    font-family: Arial, sans-serif;
			    margin: 0;
			    padding: 0;
			    background-color: #f5f5f5;
			}

        /* メインコンテンツエリアを調整 */
		.container {
			max-width: 450px;
		    margin: 50px auto;
		    background-color: #fff;
		    padding: 40px 20px;
		    border-radius: 10px;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    text-align: center;
		}

        .h2name {
            color: #28a745;
        }
    </style>
</head>

<body>
<c:import url="base.jsp">
<c:param name="title"></c:param>
<c:param name="scripts"></c:param>
<c:param name="content">
<section class="me-4">
    <div class="content">
            <h2 class="h2name">😊 リセットが完了しました 😊</h2>
    </div>

</section>
</c:param>
</c:import>
</body>

</html>
