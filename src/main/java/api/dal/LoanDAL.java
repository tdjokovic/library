package api.dal;

import java.sql.*;
import java.time.LocalDate;
import java.util.LinkedList;
import java.util.List;

import api.db.ConnectionProvider;
import models.*;

public class LoanDAL {
    private static Connection conn = ConnectionProvider.getConn();
    public static boolean addLoan(int userID, int bookID)
    {
        LocalDate todaysDate = LocalDate.now();
        LocalDate returnDate = todaysDate.plusMonths(1);

        Integer status = 0;
        String sql = "insert into loans(bookID, userID, loanDate, returnDate, status) values(" +bookID +", " +userID +", '" +todaysDate + "', '" + returnDate + "', " + status +")";

        try
        {
            Statement st = conn.createStatement();
            st.executeUpdate(sql);
            // change book status in table
            updateBookStatus(bookID, false);
            removeWait(userID, bookID);
            return true;

        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return true;
    }

    private static boolean updateBookStatus(int bookID, boolean status)
    {
        String sql = "update book set availability = ? where bookID = ?";
        PreparedStatement ps;
        try{
            ps = conn.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, bookID);

            ps.executeUpdate();
        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return true;
    }
    private static boolean removeWait(int userID, int bookID)
    {
        Integer position = getWaitlistPosition(userID, bookID);
        String sql = "DELETE FROM waitlist where userID = ? AND bookID = ?";
        PreparedStatement ps;
        try{
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, bookID);

            ps.executeUpdate();
            updatePosition(bookID, position);
        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return true;
    }

    private static Integer getWaitlistPosition(Integer userID, Integer bookID)
    {
        String sql = "SELECT * from waitlist WHERE userID = ? AND bookID = ?";
        PreparedStatement ps;
        Integer position = -1;
        try{
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, bookID);

            ResultSet rs = ps.executeQuery();

            if(rs.next())
             position = rs.getInt("position");

        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return position;
    }

    public static boolean addWait(int userID, int bookID)
    {
        String positionSql = "select * from waitlist where bookID = ?";
        PreparedStatement ps;
        try
        {
            ps = conn.prepareStatement(positionSql);
            ps.setInt(1, bookID);

            ResultSet rs = ps.executeQuery();
            Integer position;

            if(rs.next())
            {
                // there are people on the waitlist
                position = rs.getInt("position");
                while(rs.next())
                {
                    Integer newPosition = rs.getInt("position");
                    if(newPosition > position)
                        position = newPosition;
                }
                position++;
            }
            else
            {
                // no such book you're the first to be on the waitlist
                position = 1;
            }

            String sql = "insert into waitlist(bookID, userID, position) values(" +bookID +", " +userID +", " + position +")";
            try
            {
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
                return true;

            } catch (SQLException e)
            {
                e.printStackTrace();
            }
        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return true;
    }

    public static LocalDate checkIfILoaned(int userID, int bookID)
    {
        String sql = "select * from loans where userID = ? AND bookID = ? and status = 0";
        PreparedStatement ps;
        try
        {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, bookID);
            ResultSet rs = ps.executeQuery();

            if(rs.next())
            {
                return rs.getDate("returnDate").toLocalDate();
            }

        } catch(SQLException e)
        {
            e.printStackTrace();
        }
        return null;
    }

    public static Integer checkIfImWaiting(int userID, int bookID)
    {
        String sql = "select * from waitlist where userID = ? AND bookID = ?";
        PreparedStatement ps;
        try
        {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, bookID);
            ResultSet rs = ps.executeQuery();

            if(rs.next())
            {
                return rs.getInt("position");
            }

        } catch(SQLException e)
        {
            e.printStackTrace();
        }
        return -1;
    }

    public static List<LoanModel> getLoansForUser(Integer userID)
    {
        List<LoanModel> loans = new LinkedList<>();

        String sql = "select * from loans l join book b on l.bookID = b.bookID join author a on b.authorID = a.authorID where l.userID = ? ORDER BY l.loanDate DESC";

        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);

            ResultSet rs = ps.executeQuery();

