function togglePasswordVisibility(inputId, button) {
    const passwordInput = document.getElementById(inputId); // 押されたボタンに対応するフィールドを取得
    const type = passwordInput.type === "password" ? "text" : "password"; // パスワード表示を切り替え
    passwordInput.type = type;

    // アイコンの切り替え
    button.classList.toggle('active');
}