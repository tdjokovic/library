package api.db;

public interface IProvider {
    String DRIVER = "com.mysql.cj.jdbc.Driver";
    String CONN_URL = "jdbc:mysql://localhost:3306/library?user=root&password=";
}
