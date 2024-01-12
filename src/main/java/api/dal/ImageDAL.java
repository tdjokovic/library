package api.dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import api.db.ConnectionProvider;

public class ImageDAL
{
    private static Connection conn = ConnectionProvider.getConn();

    public static List<String> getImagesByBookID(int bookID)
    {
        List<String> imageList = new LinkedList<String>();

        String sql = "select * from image where bookID = ?";

        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookID);

            ResultSet rs = ps.executeQuery();

            while (rs.next())
                imageList.add(rs.getString("name"));

        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return imageList;
    }
}
