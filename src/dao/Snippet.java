package dao;

public class Snippet {
	
	以下のようにCSSを修正すると、セレクトボックスを右揃えにできます。select-form-containerに新しいスタイルを追加してください。
	
	修正版CSS:
	
	css
	コードをコピーする
	.select-form-container {
	    display: flex;
	    justify-content: flex-end; /* フォームを右揃えにする */
	    gap: 10px; /* 各フォーム間のスペースを設定 */
	    margin-bottom: 30px;
	    padding: 0 20px;
	}
	
	.select-month,
	.select-day {
	    display: flex;
	    align-items: center; /* ラベルと入力フィールドを中央揃え */
	    gap: 5px;
	}
}

