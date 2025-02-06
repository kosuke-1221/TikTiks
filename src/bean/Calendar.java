package bean;

import java.time.LocalTime;

public class Calendar {
    private String userId;
    private String shiftDate;
    private LocalTime startTime;
    private LocalTime endTime;
    private String note;

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getShiftDate() { return shiftDate; }
    public void setShiftDate(String shiftDate) { this.shiftDate = shiftDate; }

    public LocalTime getStartTime() { return startTime; }
    public void setStartTime(LocalTime startTime) { this.startTime = startTime; }

    public LocalTime getEndTime() { return endTime; }
    public void setEndTime(LocalTime endTime) { this.endTime = endTime; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
