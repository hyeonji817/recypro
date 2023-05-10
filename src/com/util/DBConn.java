package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn {
	private DBConn() {}
	
	private static Connection connection = null;
	
	public static Connection getCon() {
		if (connection == null) {
			// JDBC Driver 로딩 - Class.forName()
			String className = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
			String user = "root";
			String password = "1234";
			
			try {
				Class.forName(className);
				// Connection = DriverManager.getConnection()
				// Connection 객체를 얻어옴 
				connection = DriverManager.getConnection(url, user, password);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	// if 
		return connection;
	}	// getCon
	
	// 오버로딩 (이거 찾아봐야겠다)
	// getConnection 메소드를 통해 db 연동 구축
	public static Connection getCon(String url, String user, String password) {
		if (connection == null) {
			// 1. JDBC Driver 로딩 - Class.forName()
			String className = "com.mysql.cj.jdbc.Driver";

			try {
				Class.forName(className);
				// 2. Connection = DriverManager.getConnetion()
				// Connection 객체를 얻어온다
				connection = DriverManager.getConnection(url, user, password);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	// if
		return connection;
	}	// getCon
	
	public static void close() {
		try {
			// 연결닫기 
			if (connection != null && !connection.isClosed()) {
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		connection = null;
	}
}	// class
