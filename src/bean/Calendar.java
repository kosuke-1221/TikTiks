package bean;

public class Calendar {
    private String userId;
    private String shiftDate;
    private String startTime;  // String 型に変更
    private String endTime;    // String 型に変更
    private String note;

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getShiftDate() { return shiftDate; }
    public void setShiftDate(String shiftDate) { this.shiftDate = shiftDate; }

    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }

    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
