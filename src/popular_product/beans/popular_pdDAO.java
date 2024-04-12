package popular_product.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class popular_pdDAO {
	private ArrayList<popular_product> listOfpp = new ArrayList<>(); // popular_product Ŭ���� ���� ���� �����͵��� �����ڸ� ���� �ּ�����
																		// �����Ͽ� ȣ���� �� �ְ� ����

	// popular_pdDAO �ν��Ͻ��� �ϳ��� �����ϰԲ� �̱��� ���� ���
	// popluar_pdDAO Ŭ������ �⺻ �����ڿ� ���� ��ü ���� instance ����
	private static popular_pdDAO instance = new popular_pdDAO();
	// add ������

	// popular_pdDAO �ν��Ͻ��� �����ϴ� getter �޼ҵ�
	public static popular_pdDAO getInstance() {
		return instance;
	}

	// DB ���ӿ� �ʿ��� ���
	private Connection conn = null; // DB ���� ��ü ����
	private PreparedStatement pst = null; // ���� �������� ������ �� ����ϴ� ��ü (������ �غ��ϴ� �ٱ��� ���� ��)
	private ResultSet rs = null; // Resultset : select�� ����� �����ϴ� ��ü
	private static String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // DB��
																													// ������
																													// �ּ�
	private static String id = "root"; // DB�� ������ ���̵�
	private static String password = "1234"; // DB�� ������ ��й�ȣ

	// �׸��� �������ִ� ��ü �߰�
	public ArrayList<popular_product> getProducts() {
		String sql = "select * from popular_product"; // ������ ������

		try {
			// Product.jsp (Ư�� �α� ��ǰ ������)�� �����ϴ� �� ����. �̷� �ҽ��� ���߿� Product.jsp�� �����ϴ� �� ȣ���
			conn = getConnection(); // Ŀ�ؼ� ���
			pst = conn.prepareStatement(sql); // �������� ������ ��ü ����
			rs = pst.executeQuery(); // DB�� ����Ǿ� �ִ� �α��ǰ�� ��� ������ ResultSet�� ����

			while (rs.next()) {
				popular_product pp = new popular_product(); // �� ��ü�� pp(�ν��Ͻ�ȭ, �н�)�� ���� DB���� �����´�.
				pp.setProductId(rs.getString("productId"));
				pp.setPname(rs.getString("pname"));
				pp.setUnitprice(rs.getInt("unitprice"));
				pp.setDescription(rs.getString("description"));
				pp.setManufacturer(rs.getString("manufacturer"));
				pp.setCategory(rs.getString("category"));
				pp.setNumberOfstock(rs.getLong("numberOfstock"));
				pp.setCondition(rs.getString("conditions"));
				pp.setImg_name(rs.getString("img_name"));

				listOfpp.add(pp); // Arraylist �÷��ǿ� pp �ν��Ͻ� ��ü �߰�
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pst != null)
					pst.close();
				if (conn != null)
					conn.close();
				System.out.println("DB ��������");
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return listOfpp; // �� ��ü�� ����Ǿ� ArrayList ������
	}

	// DB ���� (Connection ��ü �����ϴ� �޼ҵ�)
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // ����̹���
			conn = DriverManager.getConnection(url, id, password); // DB���� ��ü ����.
			System.out.println("DB ���� �Ϸ�");
		} catch (Exception e) {
			System.out.println("DB ���� ����");
			e.printStackTrace();
		}

		return conn;
	}

	// get ������� ���� productId ���� �޾Ƽ� �����Ѵ�.
	// listOfpp���� ����� ��� ��ǰ ����� ��ȸ�ؼ� ��ǰ ���̵�� ��ġ�ϴ� ��ǰ�� �����ϴ� �޼ҵ�
	public popular_product getProductById(String productId) {
		popular_product productById = new popular_product(); // popular_product Ŭ������ �����͵��� ȣ���ϱ� ���� Product Ŭ������ �ּ��� ����
		String sql = "select * from popular_product where productId = ?"; // ������ ������

		// Product.jsp (Ư�� �α��ǰ ������)�� �����ϴ� �� ����
		try {
			conn = getConnection(); // Ŀ�ؼ� ���
			pst = conn.prepareStatement(sql); // ������ ������ ����
			pst.setString(1, productId); // ������ ���� ù ��° ����ǥ�� ������ productId ����

			rs = pst.executeQuery(); // ���ڰ����� �Ѿ�� productId�� �ش��ϴ� �α��ǰ�� ResultSet�� ����

			if (!rs.next()) {
				return null; // ��ġ�ϴ� �α��ǰ�� ���� ����
			}

			// ���ڰ����� �Ѿ�� productId���� �ִٸ�
			if (rs.next()) {
				productById.setProductId(rs.getString("productId")); // DB�� ���� productId ���� ����
				productById.setPname(rs.getString("pname"));
				productById.setUnitprice(rs.getInt("unitprice"));
				productById.setDescription(rs.getString("description"));
				productById.setManufacturer(rs.getString("manufacturer"));
				productById.setCategory(rs.getString("category"));
				productById.setNumberOfstock(rs.getLong("numberOfstock"));
				productById.setCondition(rs.getString("conditions"));
				productById.setImg_name(rs.getString("img_name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pst != null)
					pst.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return productById;
	}

	// ��ǰ�� �߰��ϴ� �޼ҵ�
	public void addProduct(popular_product pp) {
		listOfpp.add(pp);
	}
}
