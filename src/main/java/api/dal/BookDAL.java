package api.dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import api.db.ConnectionProvider;
import models.BookModel;

public class BookDAL
{
    private static Connection conn = ConnectionProvider.getConn();

    public static List<BookModel> getAllBooks(String filter)
    {
        List<BookModel> books = new LinkedList<BookModel>();

        String sql = "select * from book b join author a on b.authorID = a.authorID where b.name like ? OR a.firstName like ? OR a.lastName like ?";

        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" +filter +"%");
            ps.setString(2, "%" +filter +"%");
            ps.setString(3, "%" +filter +"%");
            ResultSet rs = ps.executeQuery();

            while (rs.next())
                books.add(new BookModel(rs.getInt("bookID"), rs.getString("b.name"), rs.getString("a.firstName"), rs.getString("a.lastName"), rs.getBoolean("availability")));

            for (BookModel bm : books)
            {
                bm.setImages(ImageDAL.getImagesByBookID(bm.getBookID()));
            }

        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return books;
    }

    public static BookModel getBookByID(int bookID)
    {
        String sql = "select * from book b join author a on b.authorID = a.authorID where b.bookID = ?";

        PreparedStatement ps;
        try
        {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bookID);

            ResultSet rs = ps.executeQuery();

            while (rs.next())
                return new BookModel(rs.getInt("b.bookID"), rs.getString("b.name"), rs.getString("a.firstName"), rs.getString("a.lastName"), rs.getString("b.description"), ImageDAL.getImagesByBookID(rs.getInt("b.bookID")), rs.getBoolean("availability"));

        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return null;
    }
}
