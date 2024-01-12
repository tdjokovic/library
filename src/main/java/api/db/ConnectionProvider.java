package api.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {
    private static Connection conn = null;

    static
    {
        try{
            Class.forName(IProvider.DRIVER);
            conn = DriverManager.getConnection(IProvider.CONN_URL);
            System.out.println("'connection success");
        }
        catch (ClassNotFoundException | SQLException e)
        {
            e.printStackTrace();
        }
    }
    public static Connection getConn()
    {
        return conn;
    }
}
