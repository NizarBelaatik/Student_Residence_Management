package utils;

public class PaymentsStatsJson {

    private float pending;
    private float overdue;
    private float paid;

    public PaymentsStatsJson(float pending, float overdue, float paid) {
        this.pending = pending;
        this.overdue = overdue;
        this.paid = paid;
    }

    public String toJson() {
        // Manually constructing JSON string
        return "{"
                + "\"pending\":" + this.pending + ","
                + "\"overdue\":" + this.overdue + ","
                + "\"paid\":" + this.paid
                + "}";
    }
}