            while (rs.next())
            {
                BookModel book = new BookModel(rs.getInt("b.bookID"), rs.getString("b.name"));
                AuthorModel authorModel = new AuthorModel(rs.getString("a.firstName"), rs.getString("a.lastName"));
                loans.add(new LoanModel(book, authorModel, rs.getDate("l.loanDate").toLocalDate(), rs.getDate("l.returnDate").toLocalDate()));
            }

        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return loans;
    }

    public static List<WaitlistModel> getWaitsForUser(Integer userID)
    {
        List<WaitlistModel> waits = new LinkedList<>();

        String sql = "select * from waitlist w join book b on w.bookID = b.bookID join author a on b.authorID = a.authorID where w.userID = ? ORDER BY w.position ASC";

        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);

            ResultSet rs = ps.executeQuery();

            while (rs.next())
            {
                BookModel book = new BookModel(rs.getInt("b.bookID"), rs.getString("b.name"));
                AuthorModel authorModel = new AuthorModel(rs.getString("a.firstName"), rs.getString("a.lastName"));
                waits.add(new WaitlistModel(rs.getInt("w.waitlistID"),book, authorModel, rs.getInt("w.position")));
            }

        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return waits;
    }

    public static Integer getWaitlistCount(Integer bookID)
    {
        String sql = "select count(*) as waitlistCount from waitlist where bookID = ?";
        try{
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookID);

            ResultSet rs = ps.executeQuery();

            while(rs.next())
            {
                return rs.getInt("waitlistCount");
            }
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public static LoanModel getCurrentLoaner(Integer bookID)
    {
        String sql = "select * from loans l join user u on l.userID = u.userID join book b on l.bookID = b.bookID where l.bookID = ? AND l.status=0";
        LoanModel userLoan = null;

        try{
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookID);

            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                BookModel book = new BookModel(rs.getInt("b.bookID"), rs.getString("b.name"));
                UserModel user = new UserModel(rs.getInt("u.userID"), rs.getString("u.firstName"), rs.getString("u.lastName"));
                return new LoanModel(rs.getInt("l.loanID"),book, user, rs.getDate("l.loanDate").toLocalDate(), rs.getDate("l.returnDate").toLocalDate());
            }
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return userLoan;
    }

    public static void resolveLoan(Integer loanID, Integer bookID)
    {
        String sql = "UPDATE loans SET status=1 where loanID = ?";
        PreparedStatement ps;
        try{
            ps = conn.prepareStatement(sql);
            ps.setInt(1, loanID);
            ps.executeUpdate();
            // notify the first user on the waitlist that he can loan the book

            updateBookStatus(bookID, true);
            updatePosition(bookID, 0);
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
    }

    private static void updatePosition(Integer bookID, Integer position)
    {
        String sql = "UPDATE waitlist SET position = position - 1 where bookID = ? AND position > ?";
        PreparedStatement ps;
        try{
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bookID);
            ps.setInt(2, position);

            ps.executeUpdate();

        } catch (SQLException e){
            e.printStackTrace();
        }
    }

    public static List<WaitlistModel> getCurrentWaitlist(Integer bookID)
    {
        String sql = "select * from waitlist w join book b on w.bookID = b.bookID join user u on w.userID = u.userID where w.bookID = ? ORDER BY w.position ASC";
        List<WaitlistModel> waitlist = new LinkedList<>();

        try{
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookID);

            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                BookModel book = new BookModel(rs.getInt("b.bookID"), rs.getString("b.name"));
                UserModel user = new UserModel(rs.getInt("u.userID"), rs.getString("u.firstName"), rs.getString("u.lastName"));
                waitlist.add(new WaitlistModel(rs.getInt("w.waitlistID"), book, user, rs.getInt("w.position")));
            }
        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return waitlist;
    }

    public static void resolveWait(Integer bookID, Integer waitlistID, Integer position)
    {
        String sql = "DELETE from waitlist where waitlistID = ?";
        PreparedStatement ps;
        try{
            ps = conn.prepareStatement(sql);
            ps.setInt(1, waitlistID);

            ps.executeUpdate();
            // update the waitlist
            updatePosition(bookID, position);

        } catch (SQLException e)
        {
            e.printStackTrace();
        }
    }

    public static void withdrawWaitlist(Integer bookID, Integer userID, Integer position)
    {
        String sql = "DELETE FROM waitlist WHERE bookID = ? AND userID = ?";
        PreparedStatement ps;
        try{
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bookID);
            ps.setInt(2, userID);

            ps.executeUpdate();
            updatePosition(bookID, position);

        } catch (SQLException e){
            e.printStackTrace();
        }
    }
}
