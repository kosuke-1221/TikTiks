package bean;

public class VacationRequest2 {
    private int id;
    private String userId;
    private String vacationDate;
    private String reason;

    // コンストラクタ
    public VacationRequest2() {}

    public VacationRequest2(String userId, String vacationDate, String reason) {
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
}
