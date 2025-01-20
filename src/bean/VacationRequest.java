package bean;

import java.util.ArrayList;
import java.util.List;

public class VacationRequest {
    private String userId;
    private String vacationDate;
    private String reason;

    // GetterとSetter
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

    /**
     * JSON形式の文字列からVacationRequestリストを解析するメソッド
     * @param jsonData JSONデータ
     * @return VacationRequestのリスト
     */
    public static List<VacationRequest> parseFromJsonString(String jsonData) {
        List<VacationRequest> vacationRequests = new ArrayList<>();

        // 非依存でJSONを解析するシンプルなロジック (手動解析)
        jsonData = jsonData.replace("[", "").replace("]", ""); // 配列の括弧を除去
        String[] items = jsonData.split("},\\{"); // 各オブジェクトを分割

        for (String item : items) {
            item = item.replace("{", "").replace("}", ""); // オブジェクトの括弧を除去
            String[] fields = item.split(","); // フィールドを分割

            VacationRequest request = new VacationRequest();
            for (String field : fields) {
                String[] keyValue = field.split(":");
                String key = keyValue[0].replace("\"", "").trim();
                String value = keyValue[1].replace("\"", "").trim();

                switch (key) {
                    case "userId":
                        request.setUserId(value);
                        break;
                    case "vacationDate":
                        request.setVacationDate(value);
                        break;
                    case "reason":
                        request.setReason(value);
                        break;
                }
            }

            vacationRequests.add(request);
        }

        return vacationRequests;
    }
}
