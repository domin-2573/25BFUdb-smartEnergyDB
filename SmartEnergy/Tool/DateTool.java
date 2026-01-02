package Demo.Tool;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateTool {
    
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    
    public static String formatDateTime(LocalDateTime dateTime) {
        return dateTime.format(formatter);
    }
    
    public static LocalDateTime parseDateTime(String dateTimeStr) {
        return LocalDateTime.parse(dateTimeStr, formatter);
    }
    
    public static String getCurrentDateTime() {
        return formatDateTime(LocalDateTime.now());
    }
}