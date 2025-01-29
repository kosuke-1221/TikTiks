package bean;

public class VacationRequest {
    private int id;
    private String userId;
    private String vacationDate;
    private String reason;
    private String userName; // 名前を追加
    private String phoneNumber; // 電話番号を追加

    // コンストラクタ
    public VacationRequest() {}

    public VacationRequest(String userId, String vacationDate, String reason) {
        this.userId = userId;
        this.vacationDate = vacationDate;
        this.reason = reason;
    }

    // GetterとSetter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getVacationDate() {
        return vacationDate;
    }

    public void setVacationDate(String vacationDate) {
        this.vacationDate = vacationDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}