package study.java.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	public static Connection getConnection() {
		try {
			// String dbURL = "jdbc:mysql::/%s:%d/%s?characterEncoding=%s&serverTimezone=UTC";
			String dbURL = "jdbc:mysql://localhost:3306/TUTORIAL?useSSL=false&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
