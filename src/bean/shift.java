package bean;

public class shift {

    private String shift_ID;
    private String user_ID;

    // shift_IDのゲッターとセッター
    public String getShift_ID() {
        return shift_ID;
    }

    public void setShift_ID(String shift_ID) {
        if (shift_ID != null && shift_ID.length() == 8) {
            this.shift_ID = shift_ID;
        } else {
            throw new IllegalArgumentException("Shift_ID must be 8 characters long");
        }
    }

    // user_IDのゲッターとセッター
    public String getUser_ID() {
        return user_ID;
    }

    public void setUser_ID(String user_ID) {
        if (user_ID != null && user_ID.length() == 7) {
            this.user_ID = user_ID;
        } else {
            throw new IllegalArgumentException("User_ID must be 7 characters long");
        }
}
}