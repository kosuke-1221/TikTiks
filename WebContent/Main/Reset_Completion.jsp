<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="base.jsp" %>

<html lang="ja">

<head>
    <meta http-equiv="refresh" content="2; URL=Reset.jsp">
    <title>リセット完了</title>
    <style>
        /* メインコンテンツエリアを調整 */
        .content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 50px); /* フッターの高さを考慮して調整 */
            text-align: center;
            padding-bottom: 60px; /* フッターの上に配置するための余白 */
        }

        /* メッセージのスタイル */
        .message-container {
            text-align: center;
        }

        h2 {
            color: #28a745;
        }

        /* フッターの固定 */
        .footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            height: 50px; /* フッターの高さを設定（調整可能） */
            background: #f8f9fa; /* 背景色（base.cssと統一する） */
        }
    </style>
</head>

<body>
    <div class="content">
        <div class="message-container">
            <h2>😊 リセットが完了しました 😊</h2>
        </div>
    </div>
</body>

</html>
